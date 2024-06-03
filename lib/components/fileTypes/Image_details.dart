import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/components/cards/discover_grid_card.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';


class ImageDetails extends StatefulWidget {
  String url;

  ImageDetails({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<ImageDetails> createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> with ScreenUtils {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SizedBox(
        width: super.screenWidthPercentage(context, 100),
        height: super.screenHeightPercentage(context, 100),
        child: Stack(
          alignment: Alignment.center,
          children: [
         

        

            CachedNetworkImage(
              imageUrl: widget.url ?? dummyImage,
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

               SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: BackButtonNavbar(
                  onPress: () {
                    Navigator.pop(context);
                  },
                  center: null
                ),
              ),
            ),

            // Text(fileData.fileData.path)
          ],
        ),
      ),
    );
  }
}
