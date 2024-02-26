import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';

class PaymentConfirmationUsecase extends UseCase<RepairOrder, RepairOrder> {
  final RepairOrderRepository _repository;

  PaymentConfirmationUsecase(this._repository);

  @override
  Future<Either<Failure, RepairOrder>> call(RepairOrder params) =>
      _repository.paymentConfirmation(params);
}
