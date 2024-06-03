import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/UserProfileScreen/presentation/screens/UserProfileScreen.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class MyReels extends StatelessWidget with ScreenUtils {
  List<PostEntity> myPostList;

  MyReels({super.key, required this.myPostList});

  @override
  Widget build(BuildContext context) {
    List<PostEntity> videoPostList = myPostList
        .where((post) =>CustomUploadFileTypeExtension.stringToEnum(post.postImageFileType!) ==CustomUploadFileType.Video)
        .toList();

    if (videoPostList.isEmpty) {
      return Center(
          child: Text("No Reel Yet", style: CoustomTextStyle.paragraph4));
    }

    return GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount: videoPostList.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 5,
        crossAxisSpacing: 8,
        crossAxisCount: 3,
        childAspectRatio: 0.8 / 0.8,
      ),
      itemBuilder: (BuildContext context, int index) {
        final post = videoPostList[index];

        return Container(
          height: screenHeightPercentage(context, 46),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.videoDetailScreen,
                      arguments: {'postUrl': post.postImage});
                },
                onLongPress: () {
                  deletPost(post.postId!, context);
                },
                child: GestureDetector(
                    child: Container(
                  color: blac2,
                  child: const Icon(
                    Icons.movie,
                    color: white,
                    size: 18,
                  ),
                ))),
          ),
        );
      },
    );
  }
}
