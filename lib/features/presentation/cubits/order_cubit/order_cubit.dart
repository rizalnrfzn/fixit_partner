import 'dart:async';

import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_cubit.freezed.dart';
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(
    this._streamOrders,
    this._acceptOrder,
    this._rejectOrder,
    this._arrive,
    this._checkingElectronic,
    this._electronicRepair,
    this._paymentConfirmation,
  ) : super(const OrderState.initial());

  final StreamRepairOrdersUsecase _streamOrders;
  final AcceptOrderUsecase _acceptOrder;
  final RejectOrderUsecase _rejectOrder;
  final ArriveUsecase _arrive;
  final CheckingElectronicUsecase _checkingElectronic;
  final ElectronicRepairUsecase _electronicRepair;
  final PaymentConfirmationUsecase _paymentConfirmation;

  StreamSubscription? _ordersSubscription;
  List<RepairOrder> orders = [];

  void streamOrders(String uid) async {
    orders = [];
    _ordersSubscription?.cancel();
    _ordersSubscription = _streamOrders.call(uid).listen((event) {
      orders = event;
      orders.sort(
        (a, b) => a.dateTime!.compareTo(b.dateTime!),
      );

      emit(_Stream(orders));
    });
  }

  Future<void> acceptOrder(RepairOrder params) async {
    final response = await _acceptOrder.call(params);

    response.fold((l) {
      if (l is FirestoreFailure) {
        emit(_Failure(l.code));
      }
    }, (r) => r);
  }

  Future<void> rejectOrder(RepairOrder params) async {
    final response = await _rejectOrder.call(params);

    response.fold((l) {
      if (l is FirestoreFailure) {
        emit(_Failure(l.code));
      }
    }, (r) => r);
  }

  Future<void> arrive(RepairOrder params) async {
    final response = await _arrive.call(params);

    response.fold((l) {
      if (l is FirestoreFailure) {
        emit(_Failure(l.code));
      }
    }, (r) => r);
  }

  Future<void> checkingElectronic(RepairOrder params) async {
    final response = await _checkingElectronic.call(params);

    response.fold((l) {
      if (l is FirestoreFailure) {
        emit(_Failure(l.code));
      }
    }, (r) => r);
  }

  Future<void> electronicRepair(RepairOrder params) async {
    final response = await _electronicRepair.call(params);

    response.fold((l) {
      if (l is FirestoreFailure) {
        emit(_Failure(l.code));
      }
    }, (r) => r);
  }

  Future<void> paymentConfirmation(RepairOrder params) async {
    final response = await _paymentConfirmation.call(params);

    response.fold((l) {
      if (l is FirestoreFailure) {
        emit(_Failure(l.code));
      }
    }, (r) => r);
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}
