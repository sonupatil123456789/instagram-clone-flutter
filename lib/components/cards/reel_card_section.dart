import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/components/like_heart.dart';
import 'package:instagram_clone/components/user_avatar.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/LikeEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/HomeScreen/presentation/bloc/HomeBloc.dart';
import 'package:instagram_clone/src/HomeScreen/presentation/bloc/HomeEvent.dart';
import 'package:instagram_clone/src/HomeScreen/presentation/widgets/comment_user_post_bottomSheet.dart';
import 'package:instagram_clone/src/HomeScreen/presentation/widgets/liked_user_post_bottomsheet.dart';
import 'package:instagram_clone/src/HomeScreen/presentation/widgets/taged_user_post_bottomSheet.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/decoration.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';
import 'package:video_player/video_player.dart';

class ReelCardSection extends StatefulWidget {
  PostEntity videoPost;
  LikesEntity likedPostUser;

  ReelCardSection({
    super.key,
    required this.videoPost,
    required this.likedPostUser,
  });

  @override
  State<ReelCardSection> createState() => _ReelCardSectionState();
}

class _ReelCardSectionState extends State<ReelCardSection> with ScreenUtils {
  var isVideoPlaying = true;
  double showHideDiscription = 0.0;
  bool muteVolume = true;
  bool showHideVideoControlls = true;

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget
            .videoPost.postImage ??
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"))
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
      })
      ..play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLiked = widget.videoPost.likes!.contains(widget.likedPostUser);
    return SizedBox(
      width: super.screenWidthPercentage(context, 100),
      height: super.screenHeightPercentage(context, 100),
      child: GestureDetector(
        onLongPressStart: (onLongPressStart) {
          setState(() {
            showHideDiscription = 1.0;
          });
        },
        onLongPressEnd: (onLongPressEnd) {
          setState(() {
            showHideDiscription = 0.0;
          });
        },
        child: Stack(
          children: [
            Container(
              width: super.screenWidthPercentage(context, 100),
              height: super.screenHeightPercentage(context, 100),
              color: primaryShade50,
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: primaryShade500,
                        strokeWidth: 4,
                      ),
                    ),
            ),

            // user information card
            Positioned(
              bottom: super.screenHeightPercentage(context, 12),
              child: Container(
                width: super.screenWidthPercentage(context, 100),
                height: super.screenHeightPercentage(context, 5),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    UserAvatar(
                      imageSize: super.screenWidthPercentage(context, 10),
                      url: ImageResources.networkUserOne,
                      onPress: () {},
                      radious: 100.0,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.videoPost.uniqueName ?? "No Data",
                          style: CoustomTextStyle.paragraph2.copyWith(
                              fontWeight: FontWeight.w500, color: white),
                        ),
                        Text(
                          widget.videoPost.location ?? "No Location",
                          style: CoustomTextStyle.paragraph5
                              .copyWith(color: white),
                        )
                      ],
                    ),
                    const Expanded(
                      child: SizedBox(
                        width: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // discription section
            Opacity(
              opacity: showHideDiscription,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: super.screenWidthPercentage(context, 100),
                  height: super.screenHeightPercentage(context, 100),
                  padding: EdgeInsets.symmetric(
                      horizontal: super.screenWidthPercentage(context, 6),
                      vertical: super.screenHeightPercentage(context, 10)),
                  decoration: BoxDecoration(
                    color: black.withOpacity(0.8),
                  ),
                  child: Text(
                    widget.videoPost.postDiscription ?? '',
                    style: CoustomTextStyle.paragraph4.copyWith(color: white),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: AnimatedOpacity(
                  opacity: showHideVideoControlls ? 0.0 : 1.0,
                  duration: const Duration(microseconds: 300),
                  child: playPauseControllers(context, isVideoPlaying)),
            ),

            // size bar buttons
            Positioned(
              top: super.screenHeightPercentage(context, 55),
              right: super.screenWidthPercentage(context, 5),
              child: SizedBox(
                width: super.screenWidthPercentage(context, 14),
                height: super.screenHeightPercentage(context, 25),
                // color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    sideButtons(
                        context: context,
                        icon: isLiked
                            ? ImageResources.likeFilled
                            : ImageResources.like,
                        textData: '${widget.videoPost.likes?.length ?? 0}',
                        onTap: () {
                          showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return LikedUserPostBottomSheet(
                                  likesList: widget.videoPost.likes,
                                );
                              }
                            );
                        }),
                    sideButtons(
                        context: context,
                        icon: ImageResources.message,
                        textData: '${0}',
                        onTap: () {
                            showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return CommentUserPostBottomSheet(
                              postData: widget.videoPost,
                            );
                          });
                        }),
                    sideButtons(
                        context: context,
                        icon: ImageResources.tag,
                        textData: '${widget.videoPost.tagPeople?.length ?? 0}',
                        onTap: () {
                          showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return TagedUserPostBottomSheet(
                                  tagedPeopleList: widget.videoPost.tagPeople,
                                );
                              });
                        }),
                  ],
                ),
              ),
            ),

            // mute un mute switch
            Positioned(
              bottom: super.screenHeightPercentage(context, 12),
              right: super.screenWidthPercentage(context, 5),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    muteVolume = !muteVolume;
                    _controller.setVolume(muteVolume ? 1.0 : 0.0);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  height: super.screenHeightPercentage(context, 4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          width: 2, color: white, style: BorderStyle.solid)),
                  child: Text(
                    muteVolume ? "Mute" : "Unmute",
                    style: CoustomTextStyle.paragraph4.copyWith(color: white),
                  ),
                ),
              ),
            ),

            Positioned(
              top: super.screenHeightPercentage(context, 50),
              right: super.screenWidthPercentage(context, 20),
              child: Container(
                alignment: Alignment.center,
                // color: Colors.greenAccent,
                width: super.screenWidthPercentage(context, 80),
                height: super.screenHeightPercentage(context, 30),
                child: DoubleTapLikeButton(
                  onDoubleTap: () {
                    context.read<HomeBloc>().add(LikePostEvent(
                        context: context,
                        likePost: widget.likedPostUser,
                        postId: widget.videoPost.postId.toString()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget playPauseControllers(context, bool state) {
    return InkWell(
      onTap: () {
        // video is playing
        if (state == true) {
          setState(() {
            showHideVideoControlls = false;
            _controller.pause();
          });

          isVideoPlaying = false;
        } else {
          setState(() {
            showHideVideoControlls = true;
            _controller.play();
          });
          isVideoPlaying = true;
        }
      },
      child: Container(
        decoration: transperentBlackBox,
        width: super.screenWidthPercentage(context, 20),
        height: super.screenWidthPercentage(context, 20),
        child: Icon(state ? Icons.pause : Icons.play_arrow),
      ),
    );
  }

  Widget sideButtons(
      {required context,
      required String icon,
      required String textData,
      required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        height: super.screenHeightPercentage(context, 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              icon,
              width: 18,
              height: 18,
              color: white,
              colorBlendMode: BlendMode.srcIn,
            ),
            Text(
              textData,
              style: CoustomTextStyle.paragraph3.copyWith(color: white),
            )
          ],
        ),
      ),
    );
  }
}


