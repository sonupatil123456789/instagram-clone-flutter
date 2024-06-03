import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/input_field_utils.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> with ScreenUtils {
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
              SizedBox(
                height: super.screenHeightPercentage(context, 5),
              ),
              SizedBox(
                width: double.maxFinite,
                height: super.screenHeightPercentage(context, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    pickerCard(
                        title: 'Camera',
                        iconImage: ImageResources.camera,
                        size: super.screenWidthPercentage(context, 30),
                        onTap: () async {
                          final imageData = await InputFielUtils.getMyFile([], FileType.image, CustomUploadFileType.Image);
                          if (imageData != null) {
                            Navigator.pushNamed(context, RoutesName.addFilePreviewScreen, arguments: {"fileData" :imageData,"navigateToScreen" :RoutesName.addPostDetailsScreen});
                          } else {}
                        }),
                    pickerCard(
                        title: 'Video',
                        iconImage: ImageResources.video,
                        size: super.screenWidthPercentage(context, 30),
                        onTap: () async {
                          final imageData = await InputFielUtils.getMyFile([], FileType.video, CustomUploadFileType.Video);

                          if (imageData != null) {
                            Navigator.pushNamed(context, RoutesName.addFilePreviewScreen, arguments: {"fileData" :imageData,"navigateToScreen" :RoutesName.addPostDetailsScreen });
                          } else {}
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pickerCard(
      {required String title,
      required String iconImage,
      required dynamic size,
      required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Row(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
                color: primaryShade100,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(iconImage, width: size / 3, height: size / 3),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  title,
                  style: CoustomTextStyle.paragraph4
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
