import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';

class UserAvatar extends StatelessWidget {
  double imageSize;
  String url;
  Function onPress;
  Function? onLongPress;
  double radious;

  UserAvatar(
      {super.key,
      this.onLongPress,
      required this.imageSize,
      required this.url,
      required this.onPress,
      required this.radious});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
       await onPress();
      },
      onLongPress: () {
       if (onLongPress != null) {
          onLongPress!();
       }
      },
      child: Container(
        height: imageSize,
        width: imageSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radious)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(radious)),
          child: CachedNetworkImage(
            imageUrl: url,
            height: imageSize,
            width: imageSize,
            fit: BoxFit.cover,
            errorListener: (value) {
              print("error in image ${value.toString()}");
            },
            placeholder: (context, url) {
              return Image.asset(ImageResources.localUserOne);
              
            },
            errorWidget: (context, url, error) => Image.asset(ImageResources.localUserOne)
          ),
        ),
      ),
    );
  }
}
