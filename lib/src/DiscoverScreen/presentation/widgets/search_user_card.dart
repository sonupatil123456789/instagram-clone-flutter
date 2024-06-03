import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/HiveUserModel.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';

import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

import '../../../../utils/screen_utils/helper_function.dart';

class SearchUserCard extends StatelessWidget with ScreenUtils {
  UserEntity? data;
  Function onPressTrailing;
  int index;

  SearchUserCard(
      {super.key,
      required this.data,
      required this.onPressTrailing,
      required this.index});

      Box<HiveUserModel> userDataBase = Hive.box<HiveUserModel>('UserDataBase');

  @override
  Widget build(BuildContext context) {

    final user = HiveUserModel.toEntity(userDataBase.get("User"));
    final currentUser = FollowModel(
        profileImage: user.profileImage,
        uuid: user.uuid,
        uniqueName: user.uniqueName);
    bool following = data!.followers!.contains(currentUser);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.otherUserProfileScreen , arguments: {'uuid': data!.uuid});
      },
      child: Container(
        width: super.screenWidthPercentage(context, 90),
        height: super.screenHeightPercentage(context, 09),
        padding: EdgeInsets.symmetric(
            horizontal: super.screenWidthPercentage(context, 6)),
        // color: Colors.cyanAccent,
        child: Row(
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
                  imageUrl: data?.profileImage ?? ImageResources.networkUserOne,
                  fit: BoxFit.cover,
                   placeholder: (context, url) => CircularProgressIndicator(color: primaryShade500,),
                  errorWidget: (context, url, error) => Image.asset(ImageResources.localUserOne)
                ),
              ),
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
                    data?.uniqueName ?? "No Data",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CoustomTextStyle.paragraph2
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    data?.email ?? "No Data",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CoustomTextStyle.paragraph4
                        .copyWith(fontWeight: FontWeight.w400, color: grey4),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(getFollowingInformation(data!),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: CoustomTextStyle.paragraph5
                          .copyWith(fontWeight: FontWeight.w300)),
                ],
              ),
            ),
            SizedBox(
              width: screenWidthPercentage(context, 3),
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                GestureDetector(
                  onTap: () {
                    onPressTrailing(data!.uuid, data);
                  },
                  child: Container(
                    // width: screenWidthPercentage(context, 2),
                    padding: EdgeInsets.symmetric( horizontal: screenWidthPercentage(context, 3)),
                    alignment: Alignment.center,
                    height: screenHeightPercentage(context, 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: primaryShade500, width: 1),
                        color: following ? primaryShade50 : primaryShade500),
                    child: Text(
                      following ? "UnFollow" : "Follow",
                      style: CoustomTextStyle.paragraph5.copyWith(
                          color: following ? blac2 : white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
