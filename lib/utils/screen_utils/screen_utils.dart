import 'package:flutter/material.dart';

 mixin class ScreenUtils {
  double screenWidthPercentage(BuildContext context, int percent) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double total = percent / 100;
    return screenWidth * total;
  }

  double screenHeightPercentage(BuildContext context, int percent) {
    final double screenHeignt = MediaQuery.of(context).size.height;
    final double total = percent / 100;
    return screenHeignt * total;
  }
}
