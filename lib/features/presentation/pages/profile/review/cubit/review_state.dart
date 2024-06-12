part of 'review_cubit.dart';

@freezed
class ReviewState with _$ReviewState {
  const factory ReviewState.loading() = _Loading;
  const factory ReviewState.failure(String message) = _Failure;
  const factory ReviewState.reviewStream(List<Review> reviews) = _ReviewStream;
}
