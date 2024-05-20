import 'package:flutter/material.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/components/user_avatar.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/presentation/widgets/All.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/presentation/widgets/MyPost.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/presentation/widgets/MyReels.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class OtherUserProfileScreen extends StatefulWidget {
  const OtherUserProfileScreen({super.key});

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen>
    with ScreenUtils {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryShade50,
      body: SizedBox(
        width: super.screenWidthPercentage(context, 100),
        height: super.screenHeightPercentage(context, 100),
        child: SafeArea(
          child: Column(
            children: [
              // appbar section
              BackButtonNavbar(onPress: (){
                  Navigator.pop(context);
                }, center: null,),

              Container(
                width: super.screenWidthPercentage(context, 100),
                height: super.screenHeightPercentage(context, 40),
                padding: EdgeInsets.symmetric(
                    horizontal: super.screenWidthPercentage(context, 6)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserAvatar(
                      imageSize: super.screenWidthPercentage(context, 25),
                      url: ImageResources.networkUserOne,
                      onPress: () {},
                      radious: 100.0,
                    ),
                    SizedBox(
                      height: super.screenWidthPercentage(context, 5),
                    ),
                    Text(
                      "Shreyas Shashikant Patil",
                      style: CoustomTextStyle.paragraph1
                          .copyWith(fontWeight: FontWeight.w500, color: grey2),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "@ShreyasPatil",
                      style: CoustomTextStyle.paragraph2.copyWith(color: grey4),
                    ),
                    SizedBox(
                      height: super.screenWidthPercentage(context, 5),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          userInfo('My Posts', "240"),
                          userInfo('Followers', "24K"),
                          userInfo('Following', "1000"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: super.screenWidthPercentage(context, 5),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: DefaultTabController(
                  length: 3,
                  child: Container(
                    width: super.screenWidthPercentage(context, 100),
                    height: super.screenHeightPercentage(context, 40),
                    // color: Colors.amberAccent,
                    padding: EdgeInsets.symmetric(
                        horizontal: super.screenWidthPercentage(context, 6)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TabBar(
                                  isScrollable: true,
                                  tabAlignment: TabAlignment.start,
                                  labelColor: primaryShade500,
                                  indicatorColor: primaryShade500,
                                  tabs: const [
                                    Text("All"),
                                    Text("My Posts"),
                                    Text("My Reels"),
                                  ]),
                            ),
                            SizedBox(
                              width: super.screenWidthPercentage(context, 20),
                            ),
                            Image.asset(
                              ImageResources.options,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: super.screenWidthPercentage(context, 8),
                        ),
                        const Expanded(
                          child: TabBarView(
                              children: [All(), MyPosts(), MyReels()]),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userInfo(String infoType, String infoData) {
    return Column(
      children: [
        Text(
          infoType,
          style: CoustomTextStyle.paragraph3.copyWith(color: grey4),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          infoData,
          style: CoustomTextStyle.paragraph2
              .copyWith(fontWeight: FontWeight.w500, color: grey2),
        ),
      ],
    );
  }
}
