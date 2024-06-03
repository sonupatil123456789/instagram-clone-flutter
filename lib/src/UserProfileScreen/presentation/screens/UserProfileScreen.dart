import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/components/user_avatar.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthBloc.dart';
import 'package:instagram_clone/src/SettingsScreen/presentation/screens/SettingsScreen.dart';
import 'package:instagram_clone/src/UserProfileScreen/presentation/bloc/UserProfileBloc.dart';
import 'package:instagram_clone/src/UserProfileScreen/presentation/bloc/UserProfileEvent.dart';
import 'package:instagram_clone/src/UserProfileScreen/presentation/bloc/UserProfileState.dart';
import 'package:instagram_clone/src/UserProfileScreen/presentation/widgets/All.dart';
import 'package:instagram_clone/src/UserProfileScreen/presentation/widgets/MyPost.dart';
import 'package:instagram_clone/src/UserProfileScreen/presentation/widgets/MyReels.dart';
import 'package:instagram_clone/src/UserProfileScreen/presentation/widgets/follower_following_bottomSheet.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../Authantication/domain/entity/UserEntity.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> with ScreenUtils {
  UserEntity userData = UserModel();

  initialise(BuildContext context, bool refresh) async {
    userData = await context.read<AuthBloc>().getUserDetails(context, refresh);
    context.read<UserProfileBloc>().add(GetMyPostEvent(context: context, isRefresh: refresh));
  }

  @override
  void initState() {
    super.initState();
    initialise(context, false);
  }

  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: super.screenWidthPercentage(context, 100),
      height: super.screenHeightPercentage(context, 100),
      child: SafeArea(
        child: LiquidPullToRefresh(
          showChildOpacityTransition: false,
          springAnimationDurationInMilliseconds: 200,
          color: primaryShade200,
          backgroundColor: primaryShade50,
          onRefresh: () async {
            initialise(context, true);
          },
          child: Column(
            children: [
              // appbar section
              Container(
                width: super.screenWidthPercentage(context, 100),
                height: super.screenHeightPercentage(context, 46),
                padding: EdgeInsets.symmetric(
                    horizontal: super.screenWidthPercentage(context, 6)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserAvatar(
                      imageSize: super.screenWidthPercentage(context, 25),
                      url: userData.profileImage ??ImageResources.networkUserOne,
                      onPress: () {},
                      radious: 100.0,
                    ),
                    SizedBox(
                      height: super.screenWidthPercentage(context, 5),
                    ),
                    Text(
                      "@ ${userData.uniqueName} " ?? "No Data",
                      style: CoustomTextStyle.paragraph1
                          .copyWith(fontWeight: FontWeight.w500, color: grey2),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${userData.email}" ?? "No Data",
                      style: CoustomTextStyle.paragraph3.copyWith(color: grey4),
                    ),
                    SizedBox(
                      height: super.screenWidthPercentage(context, 5),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          userInfo(
                              'My Posts',
                              context.watch<UserProfileBloc>().state.myPostList?.length.toString() ??
                                  "0"),
                          GestureDetector(
                              onTap: () {
                                showModalBottomSheet<void>(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return FollowingFollowersBottomSheet(
                                        followingFollowers: userData.followers ?? [],
                                        title: 'Followers',
                                      );
                                    });
                              },
                              child: userInfo('Followers',
                                  "${userData.followers?.length ?? 0}")),
                          GestureDetector(
                              onTap: () {
                                showModalBottomSheet<void>(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return FollowingFollowersBottomSheet(
                                        followingFollowers: userData.following ?? [],
                                        title: 'Following',
                                      );
                                    });
                              },
                              child: userInfo('Following', "${userData.following?.length ?? 0}")),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: super.screenWidthPercentage(context, 5),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) { 
                          return const SettingsScreen();
                         }));
                      },
                      child: Container(
                        // width: super.screenWidthPercentage(context, 70),
                        decoration: BoxDecoration(
                            border: Border.all(color: grey2, width: 2),
                            borderRadius: BorderRadius.circular(4)),
                        alignment: Alignment.center,
                        height: super.screenWidthPercentage(context, 10),
                        child: Text(
                          "Settings",
                          style: CoustomTextStyle.paragraph3,
                        ),
                      ),
                    )
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
                        Expanded(
                          child: BlocBuilder<UserProfileBloc, UserProfileState>(
                            buildWhen: (previous, current) => previous.currentState != current.currentState,
                            builder: (context, state) {
                              if (state.currentState == CurrentAppState.ERROR) {
                                return  Center(
                                  child: Text("Some Error Occured" ,  style: CoustomTextStyle.paragraph4),
                                );
                              }

                              if (state.currentState == CurrentAppState.SUCCESS) {
                                if (state.myPostList!.isEmpty) {
                                  return  Center(
                                    child: Text("No Post Yet" , style: CoustomTextStyle.paragraph4),
                                  );
                                } else {
                                  return TabBarView(children: [
                                    All(
                                      myPostList: state.myPostList ?? [],
                                    ),
                                    MyPosts(
                                      myPostList: state.myPostList ?? [],
                                    ),
                                    MyReels(
                                      myPostList: state.myPostList ?? [],
                                    )
                                  ]);
                                }
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  color: primaryShade500,
                                ),
                              );
                            },
                          ),
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
    return SizedBox(
      child: Column(
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
      ),
    );
  }

}




Future<dynamic> deletPost(String postId ,BuildContext context ){
  return showDialog(
    context:context ,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: primaryShade50,
        title: Text(
          'Delete Confirmation',
          style: CoustomTextStyle.paragraph1,
        ),
        content: Text('Are you sure you want to delete comment . After deleting we cannot cancell the deletion ?', style: CoustomTextStyle.paragraph4,),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
              child:  Text('Delet', style: CoustomTextStyle.paragraph3.copyWith(color: primaryShade500),),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child:  Text('Cancel', style: CoustomTextStyle.paragraph3,),
          ),
        ],
      );
    },
  ).then((confirmed) {
    if (confirmed == true) {
      context.read<UserProfileBloc>().add(DeletMyPostEvent(context: context, postId: postId));
    } else {}
  });
}

