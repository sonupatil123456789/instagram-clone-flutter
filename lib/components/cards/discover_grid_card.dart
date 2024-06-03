import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';

const String dummyImage =
    'https://plus.unsplash.com/premium_photo-1707988180195-c56006657514?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

class DiscoverGridCard extends StatelessWidget {
  PostEntity postData;
  Function? longPress;

  DiscoverGridCard({super.key, required this.postData, this.longPress});

  @override
  Widget build(BuildContext context) {
    CustomUploadFileType fileType =
        CustomUploadFileTypeExtension.stringToEnum(postData.postImageFileType!);

    if (fileType == CustomUploadFileType.Image) {
      return GestureDetector(
        onLongPress: () {
          if (longPress == null ) {
            
          }else{
              longPress!();
          }
        },
        onTap: () {
          Navigator.pushNamed(context, RoutesName.imageDetailScreen,
              arguments: {'postUrl': postData.postImage});
        },
        child: CachedNetworkImage(
          imageUrl: postData.postImage ?? dummyImage,
          fit: BoxFit.cover,
          placeholder: (context, url) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: primaryShade500,
              ),
            ],
          ),
          errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error)),
        ),
      );
    }
    if (fileType == CustomUploadFileType.Video) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RoutesName.videoDetailScreen,
              arguments: {'postUrl': postData.postImage});
        },
        child: Container(
          color: blac2,
          alignment: Alignment.center,
          child: const Icon(
            Icons.movie,
            color: white,
          ),
        ),
      );
    } else {
      return const SizedBox(child: Icon(Icons.error));
    }
  }
}
