import 'package:fixit_partner/features/domain/entities/review.dart';
import 'package:fixit_partner/features/domain/repositories/review_repository.dart';

import '../datasources/review_remote_datasource.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDatasource _datasource;

  ReviewRepositoryImpl(this._datasource);

  @override
  Stream<List<Review>> streamReviews(String uid) async* {
    try {
      yield* _datasource.streamReviews(uid).map(
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
}
