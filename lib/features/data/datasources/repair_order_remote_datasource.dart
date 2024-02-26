import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/utils.dart';

abstract class RepairOrderRemoteDatasource {
  Stream<List<RepairOrderModel>> streamRepairOrders(String uid);

  Future<Either<Failure, RepairOrderModel>> postOrder(PostOrderParams params);

  Future<Either<Failure, RepairOrderModel>> acceptOrder(RepairOrder params);

  Future<Either<Failure, RepairOrderModel>> rejectOrder(RepairOrder params);

  Future<Either<Failure, RepairOrderModel>> arriveOrder(RepairOrder params);

  Future<Either<Failure, RepairOrderModel>> checkingOrder(RepairOrder params);

  Future<Either<Failure, RepairOrderModel>> electronicRepair(
      RepairOrder params);

  Future<Either<Failure, RepairOrderModel>> paymentConfirmation(
      RepairOrder params);
}

class RepairOrderRemoteDatasourceImpl implements RepairOrderRemoteDatasource {
  final firebase = FirebaseFirestore.instance;
  final _collRef = FirebaseFirestore.instance.collection('order').withConverter(
        fromFirestore: RepairOrderModel.fromFirestore,
        toFirestore: RepairOrderModel.toFirestore,
      );

  final _storage = FirebaseStorage.instance.ref('order');
  final _auth = FirebaseAuth.instance;

  @override
  Stream<List<RepairOrderModel>> streamRepairOrders(String uid) async* {
    try {
      yield* _collRef
          .where('technicianUid', isEqualTo: _auth.currentUser!.uid)
          .snapshots()
          .map(
            (event) => event.docs
                .map(
                  (e) => e.data().copyWith(id: e.id),
                )
                .toList(),
          );
    } catch (e) {
      yield* Stream.error(e);
    }
  }

  @override
  Future<Either<Failure, RepairOrderModel>> postOrder(
      PostOrderParams params) async {
    try {
      List<String> listFile = [];

      final DateTime dateTime = DateTime.now();

      RepairOrderModel order =
          params.order.copyWith(dateTime: dateTime).toModel();

      final dataRef = await _collRef.add(order);

      if (params.files.isNotEmpty) {
        for (var i = 0; i < params.files.length; i++) {
          await _storage
              .child('/${dataRef.id}/$i.png')
              .putFile(params.files[i]);

          String url =
              await _storage.child('/${dataRef.id}/$i.png').getDownloadURL();

          listFile.add(url);
        }
      }

      order = order.copyWith(id: dataRef.id, electronicPicture: listFile);

      await _collRef.doc(dataRef.id).update(order.toJson());

      final data = await _collRef.doc(dataRef.id).get();

      return Right(data.data()!);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure(e.code));
    }
  }

  @override
  Future<Either<Failure, RepairOrderModel>> acceptOrder(
      RepairOrder params) async {
    try {
      await FirebaseFirestore.instance
          .collection('order')
          .doc(params.id)
          .update({'status': Status.menungguTeknisi.name});

      return right(
        params.copyWith(status: Status.menungguTeknisi.name).toModel(),
      );
    } on FirebaseException catch (e) {
      return left(FirestoreFailure(e.code));
    } catch (e) {
      return left(FirestoreFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RepairOrderModel>> rejectOrder(
      RepairOrder params) async {
    try {
      await firebase.collection('order').doc(params.id).update(
        {'canceled': true, 'reasonCancelled': params.reasonCancelled},
      );

      return right(
        params.copyWith(status: Status.menungguTeknisi.name).toModel(),
      );
    } on FirebaseException catch (e) {
      return left(FirestoreFailure(e.code));
    } catch (e) {
      return left(FirestoreFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RepairOrderModel>> arriveOrder(
      RepairOrder params) async {
    try {
      await firebase.collection('order').doc(params.id).update({
        'status': Status.pengecekanElektronik.name,
      });

      return right(
        params.copyWith(status: Status.pengecekanElektronik.name).toModel(),
      );
    } on FirebaseException catch (e) {
      return left(FirestoreFailure(e.code));
    } catch (e) {
      return left(FirestoreFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RepairOrderModel>> checkingOrder(
      RepairOrder params) async {
    try {
      await firebase.collection('order').doc(params.id).update({
        'damage': params.damage,
        'repairCost': params.repairCost,
        'totalCost': params.totalCost,
        'status': Status.konfirmasiPerbaikan.name,
      });

      return right(
        params
            .copyWith(
              status: Status.konfirmasiPerbaikan.name,
              damage: params.damage,
              repairCost: params.repairCost,
              totalCost: params.totalCost,
            )
            .toModel(),
      );
    } on FirebaseException catch (e) {
      return left(FirestoreFailure(e.code));
    } catch (e) {
      return left(FirestoreFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RepairOrderModel>> electronicRepair(
      RepairOrder params) async {
    try {
      await firebase.collection('order').doc(params.id).update({
        'status': Status.pembayaran.name,
      });

      return right(
        params
            .copyWith(
              status: Status.pembayaran.name,
            )
            .toModel(),
      );
    } on FirebaseException catch (e) {
      return left(FirestoreFailure(e.code));
    } catch (e) {
      return left(FirestoreFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RepairOrderModel>> paymentConfirmation(
      RepairOrder params) async {
    try {
      await firebase.collection('order').doc(params.id).update({
        'status': Status.beriUlasan.name,
      });

      return right(
        params
            .copyWith(
              status: Status.beriUlasan.name,
            )
            .toModel(),
      );
    } on FirebaseException catch (e) {
      return left(FirestoreFailure(e.code));
    } catch (e) {
      return left(FirestoreFailure(e.toString()));
    }
  }
}
