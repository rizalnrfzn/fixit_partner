import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';

class ArriveUsecase extends UseCase<RepairOrder, RepairOrder> {
  final RepairOrderRepository _repository;

  ArriveUsecase(this._repository);

  @override
  Future<Either<Failure, RepairOrder>> call(RepairOrder params) =>
      _repository.arriveOrder(params);
}
