import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';

class ReadChatUsecase extends UseCase<ChatList, ReadChatParams> {
  final ChatRepository _repository;

  ReadChatUsecase(this._repository);

  @override
  Future<Either<Failure, ChatList>> call(ReadChatParams params) =>
      _repository.readChat(params);
}

class ReadChatParams {
  final ChatList chatList;

  ReadChatParams(this.chatList);
}
