import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class ListnersUtils {
  static void showToastMessage(String message, Color colors) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: colors,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static void showFlushbarMessage(
      String message,
      Color colors,
      Color titleTextColor,
      String titleText,
      IconData icon,
      BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          title: titleText,
          titleColor: titleTextColor,
          message: message,
          flushbarPosition: FlushbarPosition.BOTTOM,
          flushbarStyle: FlushbarStyle.FLOATING,
          reverseAnimationCurve: Curves.decelerate,
          // forwardAnimationCurve: Curves.decelerate,
          backgroundColor: colors,
          isDismissible: true,
          duration: const Duration(seconds: 3),
          icon: Icon(
            icon,
            color: titleTextColor,
          ),
          titleText: Text(
            titleText,
            style: CoustomTextStyle.paragraph2,
          ),
          messageText: Text(
            message,
            style: CoustomTextStyle.paragraph4,
          ),
        )..show(context));
  }
}
