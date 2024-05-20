import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';

const String dummyImage =
    'https://plus.unsplash.com/premium_photo-1707988180195-c56006657514?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

class DiscoverGridCard extends StatelessWidget {
  PostEntity postData;

  DiscoverGridCard({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      child: dynamicFileType(postData)
    );
  }
}

Widget dynamicFileType(PostEntity post) {
  CustomUploadFileType fileType =
      CustomUploadFileTypeExtension.stringToEnum(post.postImageFileType!);

  if (fileType == CustomUploadFileType.Image) {
    return GestureDetector(
      child: CachedNetworkImage(
        imageUrl: post.postImage ?? dummyImage,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
  if (fileType == CustomUploadFileType.Video) {
    return GestureDetector(
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
