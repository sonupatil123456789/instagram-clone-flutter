import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/entity/UserMessageListEntity.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/resources/datetime_formater.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class ChatCard extends StatelessWidget with ScreenUtils {
  // bool? trailingButton;
  // String? trailingButtonText;
  UserMessageListEntity? userData;

  ChatCard({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UserEntity userModel = UserModel(
            uuid: userData!.uuid,
            uniqueName: userData!.uniqueName,
            profileImage: userData!.profileImage,
            phoneNumber: userData!.phoneNumber,
            email: userData!.email,
            userName: userData!.userName,
            isOnline: userData!.isOnline);

        Navigator.pushNamed(context, RoutesName.chatDetailsScreen,
            arguments: {"reciverUser": userModel});
      },
      child: Container(
        width: super.screenWidthPercentage(context, 90),
        height: super.screenHeightPercentage(context, 09),
        padding: EdgeInsets.symmetric(horizontal: super.screenWidthPercentage(context, 4)),
        // color: Colors.cyanAccent,
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: super.screenWidthPercentage(context, 16),
                  height: super.screenWidthPercentage(context, 16),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: primaryShade500,
                          width: 2,
                          style: BorderStyle.solid)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: userData?.profileImage ??
                          ImageResources.networkUserOne,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => CircularProgressIndicator(
                        color: primaryShade500,
                      ),
                      errorWidget: (context, url, error) => Image.asset(ImageResources.localUserOne)
                    ),
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    height: super.screenWidthPercentage(context, 3),
                    width: super.screenWidthPercentage(context, 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: userData!.isOnline == true ? successColor : grey1,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: screenWidthPercentage(context, 4),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "@ ${userData?.uniqueName ?? ""}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: CoustomTextStyle.paragraph2.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Text(
                        DateTimeFormater.formatTime(
                            userData!.messageCreatedAt ?? ''),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: CoustomTextStyle.paragraph4.copyWith(
                            fontWeight: FontWeight.w400, color: grey4),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    userData?.userName ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CoustomTextStyle.paragraph4
                        .copyWith(fontWeight: FontWeight.w400, color: grey4),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  userData!.message!.isNotEmpty
                      ? displayMessageIcon(
                          userData!.uuid!,
                          userData!.messageType!,
                          userData!.uniqueName!,
                          userData!.message!,
                          userData!.messageViewed!)
                      : Text("No Chat Yet",
                          maxLines: 1,
                          style: CoustomTextStyle.paragraph4
                              .copyWith(fontWeight: FontWeight.w300)),
                ],
              ),
            ),
            SizedBox(
              width: screenWidthPercentage(context, 5),
            ),
          ],
        ),
      ),
    );
  }
}

Widget displayMessageIcon(String uuid, String messageType, String name,
    String message, bool messageSeen) {
  CustomUploadFileType fileType =
      CustomUploadFileTypeExtension.stringToEnum(messageType);
  final isSender = FirebaseAuth.instance.currentUser!.uid == uuid;

  final textStyle =
      CoustomTextStyle.paragraph4.copyWith(fontWeight: FontWeight.w300);
  return Row(
    children: [
      if (fileType == CustomUploadFileType.Image) ...[
        const Icon(
          Icons.image,
          size: 14,
        ),
        Text(
          "  ${fileType.enumToString()} ",
          maxLines: 1,
          style: textStyle,
        ),
        const Spacer(),
        Icon(
          messageSeen ? Icons.done_all : Icons.check,
          size: 14,
          color: primaryShade500,
        ),
      ],
      if (fileType == CustomUploadFileType.Video) ...[
        const Icon(
          Icons.video_call,
          size: 14,
        ),
        Text(
          "  ${fileType.enumToString()} ",
          maxLines: 1,
          style: textStyle,
        ),
        const Spacer(),
        Icon(
          messageSeen ? Icons.done_all : Icons.check,
          size: 14,
          color: primaryShade500,
        )
      ],
      if (fileType == CustomUploadFileType.Audio) ...[
        const Icon(
          Icons.audio_file,
          size: 14,
        ),
        Text(
          "  ${fileType.enumToString()} ",
          maxLines: 1,
          style: textStyle,
        ),
        const Spacer(),
        Icon(
          messageSeen ? Icons.done_all : Icons.check,
          size: 14,
          color: primaryShade500,
        )
      ],
      if (fileType == CustomUploadFileType.Document) ...[
        const Icon(
          Icons.attach_file,
          size: 14,
        ),
        Text(
          "  ${fileType.enumToString()} ",
          maxLines: 1,
          style: textStyle,
        ),
        const Spacer(),
        Icon(
          messageSeen ? Icons.done_all : Icons.check,
          size: 14,
          color: primaryShade500,
        )
      ],
      if (fileType == CustomUploadFileType.TextDocument) ...[
        const Icon(
          Icons.message,
          size: 14,
        ),
        Text(
          "  $message ",
          maxLines: 1,
          style: textStyle,
        ),
        const Spacer(),
        Icon(
          messageSeen ? Icons.done_all : Icons.check,
          size: 14,
          color: primaryShade500,
        )
      ]
    ],
  );
}
