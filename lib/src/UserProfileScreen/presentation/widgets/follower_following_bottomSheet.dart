
import 'package:flutter/material.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';
import 'package:instagram_clone/src/HomeScreen/presentation/widgets/square_card.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class FollowingFollowersBottomSheet extends StatelessWidget with ScreenUtils {
  List<FollowEntity> followingFollowers;
  String title ;

  FollowingFollowersBottomSheet({super.key, required this.followingFollowers , required this.title});

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
                   center: Text(title ,style: CoustomTextStyle.paragraph2,)),

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
                children: followingFollowers.map((userLikeDetails) {
                  return SquareCard(
                    data: userLikeDetails,
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
