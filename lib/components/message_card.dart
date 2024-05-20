import 'package:flutter/material.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/entity/UserChatMessageEntity.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

import '../utils/resources/datetime_formater.dart';

class MessageCard extends StatefulWidget  {
  UserChatMessageEntity messageData;
  Function onTapHandler;
  dynamic selectedItem;
  bool senderUser;

  MessageCard({
    super.key,
    required this.messageData,
    required this.onTapHandler,
    required this.selectedItem,
    required this.senderUser,
  });

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> with ScreenUtils {

  @override
  Widget build(BuildContext context) {
    if (widget.senderUser == true) {
      return InkWell(
        onTap: () {
          widget.onTapHandler();
        },
        child: Container(
          alignment: Alignment.centerRight,
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(screenWidthPercentage(context, 2)),
                margin: EdgeInsets.fromLTRB(screenWidthPercentage(context, 10),
                 3, 
                 screenWidthPercentage(context, 2), 3),
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
                    Text(
                      widget.messageData.message ?? '',
                      softWrap: true,
                      // textAlign: TextAlign.end,
                      style: CoustomTextStyle.paragraph4
                          .copyWith(fontWeight: FontWeight.w300,),
                    ),
                    const SizedBox(height: 3,),
                    Wrap(
                      children: [
                        Text(
                          DateTimeFormater.formatTime(widget.messageData.createdAt ?? ''),
                          style: CoustomTextStyle.paragraph5,
                        ),
                        const SizedBox(width: 4,),
                        Icon(  widget.messageData.messageViewed! ? Icons.done_all : Icons.check, size: 14, color: primaryShade500,)
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




     return InkWell(
        onTap: () {
          widget.onTapHandler();
        },
        child: Container(
          alignment: Alignment.centerLeft,
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(screenWidthPercentage(context, 2)),
                margin: EdgeInsets.fromLTRB(screenWidthPercentage(context, 2),
                 3, 
                 screenWidthPercentage(context, 10), 3),
                decoration: const ShapeDecoration(
                  color: white,
                  shape:  RoundedRectangleBorder(
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
                    Text(
                      widget.messageData.message ?? '',
                      softWrap: true,
                      style: CoustomTextStyle.paragraph4.copyWith(fontWeight: FontWeight.w300,),
                    ),
                    const SizedBox(height: 3,),
                      Wrap(
                      children: [
                        Text(
                          DateTimeFormater.formatTime(widget.messageData.createdAt ?? ''),
                          style: CoustomTextStyle.paragraph5,
                        ),
                        const SizedBox(width: 4,),
                        Icon(  widget.messageData.messageViewed! ? Icons.done_all : Icons.check, size: 14, color: primaryShade500,)
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
}
