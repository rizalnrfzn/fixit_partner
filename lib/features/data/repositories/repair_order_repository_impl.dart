import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/error/failure.dart';
import 'package:fixit_partner/features/features.dart';

class RepairOrderRepositoryImpl implements RepairOrderRepository {
  final RepairOrderRemoteDatasource _datasource;

  RepairOrderRepositoryImpl(this._datasource);

  @override
  Stream<List<RepairOrder>> streamOrders(String uid) async* {
    try {
      yield* _datasource.streamRepairOrders(uid).map(
            (event) => event
                .map(
                  (e) => e.toEntity(),
                )
                .toList(),
          );
    } catch (e) {
      yield* Stream.error(e);
    }
  }

  @override
  Future<Either<Failure, RepairOrder>> postOrder(PostOrderParams params) async {
    final response = await _datasource.postOrder(params);

    return response.fold(
      (l) => Left(l),
      (r) => Right(r.toEntity()),
    );
  }

  @override
  Future<Either<Failure, RepairOrder>> acceptOrder(RepairOrder params) async {
    final response = await _datasource.acceptOrder(params);

    return response.fold(
      (l) => left(l),
      (r) => Right(r.toEntity()),
    );
  }

  @override
  Future<Either<Failure, RepairOrder>> rejectOrder(RepairOrder params) async {
    final response = await _datasource.rejectOrder(params);

    return response.fold(
      (l) => left(l),
      (r) => Right(r.toEntity()),
    );
  }

  @override
  Future<Either<Failure, RepairOrder>> arriveOrder(RepairOrder params) async {
    final response = await _datasource.arriveOrder(params);

    return response.fold(
      (l) => left(l),
      (r) => right(r.toEntity()),
    );
  }

  @override
  Future<Either<Failure, RepairOrder>> checkingOrder(RepairOrder params) async {
    final response = await _datasource.checkingOrder(params);

    return response.fold(
      (l) => left(l),
      (r) => right(r.toEntity()),
    );
  }

  @override
  Future<Either<Failure, RepairOrder>> electronicRepair(
      RepairOrder params) async {
    final response = await _datasource.electronicRepair(params);

    return response.fold(
      (l) => left(l),
      (r) => right(r.toEntity()),
    );
  }

  @override
  Future<Either<Failure, RepairOrder>> paymentConfirmation(
      RepairOrder params) async {
    final response = await _datasource.paymentConfirmation(params);

    return response.fold(
      (l) => left(l),
      (r) => right(r.toEntity()),
    );
  }

  @override
  Future<Either<Failure, RepairOrder>> cancelOrder(RepairOrder params) async {
    final response = await _datasource.cancelOrder(params);

    return response.fold(
      (l) => left(l),
      (r) => right(r.toEntity()),
    );
  }
}
