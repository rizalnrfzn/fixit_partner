import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import '../../../../../utils/utils.dart';
import '../../../features.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._postLogin,
    this._streamUser,
    this._postRegister,
    this._registerDataUsecase,
    this._editProfileUsecase,
    this._onlineUsecase,
  ) : super(const _Loading());

  final LoginUsecase _postLogin;
  final RegisterUsecase _postRegister;
  final RegisterDataUsecase _registerDataUsecase;
  final EditProfileUsecase _editProfileUsecase;
  final OnlineUsecase _onlineUsecase;

  final StreamAuthUserUsecase _streamUser;

  StreamSubscription? _authUserSubscription;
  AuthUser? authUser;

  void streamUser(String uid) {
    _authUserSubscription?.cancel();
    _authUserSubscription = _streamUser.call(uid).listen((event) {
      authUser = event;
      MainBoxMixin.mainBox!.put(MainBoxKeys.authUserId.name, event.uid);
      MainBoxMixin.mainBox!
          .put(MainBoxKeys.isRegistered.name, event.isRegistered);
      MainBoxMixin.mainBox!.put(MainBoxKeys.isVerified.name, event.isVerified);
      emit(_StreamUser(authUser));
      emit(_SuccessLogin(authUser));
    });
  }

  Future<void> login(LoginParams params) async {
    emit(const _Loading());
    final data = await _postLogin.call(params);

    data.fold(
      (l) {
        if (l is AuthFailure) {
          emit(_Failure(l.code));
        }
      },
      (r) {
        streamUser(r.uid!);
      },
    );
  }

  Future<void> register(RegisterParams params) async {
    emit(const _Loading());
    final data = await _postRegister.call(params);
    data.fold(
      (l) {
        if (l is AuthFailure) {
          emit(_Failure(l.code));
        }
      },
      (r) => emit(_SuccessRegister(r)),
    );
  }

  Future<void> registerData(RegisterDataParams params) async {
    emit(const _Loading());
    final data = await _registerDataUsecase.call(params);
    data.fold(
      (l) {
        if (l is AuthFailure) {
          emit(_Failure(l.code));
        }
      },
      (r) => emit(_SuccessRegisterData(r)),
    );
  }

  Future<void> editProfile(EditProfileParams params) async {
    emit(const _Loading());
    final data = await _editProfileUsecase.call(params);
    data.fold((l) {
      if (l is AuthFailure) {
        emit(_Failure(l.code));
      }
    }, (r) => emit(_SuccessEditProfile(r)));
  }

  Future<void> online(AuthUser params) async {
    final response = await _onlineUsecase.call(params);

    response.fold(
      (l) {
        if (l is FirestoreFailure) {
          emit(_Failure(l.code));
        }
      },
      (r) => r,
    );
  }

  Future<void> logout() async {
    emit(const _Loading());
    FirebaseAuth.instance.signOut();
    await MainBoxMixin().logoutBox();
    emit(const _LogedOut());
  }

  @override
  Future<void> close() {
    _authUserSubscription?.cancel();
    return super.close();
  }
}
