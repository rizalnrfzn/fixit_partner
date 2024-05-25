import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_data_state.dart';
part 'register_data_cubit.freezed.dart';

class RegisterDataCubit extends Cubit<RegisterDataState> {
  RegisterDataCubit() : super(const _Update(0, null, [], []));

  int index = 0;
  List<File> images = [];
  List<File> files = [];
  File? profilePicture;

  void nextStep() {
    index += 1;
    emit(_Update(index, profilePicture, images, files));
  }

  void backStep() {
    index -= 1;
    emit(_Update(index, profilePicture, images, files));
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
      emit(_Update(index, profilePicture, images, files));
    } else {
      if (images.isEmpty) {
        emit(_Update(index, profilePicture, images, files));
      }
    }
  }

  void pickFiles() async {
    emit(const _Initial());
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
      allowCompression: true,
      allowMultiple: true,
    );
    if (result != null) {
      final filesData = result.paths.map((e) => File(e!)).toList();
      files.addAll(filesData);
      emit(_Update(index, profilePicture, images, files));
    } else {
      if (files.isEmpty) {
        emit(_Update(index, profilePicture, images, files));
      }
    }
  }

  void pickProfilePicture() async {
    emit(const _Initial());
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path!);
      profilePicture = file;
      emit(_Update(index, profilePicture, images, files));
    } else {
      if (profilePicture == null) {
        emit(_Update(index, profilePicture, images, files));
      }
    }
  }

  void removeFiles(int index) {
    emit(const _Initial());
    files.removeAt(index);
    emit(_Update(index, profilePicture, images, files));
  }

  void removeImages(int index) {
    emit(const _Initial());
    images.removeAt(index);
    emit(_Update(index, profilePicture, images, files));
  }
}
