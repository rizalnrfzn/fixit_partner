part of 'order_cubit.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.loading() = _Loading;
  const factory OrderState.failure(String message) = _Failure;
  const factory OrderState.success(List<RepairOrder> orders) = _Success;
}
