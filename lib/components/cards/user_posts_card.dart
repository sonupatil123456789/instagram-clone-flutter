import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:instagram_clone/src/BookmarkScreen/presentation/bloc/BookmarkBloc.dart';
import 'package:instagram_clone/src/BookmarkScreen/presentation/bloc/BookmarkEvent.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:video_player/video_player.dart';
import '../../utils/theams/text_theams.dart';

class UserPostCard extends StatefulWidget {
  PostEntity postData;
  LikesEntity likedPostUser;

  UserPostCard({
    super.key,
    required this.postData,
    required this.likedPostUser,
  });

  @override
  State<UserPostCard> createState() => _UserPostCardState();
}

class _UserPostCardState extends State<UserPostCard> with ScreenUtils {
  bool showDiscription = false;
  bool muteVolume = true;

  VideoPlayerController? _controller;
  late CustomUploadFileType fileType;

  @override
  void initState() {
    super.initState();
    fileType = CustomUploadFileTypeExtension.stringToEnum(
        widget.postData.postImageFileType!);

    // if (fileType == CustomUploadFileType.Video) {
    //   _controller = VideoPlayerController.networkUrl(Uri.parse(widget
    //           .postData.postImage ??
    //       "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"))
    //     ..setLooping(true)
    //     ..initialize().then((_) {
    //       _controller?.setVolume(0.0);
    //       setState(() {});
    //     })
    //     ..play();
    // }
  }

  @override
  Widget build(BuildContext context) {
    bool _isLiked = widget.postData.likes!.contains(widget.likedPostUser);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: super.screenHeightPercentage(context, 3),
      ),
      child: Container(
        width: super.screenWidthPercentage(context, 100),
        height: super.screenHeightPercentage(context, 56),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          // color: primaryShade200,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: super.screenHeightPercentage(context, 5),
              child: Row(
                children: [
                  UserAvatar(
                    imageSize: super.screenWidthPercentage(context, 10),
                    url: widget.postData.profileImage ??
                        ImageResources.networkUserOne,
                    onPress: () {
                      Navigator.pushNamed(
                          context, RoutesName.otherUserProfileScreen,
                          arguments: {'uuid': widget.postData.uuid});
                    },
                    radious: 100.0,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RoutesName.otherUserProfileScreen,
                          arguments: {'uuid': widget.postData.uuid});
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.postData.uniqueName ?? "",
                          style: CoustomTextStyle.paragraph2
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          widget.postData.location ?? "Unknown Location",
                          style: CoustomTextStyle.paragraph5.copyWith(),
                        )
                      ],
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 10,
                    ),
                  ),
                  if (fileType == CustomUploadFileType.Video) ...[
                    IconButton(
                        onPressed: () {
                          setState(() {
                            muteVolume = !muteVolume;
                            _controller?.setVolume(muteVolume ? 0.0 : 1.0);
                          });
                        },
                        icon: Icon(
                          muteVolume ? Icons.volume_off : Icons.volume_up,
                          size: 20,
                        ))
                  ],
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<BookmarkBloc>().add(AddBookmarkEvent(
                          bookmark: widget.postData, context: context));
                    },
                    child: Image.asset(
                      ImageResources.bookMark,
                      width: 18,
                      height: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            GestureDetector(
              onLongPress: () {
                setState(() {
                  showDiscription = !showDiscription;
                });
              },
              child: SizedBox(
                height: super.screenHeightPercentage(context, 44),
                width: super.screenWidthPercentage(context, 100),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: dynamicSocialMediaPost(
                          widget.postData,
                          _controller,
                          super.screenWidthPercentage(context, 100),
                          super.screenHeightPercentage(context, 100),
                          context),
                    ),
                    Visibility(
                      visible: showDiscription,
                      child: Container(
                        color: primaryShade50
                            .withOpacity(showDiscription ? 0.9 : 0.0),
                        height: super.screenHeightPercentage(context, 44),
                        padding: const EdgeInsets.all(20),
                        width: super.screenWidthPercentage(context, 100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.postData.postDiscription ??
                                  "No Discription",
                              softWrap: true,
                              style: CoustomTextStyle.paragraph5.copyWith(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (widget.postData != []) ...[
                              Wrap(
                                children: widget.postData.tags!.map((e) {
                                  return Text(
                                    e.toString(),
                                    softWrap: true,
                                    style: CoustomTextStyle.paragraph4
                                        .copyWith(fontWeight: FontWeight.w400),
                                  );
                                }).toList(),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: DoubleTapLikeButton(
                        onDoubleTap: () {
                          context.read<HomeBloc>().add(LikePostEvent(
                              context: context,
                              likePost: widget.likedPostUser,
                              postId: widget.postData.postId.toString()));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: super.screenHeightPercentage(context, 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return LikedUserPostBottomSheet(
                              likesList: widget.postData.likes,
                            );
                          });
                    },
                    child: Image.asset(
                      _isLiked
                          ? ImageResources.likeFilled
                          : ImageResources.like,
                      width: 18,
                      height: 18,
                      color: _isLiked ? errorColor : grey1,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${widget.postData.likes?.length ?? 0} likes",
                    style: CoustomTextStyle.paragraph4,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return CommentUserPostBottomSheet(
                              postData: widget.postData,
                            );
                          });
                    },
                    child: Image.asset(
                      ImageResources.message,
                      width: 18,
                      height: 18,
                    ),
                  ),
                  // chat_bubble
                  const Expanded(
                      child: SizedBox(
                    width: 5,
                  )),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return TagedUserPostBottomSheet(
                              tagedPeopleList: widget.postData.tagPeople,
                            );
                          });
                    },
                    child: Image.asset(
                      ImageResources.tag,
                      width: 18,
                      height: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget dynamicSocialMediaPost(
    PostEntity post,
    VideoPlayerController? controller,
    double width,
    double hight,
    BuildContext context) {
  CustomUploadFileType fileType =
      CustomUploadFileTypeExtension.stringToEnum(post.postImageFileType!);

  if (fileType == CustomUploadFileType.Image) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.imageDetailScreen,
            arguments: {'postUrl': post.postImage});
      },
      child: CachedNetworkImage(
        imageUrl: post.postImage ?? ImageResources.networkUserOne,
        height: hight * 0.44,
        width: width,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
          color: primaryShade500,
        )),
        errorWidget: (context, url, error) =>
            const Center(child: Icon(Icons.error)),
      ),
    );
  }
  if (fileType == CustomUploadFileType.Video) {
    if (controller != null) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RoutesName.videoDetailScreen,
              arguments: {'postUrl': post.postImage});
        },
        child: VideoPlayer(controller!),
      );
    }

    return Center(
      child: CircularProgressIndicator(
        color: primaryShade500,
      ),
    );
  } else {
    return const Center(child: Icon(Icons.error));
  }
}
