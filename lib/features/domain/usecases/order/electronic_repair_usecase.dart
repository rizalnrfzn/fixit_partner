import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';

class ElectronicRepairUsecase extends UseCase<RepairOrder, RepairOrder> {
  final RepairOrderRepository _repository;

  ElectronicRepairUsecase(this._repository);

  @override
  Future<Either<Failure, RepairOrder>> call(RepairOrder params) =>
      _repository.electronicRepair(params);
}
