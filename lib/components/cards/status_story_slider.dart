import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/StatusEntity.dart';
import 'package:instagram_clone/src/Authantication/data/model/HiveUserModel.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';
import 'package:video_player/video_player.dart';

class StatusStorySlider extends StatefulWidget {
  List<StatusEntity> statusList;
  String userStatusId;

  StatusStorySlider(
      {super.key, required this.statusList, required this.userStatusId});

  @override
  State<StatusStorySlider> createState() => _StatusStorySliderState();
}

class _StatusStorySliderState extends State<StatusStorySlider>
    with ScreenUtils {
  PageController controller = PageController();
  Box<HiveUserModel> userDataBase = Hive.box<HiveUserModel>('UserDataBase');

  int selectedStory = 0;
  late final Timer _timer;

  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    HiveUserModel? user = userDataBase.get("User");

    _timer = Timer.periodic(const Duration(seconds: 200), (_) {
      if (widget.statusList.length == selectedStory) {
        Future.delayed(const Duration(seconds: 200));
        Navigator.pop(context);
      } else {
        selectedStory = selectedStory + 1;
        setState(() {
          controller.animateToPage(selectedStory,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInCubic);
        });
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SizedBox(
        child: Stack(
          children: [
            PageView.builder(
              itemCount: widget.statusList.length,
              controller: controller,
              onPageChanged: (value) {},
              itemBuilder: (BuildContext context, int index) {
                final ststus = widget.statusList[index];
                return Column(
                  children: [
                    SizedBox(
                      height: super.screenHeightPercentage(context, 90),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: dynamicSocialMediaStatus(
                            ststus,
                            super.screenWidthPercentage(context, 100),
                            super.screenHeightPercentage(context, 100),
                            context),

                        // child: CachedNetworkImage(
                        //   imageUrl: ststus.statusImage ??
                        //       ImageResources.networkUserOne,
                        //   fit: BoxFit.cover,
                        //   errorWidget: (context, url, error) =>
                        //       const Center(child: Icon(Icons.error)),
                        // ),
                      ),
                    ),
                    Container(
                      color: black,
                      alignment: Alignment.center,
                      height: super.screenHeightPercentage(context, 10),
                      child: Text(
                        ststus.statusDiscription ?? "",
                        style:
                            CoustomTextStyle.paragraph3.copyWith(color: white),
                      ),
                    )
                  ],
                );
              },
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: BackButtonNavbar(
                    onPress: () {
                      Navigator.pop(context);
                    },
                    center: null),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dynamicSocialMediaStatus(
      StatusEntity status,
      // VideoPlayerController? controller,
      double width,
      double hight,
      BuildContext context) {
    CustomUploadFileType fileType =
        CustomUploadFileTypeExtension.stringToEnum(status.statusImageFileType!);

    if (fileType == CustomUploadFileType.Video) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(status
              .statusImage ?? "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"))
        ..setLooping(true)
        ..initialize().then((_) {
          _controller?.setVolume(0.1);
          // setState(() {});
        })
        ..play();
    }

    if (fileType == CustomUploadFileType.Image) {
      return GestureDetector(
        onTap: () {},
        child: CachedNetworkImage(
          imageUrl: status.statusImage ?? ImageResources.networkUserOne,
          height: hight * 0.44,
          width: width,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
              color: primaryShade500,
            ),
          ),
          errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error)),
        ),
      );
    }
    if (fileType == CustomUploadFileType.Video) {
        if (controller != null) {
      return GestureDetector(
        onTap: () {},
        child: VideoPlayer(_controller!),
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
}
