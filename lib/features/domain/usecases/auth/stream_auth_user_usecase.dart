import 'package:fixit_partner/features/features.dart';

class StreamAuthUserUsecase {
  final AuthRepository _repository;

  StreamAuthUserUsecase(this._repository);

  Stream<AuthUser> call(String uid) => _repository.streamUser(uid);
}
