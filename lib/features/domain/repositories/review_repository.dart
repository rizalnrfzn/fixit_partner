import 'package:fixit_partner/features/domain/domain.dart';

abstract class ReviewRepository {
  Stream<List<Review>> streamReviews(String uid);
}
