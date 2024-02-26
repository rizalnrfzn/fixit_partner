import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';

class GetClientUsecase extends UseCase<Client, GetClientParams> {
  final ClientRepository _repository;

  GetClientUsecase(this._repository);

  @override
  Future<Either<Failure, Client>> call(GetClientParams params) =>
      _repository.getClient(params);
}

class GetClientParams {
  final String uid;

  GetClientParams(this.uid);
}
