import 'package:fixit_partner/features/features.dart';

abstract class ElectronicRepository {
  Stream<List<Electronic>> streamElectronics();
}
