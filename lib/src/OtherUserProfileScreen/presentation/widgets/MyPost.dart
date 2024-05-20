import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class MyPosts extends StatelessWidget with ScreenUtils {
  const MyPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      showChildOpacityTransition: false,
      springAnimationDurationInMilliseconds: 200,
      color: primaryShade200,
      backgroundColor: primaryShade50,
      onRefresh: () async {},
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Image.network(
                'https://plus.unsplash.com/premium_photo-1707988180195-c56006657514?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                height: super.screenHeightPercentage(context, 46),
                width: super.screenWidthPercentage(context, 100),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        itemCount: 12,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5,
            crossAxisSpacing: 8,
            crossAxisCount: 3,
            childAspectRatio: 0.8 / 0.8),
      ),
    );
  }
}
