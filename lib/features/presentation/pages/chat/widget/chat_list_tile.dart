import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile({
    super.key,
    required this.chatList,
    required this.client,
  });

  final ChatList chatList;
  final Client client;

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<MyAppColors>()!;

    return ListTile(
      title: Text(client.name!),
      subtitle: Row(
        children: [
          if (chatList.lastSender ==
              MainBoxMixin.mainBox?.get(MainBoxKeys.authUserId.name))
            Padding(
              padding: EdgeInsets.only(right: Dimens.space8),
              child: Icon(
                Icons.done_all,
                size: Dimens.space16,
                color:
                    chatList.clientUnread == 0 ? colorTheme.blue : Colors.grey,
              ),
            ),
          Text(chatList.lastMessage!),
        ],
      ),
      leading: ProfilePicture(
        pictureUrl: client.profilePicture,
        radius: Dimens.space24,
        border: Dimens.space2,
        onTap: () {},
      ),
      trailing: Text(
        '${chatList.lastTime!.hour}.'
        '${chatList.lastTime!.minute}',
      ),
      onTap: () {
        context.read<ChatCubit>().readChat(ReadChatParams(chatList));
        context.push(
          Routes.roomChat.path,
          extra: {
            'chatListId': chatList.id,
            'client': client,
          },
        );
      },
    );
  }
}
