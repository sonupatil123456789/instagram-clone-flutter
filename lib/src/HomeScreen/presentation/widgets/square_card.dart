import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class SquareCard extends StatelessWidget with ScreenUtils {
  dynamic data;

  SquareCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       Navigator.pushNamed(context, RoutesName.otherUserProfileScreen , arguments: {'uuid': data.uuid});
      },
      child: Container(
        width: super.screenWidthPercentage(context, 30),
        height: super.screenHeightPercentage(context, 14),
        decoration: BoxDecoration(
          color: primaryShade100,
          borderRadius: BorderRadius.circular(10)
        ),
        padding: EdgeInsets.symmetric(horizontal: super.screenWidthPercentage(context, 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: super.screenWidthPercentage(context, 14),
              height: super.screenWidthPercentage(context, 14),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                      color: primaryShade500,
                      width: 2,
                      style: BorderStyle.solid),
                    ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl:data?.profileImage ?? ImageResources.networkUserOne,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(color : primaryShade500),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(
              height: screenWidthPercentage(context, 3),
            ),
            Text(
              data?.uniqueName ?? "No Data",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: CoustomTextStyle.paragraph4 .copyWith(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
