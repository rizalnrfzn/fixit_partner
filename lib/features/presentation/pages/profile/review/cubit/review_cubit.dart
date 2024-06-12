import 'dart:async';

import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/domain/domain.dart';
import 'package:fixit_partner/features/domain/usecases/stream_review_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_state.dart';
part 'review_cubit.freezed.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit(this._streamReviews, this._getClient)
      : super(const ReviewState.loading());

  final StreamReviewUsecase _streamReviews;
  final GetClientUsecase _getClient;

  StreamSubscription? _reviewSubscription;

  List<Review> reviews = [];

  void streamReview(String uid) {
    emit(const _Loading());
    reviews = [];
    _reviewSubscription?.cancel();
    _reviewSubscription = _streamReviews.call(uid).listen((event) async {
      List<Review> reviewsNew = [];
      for (var review in event) {
        final client = await getClient(review.clientUid!);

        reviewsNew.add(review.copyWith(
            clientName: client?.name, clientPicture: client?.profilePicture));
      }
      reviews = reviewsNew;

      emit(_ReviewStream(reviews));
    });
  }

  Future<Client?> getClient(String uid) async {
    final client = await _getClient.call(GetClientParams(uid));

    return client.fold(
      (l) {
        if (l is FirestoreFailure) {
          emit(_Failure(l.code));
        }
        return null;
      },
      (r) => r,
    );
  }

  @override
  Future<void> close() {
    reviews = [];
    _reviewSubscription?.cancel();
    return super.close();
  }
}
