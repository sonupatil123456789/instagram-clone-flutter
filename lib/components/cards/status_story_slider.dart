import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/StatusEntity.dart';
import 'package:instagram_clone/src/Authantication/data/model/HiveUserModel.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class StatusStorySlider extends StatefulWidget {
  List<StatusEntity> statusList;
  String userStatusId ;

  StatusStorySlider({
    super.key,
    required this.statusList,
    required this.userStatusId
  });

  @override
  State<StatusStorySlider> createState() => _StatusStorySliderState();
}

class _StatusStorySliderState extends State<StatusStorySlider> with ScreenUtils{
  PageController controller = PageController();
  Box<HiveUserModel> userDataBase = Hive.box<HiveUserModel>('UserDataBase');

  int selectedStory = 0;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    HiveUserModel? user = userDataBase.get("User");

    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (widget.statusList.length == selectedStory) {
         Future.delayed(const Duration(seconds: 2));
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SizedBox(
        child: PageView.builder(
          itemCount: widget.statusList.length,
          controller: controller,
          onPageChanged: (value) {
          
          },
          itemBuilder: (BuildContext context, int index) {
            final ststus = widget.statusList[index];
            return Column(
              children: [
                SizedBox(
                    height: super.screenHeightPercentage(context, 90),
                  child: AspectRatio(
                    aspectRatio: 16/9,
                    child: CachedNetworkImage(
                      imageUrl: ststus.statusImage ?? ImageResources.networkUserOne,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  color: black,
                  alignment: Alignment.center,
                  height: super.screenHeightPercentage(context, 10),
                   child: Text(ststus.statusDiscription ?? "" , style: CoustomTextStyle.paragraph3.copyWith(
                    color: white
                   ),),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}


const String discription = ' https://firebasestorage.googleapis.com/v0/b/instagramclone-d205f.appspot.com/o/Files%2FK79R9dnFfLVYDGG8VGWQXX20dXf1%2Fhappy%20birthday%20Deepu%2FInstagram_1000062559.jpg_happy%20birthday%20Deepu_1715241885492?alt=media&token=88518e24-aaa8-490c-a006-0dcce019d410, statusImageFileType: Image, statusDiscription: happy birthday Deepu, tagPeople: [], viewedStatus: [], createdAt: 2024-05-09 13:34:50.248106 ), StatusModel (statusId: ba03af4e-fce5-46d6-a5b4-c8ddf5bae214, statusImage: https://firebasestorage.googleapis.com/v0/b/instagramclone-d205f.appspot.com/o/Files%2FK79R9dnFfLVYDGG8VGWQXX20dXf1%2Fhappy%20holidays%20%F0%9F%8E%88%2FInstagram_1000055773.jpg_happy%20holidays%20%F0%9F%8E%88_1715241929852?alt=media&token=b3909a52-ae6a-4c1b-8460-557547d0d466';
