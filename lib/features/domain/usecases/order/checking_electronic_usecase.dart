import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';

class CheckingElectronicUsecase extends UseCase<RepairOrder, RepairOrder> {
  final RepairOrderRepository _repository;

  CheckingElectronicUsecase(this._repository);

  @override
  Future<Either<Failure, RepairOrder>> call(RepairOrder params) =>
      _repository.checkingOrder(params);
}
