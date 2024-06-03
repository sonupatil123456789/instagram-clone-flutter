import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/UserProfileScreen/presentation/screens/UserProfileScreen.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:path/path.dart';

class All extends StatelessWidget with ScreenUtils {
  List<PostEntity> myPostList;

  All({super.key, required this.myPostList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        final post = myPostList[index];

        return Container(
          height: super.screenHeightPercentage(context, 46),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: dynamicSocialMediaPost(
                  post,
                  super.screenWidthPercentage(context, 100),
                  super.screenHeightPercentage(context, 100),context)),
        );
      },
      itemCount: myPostList.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisSpacing: 8,
          crossAxisCount: 3,
          childAspectRatio: 0.8 / 0.8),
    );
  }
}

Widget dynamicSocialMediaPost(
  PostEntity post,
  double width,
  double hight,
  BuildContext context 
) {
  CustomUploadFileType fileType =
      CustomUploadFileTypeExtension.stringToEnum(post.postImageFileType!);

  if (fileType == CustomUploadFileType.Image) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.imageDetailScreen, arguments: {'postUrl' :post.postImage});
      },
      child: CachedNetworkImage(
        imageUrl: post.postImage ?? ImageResources.networkUserOne,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) =>const Center(child: Icon(Icons.error)),
      ),
    );
  }
  if (fileType == CustomUploadFileType.Video) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.videoDetailScreen, arguments: {'postUrl' :post.postImage});
      },
      child: Container(
      color: blac2,
      child: const Icon(
        Icons.movie,
        color: white,
        size: 18,
      ),
    ));
  } else {
    return const SizedBox(child: Icon(Icons.error,));
  }
}


