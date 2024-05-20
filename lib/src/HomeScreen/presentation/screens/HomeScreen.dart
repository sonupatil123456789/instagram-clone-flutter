import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/components/cards/status_story_card.dart';
import 'package:instagram_clone/components/cards/status_story_slider.dart';
import 'package:instagram_clone/components/cards/user_posts_card.dart';
import 'package:instagram_clone/components/user_avatar.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/LikeModel.dart';
import 'package:instagram_clone/src/AddPostScreen/presentation/bloc/PostBloc.dart';
import 'package:instagram_clone/src/AddPostScreen/presentation/bloc/PostState.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/src/HomeScreen/presentation/bloc/HomeBloc.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/file_model.dart';
import 'package:instagram_clone/utils/screen_utils/input_field_utils.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../AddPostScreen/domain/entity/PostEntity.dart';
import '../../../Authantication/presentation/bloc/AuthBloc.dart';
import '../../../Authantication/presentation/bloc/AuthEvents.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ScreenUtils {

  late AppLifecycleListener _listener;
  UserEntity userData = UserModel();
  LikeModel likePost = LikeModel();

  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        context
            .read<AuthBloc>()
            .add(IsOnlineEvent(isOnline: true, context: context));
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        context
            .read<AuthBloc>()
            .add(IsOnlineEvent(isOnline: false, context: context));
    }
  }

  initialise(BuildContext context, bool refresh) async {
    userData = await context.read<AuthBloc>().getUserDetails(context, refresh);
    // context.read<PostBloc>().add(GetMyStatusEvent(context: context));

    likePost = likePost.copyWith(
        uniqueName: userData!.uniqueName,
        profileImage: userData!.profileImage,
        uuid: userData!.uuid);
    setState(() {});
  }



  @override
  void initState() {
    super.initState();
    initialise(context, false);
    _listener = AppLifecycleListener(
      onStateChange: _onStateChanged,
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: super.screenWidthPercentage(context, 100),
      height: super.screenHeightPercentage(context, 100),
      child: SafeArea(
        child: Column(
          children: [
            // appbar section
            Container(
              width: super.screenWidthPercentage(context, 100),
              height: super.screenHeightPercentage(context, 6),
              padding: EdgeInsets.symmetric(
                  horizontal: super.screenWidthPercentage(context, 6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    ImageResources.instagram,
                    width: 26,
                    height: 26,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.chatListScreen);
                    },
                    child: Image.asset(
                      ImageResources.sendMessage,
                      width: 20,
                      height: 20,
                    ),
                  )
                ],
              ),
            ),

            LiquidPullToRefresh(
              showChildOpacityTransition: false,
              springAnimationDurationInMilliseconds: 200,
              color: primaryShade200,
              backgroundColor: primaryShade50,
              onRefresh: () async {
                initialise(context, true);
              },
              child: Column(
                children: [
                  Container(
                    width: super.screenWidthPercentage(context, 100),
                    height: super.screenHeightPercentage(context, 12),
                    padding: EdgeInsets.only(
                        left: super.screenWidthPercentage(context, 6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            Container(
                              width: super.screenWidthPercentage(context, 18),
                              height: super.screenWidthPercentage(context, 18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: BlocBuilder<PostBloc, PostState>(
                                builder: (context, state) {
                                  return UserAvatar(
                                    imageSize: super
                                        .screenWidthPercentage(context, 10),
                                    url: userData.profileImage ??
                                        ImageResources.networkUserOne,
                                    onLongPress: () {
                                      // Navigator.push(context, MaterialPageRoute(
                                      //     builder: (BuildContext context) {
                                      //   return StatusStorySlider(
                                      //     statusList: state.userStatus.statusList!,
                                      //     userId: state.userStatus.uuid!,
                                      //   );
                                      // }));
                                    },
                                    onPress: () async {
                                      uploadStatus(context);
                                    },
                                    radious: 100.0,
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: primaryShade500),
                                  child: const Icon(
                                    Icons.add,
                                    size: 18,
                                    color: white,
                                  )),
                            )
                          ],
                        ),
                        Expanded(
                          child: StreamBuilder(
                              stream: context
                                  .read<PostBloc>()
                                  .getFollowersStatusStreamEvent(
                                      context, userData.following ?? []),
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
                                        "No Post Yet",
                                        style: CoustomTextStyle.paragraph4,
                                      ),
                                    );
                                  }

                                  final value = snapshot.data;
                                  return ListView.separated(
                                    padding: const EdgeInsets.only(left: 10),
                                    // shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:(BuildContext context, int index) {
                                      final statusData = value![index];
                                      return StatusStoryCard(
                                        userStatus: statusData,
                                        onPress: () {
                                          Navigator.push(context, MaterialPageRoute(builder:(BuildContext context) {
                                            return StatusStorySlider(
                                                statusList: statusData.statusList!, userStatusId: statusData.uuid!,);
                                          }));
                                        },
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 6,
                                      );
                                    },
                                    itemCount: value?.length ?? 0,
                                  );
                                }

                                return Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                        snapshot.error.toString() ??
                                            "Some Error Occured",
                                        style: CoustomTextStyle.paragraph4));
                              }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: super.screenWidthPercentage(context, 100),
                    height: super.screenHeightPercentage(context, 70),
                    child: StreamBuilder(
                      stream: context
                          .read<HomeBloc>()
                          .getAllFriendsPostStreamEvent(
                              context, userData.following, false),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PostEntity>> snapshot) {
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
                              height: 500,
                              alignment: Alignment.center,
                              child: Text(
                                "No Post Yet",
                                style: CoustomTextStyle.paragraph4,
                              ),
                            );
                          }

                          final value = snapshot.data;
                          // print(value?.length);
                          return ListView.builder(
                            itemCount: value!.length ?? 0,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              final postData = value[index];
                              return UserPostCard(
                                postData: postData,
                                likedPostUser: likePost,
                              );
                            },
                          );
                        }

                        // if (snapshot.hasError) {
                        return Container(
                            height: 500,
                            alignment: Alignment.center,
                            child: Text(
                                snapshot.error.toString() ??
                                    "Some Error Occured",
                                style: CoustomTextStyle.paragraph4));
                        // }
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

uploadStatus(BuildContext context) async {
  List<String> imageExt = ['jpg', 'jpeg', 'png', 'webp'];
  List<String> videoExt = ['mp4', 'mov', 'avi'];

  final imageData =
      await InputFielUtils.getALlMyFile([...imageExt, ...videoExt]);

  if (imageData != null) {
    if (imageExt.contains(imageData.extension.toString())) {
      Navigator.pushNamed(context, RoutesName.addFilePreviewScreen, arguments: {
        "fileData": FileData(fileData: imageData, coustomfileType: CustomUploadFileType.Image),
        "navigateToScreen": RoutesName.addStatusDetailsScreen
      });
    } else {
      Navigator.pushNamed(context, RoutesName.addFilePreviewScreen, arguments: {
        "fileData": FileData(
            fileData: imageData, coustomfileType: CustomUploadFileType.Video),
        "navigateToScreen": RoutesName.addStatusDetailsScreen
      });
    }
  } else {}
}
