import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import '../../../core/core.dart';
import '../../features.dart';

abstract class AuthRemoteDatasource {
  Future<Either<Failure, AuthUserModel>> login(LoginParams params);

  Future<Either<Failure, AuthUserModel>> register(RegisterParams params);

  Future<Either<Failure, AuthUserModel>> registerData(
      RegisterDataParams params);

  Future<Either<Failure, AuthUserModel>> editProfile(EditProfileParams params);

  Stream<AuthUserModel> streamAuthUser(String uid);

  Future<Either<Failure, AuthUserModel>> online(AuthUser params);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance.ref('technician');

  final _collRef = FirebaseFirestore.instance
      .collection('technician')
      .withConverter<AuthUserModel>(
          fromFirestore: AuthUserModel.fromFirestore,
          toFirestore: AuthUserModel.toFirestore);

  @override
  Future<Either<Failure, AuthUserModel>> login(LoginParams params) async {
    try {
      final account = await _auth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      final accountData = await _collRef.doc(account.user!.uid).get();

      if (!(accountData.exists)) {
        return Left(AuthFailure('Akun Sudah terdaftar sebagai pengguna'));
      }

      return Right(accountData.data()!);
    } on FirebaseException catch (e) {
      return Left(AuthFailure(e.code));
    }
  }

  @override
  Future<Either<Failure, AuthUserModel>> registerData(
      RegisterDataParams params) async {
    try {
      final account = _auth.currentUser!;
      final imageRef = _storage.child(account.uid).child('images');
      final filesRef = _storage.child(account.uid).child('files');
      String profilePicture;
      List<String> images = [];
      List<String> files = [];

      if (params.profilePicture != null) {
        await imageRef
            .child('profilePicture.png')
            .putFile(params.profilePicture!);
        profilePicture =
            await imageRef.child('profilePicture.png').getDownloadURL();
      } else {
        profilePicture =
            'https://firebasestorage.googleapis.com/v0/b/fixit-1c96e.appspot.com/o/no-profile-picture.png?alt=media&token=4704d7ed-e468-4cfd-9ffa-ef04b1efdf54';
      }

      if (params.images.isNotEmpty) {
        for (var i = 0; i < params.images.length; i++) {
          await imageRef.child('$i.png').putFile(params.images[i]);
          final linkImages = await imageRef.child('$i.png').getDownloadURL();
          images.add(linkImages);
        }
      }

      if (params.files.isNotEmpty) {
        for (var i = 0; i < params.files.length; i++) {
          await filesRef
              .child(basename(params.files[i].path))
              .putFile(params.files[i]);

          final linkFile = await filesRef
              .child(basename(params.files[i].path))
              .getDownloadURL();

          files.add(linkFile);
        }
      }

      final data = params.userData.toModel().copyWith(
          profilePicture: profilePicture, images: images, files: files);

      await _collRef.doc(account.uid).update(data.toJson());

      return Right(data);
    } on FirebaseException catch (e) {
      return Left(AuthFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, AuthUserModel>> editProfile(
      EditProfileParams params) async {
    try {
      final account = _auth.currentUser!;
      final imageRef = _storage.child('${account.uid}/profilePicture.png');
      String profilePicture;
      List<String> images = [];

      if (params.newProfilePicture != null) {
        await imageRef.putFile(params.newProfilePicture!);
        profilePicture = await imageRef.getDownloadURL();
      } else {
        profilePicture = params.userData.profilePicture!;
      }

      if (params.newImages.isNotEmpty) {
        for (var i = 0; i < params.newImages.length; i++) {
          await imageRef.child('$i.png').putFile(params.newImages[i]);
          final linkImages = await imageRef.child('$i.png').getDownloadURL();
          images.add(linkImages);
        }
      }

      final data = params.userData
          .copyWith(profilePicture: profilePicture, images: images)
          .toModel();

      await _collRef.doc(account.uid).update(data.toJson());

      return Right(data);
    } on FirebaseException catch (e) {
      return Left(AuthFailure(e.code));
    }
  }

  @override
  Future<Either<Failure, AuthUserModel>> register(RegisterParams params) async {
    try {
      final account = await _auth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      final data = AuthUserModel(
        uid: account.user!.uid,
        email: params.email,
        inOrder: false,
        isOnline: false,
        isVerified: false,
        isRegistered: false,
        rating: 0,
        numberOfReviews: 0,
        profilePicture:
            'https://firebasestorage.googleapis.com/v0/b/fixit-1c96e.appspot.com/o/no-profile-picture.png?alt=media&token=4704d7ed-e468-4cfd-9ffa-ef04b1efdf54',
      );

      await _collRef.doc(account.user!.uid).set(data);

      return Right(data);
    } on FirebaseException catch (e) {
      return Left(AuthFailure(e.code));
    }
  }

  @override
  Stream<AuthUserModel> streamAuthUser(String uid) async* {
    try {
      yield* _collRef.doc(uid).snapshots().map((event) {
        if (event.exists) {
          return event.data()!;
        } else {
          throw 'User not Found';
        }
      });
    } catch (e) {
      yield* Stream<AuthUserModel>.error(e);
    }
  }

  @override
  Future<Either<Failure, AuthUserModel>> online(AuthUser params) async {
    try {
      final account = _auth.currentUser!;

      final dataUpdate = {'isOnline': !(params.isOnline!)};

      await FirebaseFirestore.instance
          .collection('technician')
          .doc(account.uid)
          .update(dataUpdate);

      return right(params.copyWith(isOnline: !(params.isOnline!)).toModel());
    } on FirebaseException catch (e) {
      return left(FirestoreFailure(e.code));
    } catch (e) {
      return left(FirestoreFailure(e.toString()));
    }
  }
}
