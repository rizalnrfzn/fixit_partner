import 'package:fixit_partner/features/features.dart';

class StreamElectronicsUsecase {
  final ElectronicRepository _repository;

  StreamElectronicsUsecase(this._repository);

  Stream<List<Electronic>> call() => _repository.streamElectronics();
}
