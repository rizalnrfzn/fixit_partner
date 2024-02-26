import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';

abstract class ClientRemoteDatasource {
  Future<Either<Failure, ClientModel>> getClient(GetClientParams params);

  Future<Either<Failure, List<ClientModel>>> getClients();
}

class ClientRemoteDatasourceImpl implements ClientRemoteDatasource {
  final _collRef =
      FirebaseFirestore.instance.collection('client').withConverter(
            fromFirestore: ClientModel.fromFirestore,
            toFirestore: ClientModel.toFirestore,
          );

  @override
  Future<Either<Failure, ClientModel>> getClient(GetClientParams params) async {
    try {
      final doc = await _collRef.doc(params.uid).get();

      return Right(doc.data()!);
    } catch (e) {
      return Left(FirestoreFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ClientModel>>> getClients() async {
    try {
      final doc = await _collRef.where('isRegistered', isEqualTo: true).get();

      final listClient = doc.docs.map((e) => e.data()).toList();

      return right(listClient);
    } catch (e) {
      return left(FirestoreFailure(e.toString()));
    }
  }
}
