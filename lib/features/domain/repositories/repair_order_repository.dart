import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';

abstract class RepairOrderRepository {
  Stream<List<RepairOrder>> streamOrders(String uid);

  Future<Either<Failure, RepairOrder>> postOrder(PostOrderParams params);

  Future<Either<Failure, RepairOrder>> acceptOrder(RepairOrder params);

  Future<Either<Failure, RepairOrder>> rejectOrder(RepairOrder params);

  Future<Either<Failure, RepairOrder>> arriveOrder(RepairOrder params);

  Future<Either<Failure, RepairOrder>> checkingOrder(RepairOrder params);

  Future<Either<Failure, RepairOrder>> electronicRepair(RepairOrder params);

  Future<Either<Failure, RepairOrder>> paymentConfirmation(RepairOrder params);

  Future<Either<Failure, RepairOrder>> cancelOrder(RepairOrder params);
}
