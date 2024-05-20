import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class ChatCard extends StatelessWidget with ScreenUtils {
  // bool? trailingButton;
  // String? trailingButtonText;
  UserEntity? userData;

  ChatCard(
      {super.key,
      required this.userData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.chatDetailsScreen, arguments: {"reciverUser" : userData});
      },
      child: Container(
        width: super.screenWidthPercentage(context, 90),
        height: super.screenHeightPercentage(context, 09),
        padding: EdgeInsets.symmetric(
            horizontal: super.screenWidthPercentage(context, 6)),
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
                      imageUrl: userData?.profileImage ?? ImageResources.networkUserOne,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
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
                      color: userData!.isOnline== true ? successColor : grey1,
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
                  Text(
                    "@${userData?.uniqueName ?? ""}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CoustomTextStyle.paragraph2
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  const SizedBox(height: 2,),
                  Text(
                    userData?.userName ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CoustomTextStyle.paragraph4.copyWith(fontWeight: FontWeight.w400, color: grey4),
                  ),
                  Text("Can we meet in the park today ",
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
