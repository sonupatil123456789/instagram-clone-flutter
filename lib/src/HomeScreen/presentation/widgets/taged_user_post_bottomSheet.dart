
import 'package:flutter/material.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/components/user_avatar.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

import '../../../AddPostScreen/domain/entity/TagPeopleEntity.dart';

class TagedUserPostBottomSheet extends StatelessWidget with ScreenUtils {
  List<TagPeopleEntity>? tagedPeopleList;

  TagedUserPostBottomSheet({super.key, required this.tagedPeopleList});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          color: primaryShade50,
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      width: super.screenWidthPercentage(context, 100),
      height: super.screenHeightPercentage(context, 90),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),

            /// app bar section'
            BackButtonNavbar(
                onPress: () {
                  Navigator.pop(context);
                },
                icon: Icons.close,
                center: Text("Tagged people" ,style: CoustomTextStyle.paragraph2,)),

            const SizedBox(
              height: 20,
            ),



            Container(
              width: super.screenWidthPercentage(context, 100),
              padding: EdgeInsets.all( super.screenWidthPercentage(context, 2),),
              child: Wrap(
                direction: Axis.horizontal,
                runSpacing: 8,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                spacing: 6,
                children: tagedPeopleList!.map((tagedPeopleListData) {
                  return Chip(
                    avatar:  UserAvatar(
                      imageSize: 25, url: tagedPeopleListData.profileImage ?? ImageResources.networkUserOne,
                       onPress: (){}, radious: 50),
                    label: Text(tagedPeopleListData.uniqueName.toString(), style: CoustomTextStyle.paragraph4.copyWith(
                      color: white
                    ),));
                }).toList(),
              ),
            )
           
          ],
        ),
      ),
    );
  }
}
