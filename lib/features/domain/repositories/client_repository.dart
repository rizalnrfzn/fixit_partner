import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';

abstract class ClientRepository {
  Future<Either<Failure, Client>> getClient(GetClientParams params);

  Future<Either<Failure, List<Client>>> getClients();
}
