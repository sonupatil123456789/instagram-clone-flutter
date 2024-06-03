import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/ChatDetailsScreen/presentation/widgets/message_type.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/entity/UserChatMessageEntity.dart';
import 'package:instagram_clone/src/ChatListScreen/presentation/bloc/ChatListBloc.dart';
import 'package:instagram_clone/src/ChatListScreen/presentation/bloc/ChatListEvents.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

import '../../../../utils/resources/datetime_formater.dart';

class MessageCard extends StatefulWidget {
  UserChatMessageEntity messageData;
  Function onTapHandler;
  dynamic selectedItem;
  bool senderUser;
  String senderUuid;
  String reciverUuid;

  MessageCard({
    super.key,
    required this.messageData,
    required this.onTapHandler,
    required this.selectedItem,
    required this.senderUser,
    required this.reciverUuid,
    required this.senderUuid,
  });

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> with ScreenUtils {
  @override
  Widget build(BuildContext context) {
    if (widget.senderUser == true) {
      return Dismissible(
        key: ValueKey(widget.messageData.messageId.toString()),
        onDismissed: (direction) {
          context.read<ChatListBloc>().add(DeletMessageEvent(
              context: context,
              senderId: widget.senderUuid,
              reciverId: widget.reciverUuid,
              messageId: widget.messageData.messageId!));
        },
        child: Container(
          alignment: Alignment.centerRight,
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(screenWidthPercentage(context, 3)),
                margin: EdgeInsets.fromLTRB(screenWidthPercentage(context, 10),
                    5, screenWidthPercentage(context, 2), 4),
                decoration: ShapeDecoration(
                  color: primaryShade100,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(2),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MessageType(
                      message: widget.messageData.message!,
                      messageType: widget.messageData.messageType!,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Wrap(
                      children: [
                        Text(
                          DateTimeFormater.formatTime(
                              widget.messageData.createdAt ?? ''),
                          style: CoustomTextStyle.paragraph5,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Icon(
                          widget.messageData.messageViewed!
                              ? Icons.done_all
                              : Icons.check,
                          size: 14,
                          color: primaryShade500,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      alignment: Alignment.centerLeft,
      child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.all(screenWidthPercentage(context, 2)),
            margin: EdgeInsets.fromLTRB(screenWidthPercentage(context, 2), 5,
                screenWidthPercentage(context, 10), 4),
            decoration: const ShapeDecoration(
              color: white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MessageType(
                  message: widget.messageData.message!,
                  messageType: widget.messageData.messageType!,
                ),
                const SizedBox(
                  height: 3,
                ),
                Wrap(
                  children: [
                    Text(
                      DateTimeFormater.formatTime(
                          widget.messageData.createdAt ?? ''),
                      style: CoustomTextStyle.paragraph5,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Icon(
                      widget.messageData.messageViewed!
                          ? Icons.done_all
                          : Icons.check,
                      size: 14,
                      color: primaryShade500,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
