import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/components/locked_profile.dart';
import 'package:instagram_clone/components/user_avatar.dart';
import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/HiveUserModel.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/presentation/bloc/OtherUserBloc.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/presentation/bloc/OtherUserEvent.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/presentation/bloc/OtherUserState.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/presentation/widgets/All.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/presentation/widgets/MyPost.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/presentation/widgets/MyReels.dart';
import 'package:instagram_clone/src/UserProfileScreen/presentation/widgets/follower_following_bottomSheet.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class OtherUserProfileScreen extends StatefulWidget {
  String uuid;
  OtherUserProfileScreen({super.key, required this.uuid});

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen>
    with ScreenUtils {
  Box<HiveUserModel> userDataBase = Hive.box<HiveUserModel>('UserDataBase');
  late HiveUserModel? senderUser;
  FollowEntity followingOther = FollowModel();

  @override
  void initState() {
    super.initState();
    senderUser = userDataBase.get("User");

    followingOther = FollowModel(
        uniqueName: senderUser!.uniqueName,
        uuid: senderUser!.uuid,
        profileImage: senderUser!.profileImage);

    context
        .read<OtherUserBloc>()
        .add(GetOtherUserDetailDataEvent(context: context, uuid: widget.uuid, followingOther: followingOther));
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: primaryShade50,
      body: SizedBox(
        width: super.screenWidthPercentage(context, 100),
        height: super.screenHeightPercentage(context, 100),
        child: SafeArea(
          child: LiquidPullToRefresh(
            showChildOpacityTransition: false,
            springAnimationDurationInMilliseconds: 200,
            color: primaryShade200,
            backgroundColor: primaryShade50,
            onRefresh: () async {
              context.read<OtherUserBloc>().add(GetOtherUserDetailDataEvent(
                  context: context, uuid: widget.uuid, followingOther : followingOther));
            },
            child: Column(
              children: [
                // appbar section
                BackButtonNavbar(
                    onPress: () {
                      Navigator.pop(context);
                    },
                    center: null),

                Container(
                  width: super.screenWidthPercentage(context, 100),
                  height: super.screenHeightPercentage(context, 30),
                  padding: EdgeInsets.symmetric(
                      horizontal: super.screenWidthPercentage(context, 6)),
                  child: BlocBuilder<OtherUserBloc, OtherUserState>(
                    builder: (context, state) {
                      if (state.currentState == CurrentAppState.SUCCESS) {
                        final otherUser = state.otherUserDetails;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: super.screenWidthPercentage(context, 80),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  UserAvatar(
                                    imageSize: super
                                        .screenWidthPercentage(context, 18),
                                    url: otherUser.profileImage ??
                                        ImageResources.networkUserOne,
                                    onPress: () {},
                                    radious: 100.0,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "@ ${otherUser.uniqueName} " ??
                                            "No Data",
                                        style: CoustomTextStyle.paragraph2
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: grey2),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "${otherUser.email}" ?? "No Data",
                                        style: CoustomTextStyle.paragraph3
                                            .copyWith(color: grey4),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: super.screenWidthPercentage(context, 6),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  userInfo('My Posts',
                                      state.postList.length.toString() ?? "0"),
                                  GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet<void>(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (BuildContext context) {
                                              return FollowingFollowersBottomSheet(
                                                followingFollowers:
                                                    otherUser.followers ?? [],
                                                title: 'Followers',
                                              );
                                            });
                                      },
                                      child: userInfo('Followers', "${otherUser.followers?.length ?? 0}")),
                                  GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet<void>(
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (BuildContext context) {
                                              return FollowingFollowersBottomSheet(
                                                followingFollowers:
                                                    otherUser.following ?? [],
                                                title: 'Following',
                                              );
                                            });
                                      },
                                      child: userInfo('Following', "${otherUser.following?.length ?? 0}")),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: super.screenWidthPercentage(context, 6),
                            ),
                            SizedBox(
                              width: super.screenWidthPercentage(context, 80),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  messageButton(
                                      reciverUser: state.otherUserDetails),
                                  followUnfollowButton( onPress: () {
                                    context.read<OtherUserBloc>().add(FollowOtherUserEvent(
                                          context: context,
                                          following: FollowModel(
                                              uniqueName: otherUser.uniqueName,
                                              uuid: otherUser.uuid,
                                              profileImage:otherUser.profileImage),
                                        ),
                                      );

                                    // context.read<OtherUserBloc>().add(
                                    //     GetOtherUserDetailDataEvent(context: context,uuid: widget.uuid));
                                  }, isFollowing:  state.isUserFollowing, )
                                ],
                              ),
                            )
                          ],
                        );
                      }

                      if (state.currentState == CurrentAppState.ERROR) {
                        return const Center(
                          child: Text("Some Error Occured"),
                        );
                      }

                      return Center(
                        child: CircularProgressIndicator(
                          color: primaryShade500,
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(
                  height: super.screenWidthPercentage(context, 8),
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
                              
                            ],
                          ),
                          SizedBox(
                            height: super.screenWidthPercentage(context, 8),
                          ),
                          Expanded(
                            child: BlocBuilder<OtherUserBloc, OtherUserState>(
                              builder: (context, state) {
                                if (state.currentState ==CurrentAppState.ERROR) {
                                  return Center(
                                    child: Text("Some Error Occured",
                                        style: CoustomTextStyle.paragraph4),
                                  );
                                }

                                if (state.currentState ==CurrentAppState.SUCCESS) {
                                  final otherPostList = state.postList;
                                  if (state.isUserFollowing) {
                                    if (otherPostList.isEmpty) {
                                      return Center(child: Text("No Post Yet",style: CoustomTextStyle.paragraph4));
                                    } else {
                                      return TabBarView(children: [
                                        All(
                                          myPostList: otherPostList,
                                        ),
                                        MyPosts(
                                          myPostList: otherPostList,
                                        ),
                                        MyReels(
                                          myPostList: otherPostList,
                                        )
                                      ]);
                                    }
                                  } else {
                                    return const LockedProfile();
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

  Widget followUnfollowButton({ required bool isFollowing , required Function onPress}) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        height: super.screenWidthPercentage(context, 10),
        width: super.screenWidthPercentage(context, 38),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: primaryShade500, width: 1),
            // color: primaryShade500),
        color: isFollowing ? primaryShade50 : primaryShade500),
        child: Text(
          // "Follow",
          isFollowing ? "UnFollow" : "Follow",
          style: CoustomTextStyle.paragraph5.copyWith(
              // color: white,
              color: isFollowing ? blac2 : white,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget messageButton({required UserEntity reciverUser}) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.chatDetailsScreen,
            arguments: {"reciverUser": reciverUser});
      },
      child: Container(
        height: super.screenWidthPercentage(context, 10),
        width: super.screenWidthPercentage(context, 38),
        decoration: BoxDecoration(
            border: Border.all(color: grey2, width: 2),
            borderRadius: BorderRadius.circular(4)),
        alignment: Alignment.center,
        child: Text(
          "Message",
          style: CoustomTextStyle.paragraph5,
        ),
      ),
    );
  }
}
