import 'package:flutter/material.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/decoration.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';
import 'package:video_player/video_player.dart';

class VideoDetails extends StatefulWidget {
  String url;

  VideoDetails({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> with ScreenUtils {
  VideoPlayerController? _controller;
  var isVideoPlaying = true;
  double showHideDiscription = 0.0;
  bool muteVolume = true;
  bool showHideVideoControlls = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
      })
      ..play();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SizedBox(
        width: super.screenWidthPercentage(context, 100),
        height: super.screenHeightPercentage(context, 100),
        child: Stack(
          children: [
      

            if (_controller!.value.isInitialized) ...[
              VideoPlayer(_controller!)
            ] else ...[
              Center(
                child: CircularProgressIndicator(
                  color: primaryShade500,
                  strokeWidth: 4,
                ),
              ),
            ],


                  SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: BackButtonNavbar(
                    onPress: () {
                      Navigator.pop(context);
                    },
                    center: Row(
                      children: [
                        const Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              muteVolume = !muteVolume;
                              _controller?.setVolume(muteVolume ? 1.0 : 0.0);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            height: super.screenHeightPercentage(context, 4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 2,
                                    color: white,
                                    style: BorderStyle.solid)),
                            child: Text(
                              muteVolume ? "Mute" : "Unmute",
                              style: CoustomTextStyle.paragraph4
                                  .copyWith(color: white),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),


            Align(
              alignment: Alignment.center,
              child: AnimatedOpacity(
                  opacity: showHideVideoControlls ? 0.0 : 1.0,
                  duration: const Duration(microseconds: 300),
                  child: playPauseControllers(context, isVideoPlaying)),
            ),

            // Text(fileData.fileData.path)
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
            _controller!.pause();
          });

          isVideoPlaying = false;
        } else {
          setState(() {
            showHideVideoControlls = true;
            _controller!.play();
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
}
