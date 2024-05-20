import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';

class BackButtonNavbar extends StatelessWidget with ScreenUtils {
  Function onPress;
  Widget? center ;
  IconData? icon ;

  BackButtonNavbar({super.key,required this. onPress ,required this.center , this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: super.screenWidthPercentage(context, 100),
      height: super.screenHeightPercentage(context, 6),
      padding: EdgeInsets.symmetric(
          horizontal: super.screenWidthPercentage(context, 6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: super.screenWidthPercentage(context, 10),
              height: super.screenWidthPercentage(context, 10),
              padding: EdgeInsets.only(
                  left: super.screenWidthPercentage(context, icon != null ? 0 : 1)),
              decoration: BoxDecoration(
                  color: primaryShade500,
                  borderRadius: BorderRadius.circular(50)),
              child:  Icon(
                icon  ?? Icons.arrow_back_ios,
                color: white,
                size: 16,
              ),
            ),
          ),

          SizedBox(width: super.screenWidthPercentage(context, 4),),
          Expanded(child: Container(
            child: center ?? const  SizedBox(),
          ))
        ],
      ),
    );
  }
}
