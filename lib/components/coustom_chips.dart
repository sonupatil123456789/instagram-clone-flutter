import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class CoustomChips extends StatelessWidget with ScreenUtils {
  String text;
  final data ;
  Function? onIconPress;

  CoustomChips({super.key, required this.text,  this.onIconPress , required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: super.screenHeightPercentage(context, 4),
          padding: const EdgeInsets.only(left: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: primaryShade500),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(text.toString(), style: CoustomTextStyle.paragraph4.copyWith(
                color: white,
                fontWeight: FontWeight.w300
              ),),
              const SizedBox(
                width: 6,
              ),
        
              onIconPress  == null ? GestureDetector(
                onTap: () {
                  if (onIconPress != null) {
                     onIconPress!(data);
                  } 
                },
                child: Container(
                  width: super.screenHeightPercentage(context, 4),
                  height: super.screenHeightPercentage(context, 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    // color: Colors.amber,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: white,
                    size: 14,
                  ),
                ),
              ) : const SizedBox.shrink()
              // IconButton(onPressed: (){}, icon: Icon(Icons.close , size: 14,))
            ],
          ),
        ),
      ],
    );
  }
}
