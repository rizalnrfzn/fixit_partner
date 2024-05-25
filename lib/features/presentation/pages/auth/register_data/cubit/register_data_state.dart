part of 'register_data_cubit.dart';

@freezed
class RegisterDataState with _$RegisterDataState {
  const factory RegisterDataState.initial() = _Initial;
  const factory RegisterDataState.update(int index, File? profilePicture,
      List<File> images, List<File> files) = _Update;
}
