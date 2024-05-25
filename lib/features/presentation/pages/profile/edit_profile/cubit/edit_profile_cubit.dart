import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fixit_partner/features/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_profile_state.dart';
part 'edit_profile_cubit.freezed.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(const EditProfileState.initial());

  File? picture;
  List<dynamic> images = [];
  List<String> oldImages = [];
  List<File> newImages = [];

  void openPage(AuthUser user) {
    images.clear();
    images.addAll(user.images!);
    oldImages.clear();
    oldImages.addAll(user.images!);
    emit(const _Success());
  }

  void pickProfilePicture() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path!);
      picture = file;
      emit(const _Success());
    } else {
      if (picture == null) {
        emit(const _Initial());
      }
    }
  }

  void pickImages() async {
    emit(const _Initial());
    final result = await FilePicker.platform.pickFiles(
      type: FileType.media,
      allowCompression: true,
      allowMultiple: true,
    );
    if (result != null) {
      final imagesData = result.paths.map((e) => File(e!)).toList();
      images.addAll(imagesData);
      newImages.clear();
      newImages.addAll(images.whereType<File>());
      emit(const _Success());
    } else {
      if (images.isEmpty) {
        emit(const _Success());
      }
    }
  }

  void removeImages(int index) {
    emit(const _Initial());
    images.removeAt(index);
    newImages.clear();
    newImages.addAll(images.whereType<File>());
    oldImages.clear();
    oldImages.addAll(images.whereType<String>());
    emit(const _Success());
  }
}
