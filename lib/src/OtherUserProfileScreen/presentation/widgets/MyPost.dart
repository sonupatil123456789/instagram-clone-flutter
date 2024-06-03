import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';
// Import your file type extension

class MyPosts extends StatelessWidget with ScreenUtils {
  final List<PostEntity> myPostList;

  MyPosts({super.key, required this.myPostList});

  @override
  Widget build(BuildContext context) {
    List<PostEntity> imagePostList = myPostList
        .where((post) =>
            CustomUploadFileTypeExtension.stringToEnum(
                post.postImageFileType!) ==
            CustomUploadFileType.Image)
        .toList();

    if (imagePostList.isEmpty) {
      return Center(
          child: Text("No Post Yet", style: CoustomTextStyle.paragraph4));
    }

    return GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount: imagePostList.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 5,
        crossAxisSpacing: 8,
        crossAxisCount: 3,
        childAspectRatio: 0.8 / 0.8,
      ),
      itemBuilder: (BuildContext context, int index) {
        final post = imagePostList[index];

        return Container(
          height: screenHeightPercentage(context, 46),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.imageDetailScreen,
                    arguments: {'postUrl': post.postImage});
              },
              child: CachedNetworkImage(
                imageUrl: post.postImage ?? ImageResources.networkUserOne,
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
