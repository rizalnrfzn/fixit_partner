import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_cubit.freezed.dart';
part 'client_state.dart';

class ClientCubit extends Cubit<ClientState> {
  ClientCubit(this._getClients) : super(const _Initial());

  final GetClientsUsecase _getClients;

  List<Client> clients = [];

  Future<void> getClients() async {
    final response = await _getClients.call(NoParams());

    response.fold(
      (l) {
        if (l is FirestoreFailure) {
          emit(_Failure(l.code));
        }
      },
      (r) {
        clients = r;
        emit(_Success(clients));
      },
    );
  }
}
