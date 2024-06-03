import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/src/ChatListScreen/data/model/UserChatMessageModel.dart';
import 'package:instagram_clone/src/ChatListScreen/presentation/bloc/ChatListBloc.dart';
import 'package:instagram_clone/src/ChatListScreen/presentation/bloc/ChatListEvents.dart';
import 'package:instagram_clone/src/ChatListScreen/presentation/bloc/ChatListState.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/screen_utils/input_field_utils.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class UploadFileBottomSheet extends StatelessWidget with ScreenUtils {
  UserEntity senderUser;
  UserEntity reciverUser;

  UploadFileBottomSheet({
    super.key,
    required this.senderUser,
    required this.reciverUser,
  });

  UserChatMessageModel messageData =
      UserChatMessageModel(replyedToId: '', message: '');

  // context.read<ChatListBloc>().add(SendMessageEvent(
  //     context: context,
  //     sender: HiveUserModel.toEntity(senderUser),
  //     reciver: widget.reciverUser,
  //     messageData: messageData)
  // );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: primaryShade50,
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      width: super.screenWidthPercentage(context, 100),
      height: super.screenHeightPercentage(context, 30),
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /// app bar section'
          BackButtonNavbar(
              onPress: () {
                Navigator.pop(context);
              },
              icon: Icons.close,
              center: Text(
                "Send File",
                style: CoustomTextStyle.paragraph2,
              )),

          Wrap(
            runAlignment: WrapAlignment.spaceEvenly,
            alignment: WrapAlignment.center,
            spacing: super.screenWidthPercentage(context, 6),
            children: [
              fileTypeWiedget(
                  size: super.screenWidthPercentage(context, 14),
                  iconData: Icons.image,
                  iconColor: primaryShade600,
                  onSelect: () async {
                    final imageData = await InputFielUtils.getMyFile(
                        [], FileType.image, CustomUploadFileType.Image);
                    if (imageData != null) {
                      messageData = messageData.copyWith(
                          messageType: imageData.coustomfileType.enumToString(),
                          createdAt: DateTime.now().toString(),
                          message: imageData.fileData.path);
                    }
                  }),
              fileTypeWiedget(
                  size: super.screenWidthPercentage(context, 14),
                  iconData: Icons.videocam,
                  iconColor: primaryShade600,
                  onSelect: () async {
                    final imageData = await InputFielUtils.getMyFile(
                        [], FileType.video, CustomUploadFileType.Video);
                    if (imageData != null) {
                      messageData = messageData.copyWith(
                          messageType: imageData.coustomfileType.enumToString(),
                          createdAt: DateTime.now().toString(),
                          message: imageData.fileData.path);
                    }
                  }),
              fileTypeWiedget(
                  size: super.screenWidthPercentage(context, 14),
                  iconData: Icons.audio_file,
                  iconColor: primaryShade600,
                  onSelect: () async {
                    final imageData = await InputFielUtils.getMyFile(
                        [], FileType.audio, CustomUploadFileType.Audio);
                    if (imageData != null) {
                      messageData = messageData.copyWith(
                          messageType: imageData.coustomfileType.enumToString(),
                          createdAt: DateTime.now().toString(),
                          message: imageData.fileData.path);
                    }
                  }),
              fileTypeWiedget(
                  size: super.screenWidthPercentage(context, 14),
                  iconData: Icons.file_copy,
                  iconColor: primaryShade600,
                  onSelect: () async {
                    final imageData =
                        await InputFielUtils.getALlMyFile(['pdf']);
                    if (imageData != null) {
                      messageData = messageData.copyWith(
                          messageType:CustomUploadFileType.Document.enumToString(),
                          createdAt: DateTime.now().toString(),
                          message: imageData.path);
                    }
                  }),
            ],
          ),
          BlocBuilder<ChatListBloc, ChatListState>(
            builder: (context, state) {
              return Container(
                width: screenWidthPercentage(context, 80),
                alignment: Alignment.bottomRight,
                child: state.currentState == CurrentAppState.LOADING
                    ? CircularProgressIndicator(
                        color: primaryShade500,
                      )
                    : GestureDetector(
                        onTap: () {
                          if (messageData.message!.isNotEmpty) {
                            context.read<ChatListBloc>().add(
                                  SendMessageEvent(
                                      context: context,
                                      sender: senderUser,
                                      reciver: reciverUser,
                                      messageData: messageData),
                                );
                                Navigator.pop(context);
                          }
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: primaryShade500,
                              borderRadius: BorderRadius.circular(100)),
                          child: const Icon(
                            Icons.send,
                            color: white,
                            size: 18,
                          ),
                        ),
                      ),
              );
            },
          ),
        ],
      )),
    );
  }
}

Widget fileTypeWiedget(
    {required double size,
    required IconData iconData,
    required dynamic iconColor,
    required Function onSelect}) {
  return InkWell(
    onTap: () {
      onSelect();
    },
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: primaryShade100,
          borderRadius: const BorderRadius.all(Radius.circular(100))),
      child: Icon(
        iconData,
        color: iconColor,
        size: 18,
      ),
    ),
  );
}
