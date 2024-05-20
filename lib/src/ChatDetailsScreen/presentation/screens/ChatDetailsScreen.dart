import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/components/message_card.dart';
import 'package:instagram_clone/components/message_text_field.dart';
import 'package:instagram_clone/components/user_avatar.dart';
import 'package:instagram_clone/src/Authantication/data/model/HiveUserModel.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/src/ChatListScreen/data/model/UserChatMessageModel.dart';
import 'package:instagram_clone/src/ChatListScreen/presentation/bloc/ChatListBloc.dart';
import 'package:instagram_clone/src/ChatListScreen/presentation/bloc/ChatListEvents.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/presentation/screens/OtherUserProfileScreen.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class ChatDetailsScreen extends StatefulWidget {
  UserEntity reciverUser;

  ChatDetailsScreen({super.key, required this.reciverUser});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen>
    with ScreenUtils {
  TextEditingController messageController =TextEditingController();
  final focusNode = FocusNode();
  String replyedTo = '';
  Box<HiveUserModel> userDataBase = Hive.box<HiveUserModel>('UserDataBase');
  late HiveUserModel? senderUser;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    senderUser = userDataBase.get("User");
    
    context.read<ChatListBloc>().getUserConversationStreamListEvent(
        senderUser!.uuid!, widget.reciverUser.uuid!, context);

  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: primaryShade50,
      body: SizedBox(
        width: super.screenWidthPercentage(context, 100),
        height: super.screenHeightPercentage(context, 100),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // appbar section

                  BackButtonNavbar(
                    onPress: () {
                      Navigator.pop(context);
                    },
                    center: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const OtherUserProfileScreen();
                          }));
                        },
                        child: Row(
                          children: [
                            UserAvatar(
                              imageSize:
                                  super.screenWidthPercentage(context, 10),
                              url: ImageResources.networkUserOne,
                              onPress: () {},
                              radious: 100.0,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.reciverUser.uniqueName ?? '',
                                  style: CoustomTextStyle.paragraph2
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  widget.reciverUser.isOnline!
                                      ? 'OnLine'
                                      : 'OffLine',
                                  style: CoustomTextStyle.paragraph5.copyWith(
                                      // fontWeight: FontWeight.w500
                                      ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Expanded(
                    child: StreamBuilder(
                        stream: context
                            .read<ChatListBloc>()
                            .state
                            .chatStreamController
                            .stream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: primaryShade500,
                              ),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            if (snapshot.data?.length == 0) {
                              return Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "No Chat Yet",
                                  style: CoustomTextStyle.paragraph4,
                                ),
                              );
                            }

                            final value = snapshot.data;

                            

                            return ListView.builder(
                              padding: const EdgeInsets.only(left: 10),
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                final messageData = value![index];

                                if (messageData.messageViewed != true && messageData.uuid != senderUser!.uuid) {
                                  context.read<ChatListBloc>().add(
                                      ViewedMessageEvent(
                                          context: context,
                                          senderId:HiveUserModel.toEntity(senderUser) .uuid!,
                                          reciverId: widget.reciverUser.uuid!,
                                          messageId: messageData.messageId!));
                                }

                                return MessageCard(
                                  onTapHandler: () {},
                                  selectedItem: 1,
                                  messageData: messageData,
                                  senderUser:messageData.uuid == senderUser!.uuid? true: false,
                                );
                              },
                              itemCount: value?.length ?? 0,
                            );
                          }

                          return Container(
                              alignment: Alignment.center,
                              child: Text(
                                  snapshot.error.toString() ??"Some Error Occured",
                                  style: CoustomTextStyle.paragraph4));
                        }),
                  ),

                  SizedBox(
                    height: screenHeightPercentage(context, 8),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: MessageTextField(
                  controller: messageController,
                  focusNode: focusNode,
                  getTextFieldValue: (value) {},
                  onSend: () {
                    final messageData = UserChatMessageModel(
                      messageType:CustomUploadFileType.TextDocument.enumToString(),
                      message: messageController.text.toString(),
                      replyedToId: replyedTo,
                      createdAt: DateTime.now().toString(),
                    );

                    context.read<ChatListBloc>().add(SendMessageEvent(
                        context: context,
                        sender: HiveUserModel.toEntity(senderUser),
                        reciver: widget.reciverUser,
                        messageData: messageData));

                      messageController.clear();
                  },
                  onAttachFile: () {},
                  showAttachFile: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



}






