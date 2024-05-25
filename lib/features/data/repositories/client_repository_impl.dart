import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/error/failure.dart';
import 'package:fixit_partner/features/features.dart';

class ClientRepositoryImpl implements ClientRepository {
  final ClientRemoteDatasource datasource;

  ClientRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, Client>> getClient(GetClientParams params) async {
    final response = await datasource.getClient(params);

    return response.fold(
      (l) => Left(l),
      (r) => Right(r.toEntity()),
    );
  }

  @override
  Future<Either<Failure, List<Client>>> getClients() async {
    final response = await datasource.getClients();

    return response.fold(
      (l) => left(l),
      (r) => right(r.map((e) => e.toEntity()).toList()),
    );
  }
}
