part of 'income_cubit.dart';

@freezed
class IncomeState with _$IncomeState {
  const factory IncomeState.initial() = _Initial;
  const factory IncomeState.loading() = _Loading;
  const factory IncomeState.success() = _Success;
  const factory IncomeState.failure(String message) = _Failure;
}
