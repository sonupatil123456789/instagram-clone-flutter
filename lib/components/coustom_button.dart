import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class CoustomButton extends StatelessWidget {
  double height;
  double width;
  Border? borderColor;
  Color backgroundColor;
  String text;
  Color? textColor;
  Function onTap;
  dynamic borderRadious;

  CoustomButton({
    super.key,
    this.borderColor,
    this.textColor,
    required this.backgroundColor,
    required this.text,
    required this.onTap,
    required this.width,
    required this.height,
    required this.borderRadious,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
      width: width,
      height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.rectangle,
            borderRadius:   BorderRadius.all(Radius.circular( borderRadious ?? 10)),
            border: borderColor ?? Border.all(color: backgroundColor)),
        child: Text(
          text,
          style: CoustomTextStyle.paragraph2.copyWith(
            color: textColor?? white,
            fontSize: 15
          ),
        ),
      ),
    );
  }
}
