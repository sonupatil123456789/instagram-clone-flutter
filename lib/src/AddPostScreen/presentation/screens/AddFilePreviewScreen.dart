import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/components/coustom_button.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/screen_utils/file_model.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';
import 'package:video_player/video_player.dart';

class AddFilePreviewScreen extends StatefulWidget {
  FileData fileData;
  String navigateToScreen;

  AddFilePreviewScreen({
    Key? key,
    required this.fileData,
    required this.navigateToScreen
  }) : super(key: key);

  @override
  State<AddFilePreviewScreen> createState() => _AddFilePreviewScreenState();
}

class _AddFilePreviewScreenState extends State<AddFilePreviewScreen> with ScreenUtils {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    if ((widget.fileData.coustomfileType == CustomUploadFileType.Video)) {
      _controller =
          VideoPlayerController.file(File(widget.fileData.fileData.path))
            ..setLooping(true)
            ..initialize().then((_) {
              setState(() {});
            })
            ..play();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryShade50,
      body: SizedBox(
        width: super.screenWidthPercentage(context, 100),
        height: super.screenHeightPercentage(context, 100),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (widget.fileData.coustomfileType == CustomUploadFileType.Video &&
                _controller != null) ...[
              if (_controller!.value.isInitialized) ...[
                VideoPlayer(_controller!),
              ] else ...[
                Center(
                  child: CircularProgressIndicator(
                    color: primaryShade500,
                    strokeWidth: 4,
                  ),
                ),
              ],
            ] else ...[
              if (widget.fileData.fileData is PlatformFile) ...[
                Image.file(File(widget.fileData.fileData.path))
              ],
              if (widget.fileData.fileData is XFile) ...[
                Image.file(File(widget.fileData.fileData.path))
              ] else ...[
                Image.file(File(widget.fileData.fileData.path))
              ],
            ],

            // appbar section

            SafeArea(
              child: Align(
                  alignment: Alignment.topCenter,
                  child: BackButtonNavbar(
                    onPress: () {
                      Navigator.pop(context);
                    },
                    center: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Post Priview",
                        style: CoustomTextStyle.paragraph1,
                      ),
                    ),
                  )),
            ),

            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding:
                      EdgeInsets.all(super.screenWidthPercentage(context, 6)),
                  child: CoustomButton(
                    height: super.screenHeightPercentage(context, 6),
                    backgroundColor: primaryShade500,
                    text: 'Next',
                    onTap: () async {
                      Navigator.pushNamed(
                          context, widget.navigateToScreen,
                          arguments: {"fileData": widget.fileData});
                    },
                    width: super.screenWidthPercentage(context, 30),
                    borderRadious: screenWidthPercentage(context, 20),
                  ),
                ))

            // Text(fileData.fileData.path)
          ],
        ),
      ),
    );
  }
}
