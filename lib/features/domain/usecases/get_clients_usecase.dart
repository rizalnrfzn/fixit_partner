import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';

class GetClientsUsecase extends UseCase<List<Client>, NoParams> {
  final ClientRepository _repository;

  GetClientsUsecase(this._repository);

  @override
  Future<Either<Failure, List<Client>>> call(NoParams params) =>
      _repository.getClients();
}
