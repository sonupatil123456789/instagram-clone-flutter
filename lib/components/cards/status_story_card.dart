import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:instagram_clone/src/AddPostScreen/domain/entity/UserStatusEntity.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class StatusStoryCard extends StatelessWidget with ScreenUtils {
  UserStatusEntity userStatus;  
  Function onPress;
   StatusStoryCard({
    super.key,
    required this.userStatus,
    required this.onPress
    });



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      onPress();
      },
      child: SizedBox(
        width: super.screenWidthPercentage(context, 22),
        // color: Colors.amberAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: super.screenWidthPercentage(context, 18),
              height: super.screenWidthPercentage(context, 18),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                  border: Border.all(color:  primaryShade500, width: 2, style: BorderStyle.solid)
                // border: Border.all(color: userStatus.isStatusViewed == true ? grey1 : primaryShade500, width: 2, style: BorderStyle.solid)
                ),
              child: ClipRRect(
                 borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: userStatus.profileImage ?? ImageResources.networkUserOne,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>  CircularProgressIndicator(color: primaryShade500,),
                 errorWidget: (context, url, error) => Image.asset(ImageResources.localUserOne)
                ),
              ),
            ),

            const SizedBox(height: 3,),
        
            Text("@ ${userStatus.uniqueName}"  , style: CoustomTextStyle.paragraph5, maxLines: 1, overflow: TextOverflow.ellipsis,)
        
        
          ],
        ),
      ),
    );
  }
}
