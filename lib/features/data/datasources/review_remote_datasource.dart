import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit_partner/features/features.dart';

abstract class ReviewRemoteDatasource {
  Stream<List<ReviewModel>> streamReviews(String uid);
}

class ReviewRemoteDatasourceImpl implements ReviewRemoteDatasource {
  @override
  Stream<List<ReviewModel>> streamReviews(String uid) async* {
    final collRef = FirebaseFirestore.instance
        .collection('technician')
        .doc(uid)
        .collection('review')
        .withConverter(
          fromFirestore: ReviewModel.fromFirestore,
          toFirestore: ReviewModel.toFirestore,
        );

    try {
      yield* collRef.orderBy('dateTime', descending: true).snapshots().map(
            (event) => event.docs
                .map(
                  (e) => e.data(),
                )
                .toList(),
          );
    } catch (e) {
      yield* Stream.error(e);
    }
  }
}
