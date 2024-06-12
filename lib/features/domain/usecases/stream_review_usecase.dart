import 'package:fixit_partner/features/domain/domain.dart';
import 'package:fixit_partner/features/domain/repositories/review_repository.dart';

class StreamReviewUsecase {
  final ReviewRepository _reviewRepository;

  StreamReviewUsecase(this._reviewRepository);

  Stream<List<Review>> call(String uid) => _reviewRepository.streamReviews(uid);
}
