import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';

class AcceptOrderUsecase extends UseCase<RepairOrder, RepairOrder> {
  final RepairOrderRepository _repository;

  AcceptOrderUsecase(this._repository);

  @override
  Future<Either<Failure, RepairOrder>> call(RepairOrder params) =>
      _repository.acceptOrder(params);
}
