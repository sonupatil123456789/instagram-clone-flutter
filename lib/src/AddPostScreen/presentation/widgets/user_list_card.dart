import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:instagram_clone/src/AddPostScreen/presentation/bloc/PostBloc.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/helper_function.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

import '../../data/model/TagPeopleModel.dart';

class UserListCard extends StatelessWidget with ScreenUtils {
  UserEntity? data;
  Function onPressTrailing;
  int index;

  UserListCard(
      {super.key,
      required this.data,
      required this.onPressTrailing,
      required this.index});

  @override
  Widget build(BuildContext context) {


    final tagedPeople = context.watch<PostBloc>().state.tagPeoples.contains(
        TagPeopleModel(
            uuid: data!.uuid,
            uniqueName: data!.uniqueName,
            profileImage: data!.profileImage));

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.chatDetailsScreen);
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                  Text(getFollowingInformation(data!),
                  overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: CoustomTextStyle.paragraph5
                          .copyWith(fontWeight: FontWeight.w300)),
                ],
              ),
            ),
            SizedBox(
              width: screenWidthPercentage(context, 3),
            ),
            GestureDetector(
              onTap: () {
                onPressTrailing(data!.uuid, data);
              },
              child: Container(
                // width: screenWidthPercentage(context, 2),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidthPercentage(context, 3)),
                alignment: Alignment.center,
                height: screenHeightPercentage(context, 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: primaryShade500 , width: 1),
                        color: tagedPeople ? primaryShade50 : primaryShade500),
                child: Text(
                  tagedPeople ? "Remove" : "Add",
                  style: CoustomTextStyle.paragraph5
                      .copyWith(color: tagedPeople ? blac2 : white, fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
