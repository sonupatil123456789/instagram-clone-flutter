import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class LockedProfile extends StatelessWidget with ScreenUtils{
  const LockedProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.asset(ImageResources.profileLocked, width:super.screenWidthPercentage(context, 25) ,),
        const SizedBox(height: 10,),
        Text("This account is private" ,  style: CoustomTextStyle.paragraph1),
        const SizedBox(height: 5,),
        Text("Follow this account to see their photos and video" ,  style: CoustomTextStyle.paragraph4)

      ],),
    );
  }
}