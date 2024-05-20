
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/screen_utils/listners_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';

class CoustomFirebaseException {
  // final Color errorColor = errorColor;
  // final Color white = ColorPallet.textWhiteColor;
  final dynamic errorIcon = Icons.error;

  final String noInternetTitle = "No Internet Connection";
  final String noInternet ="No Internet Connection Please Try After Some Time Or Refresh Your Internet";

  final String noAccountTitle = "Invalid Account";
  final String noAccount ="Thers Is No Account With This Number Please SigneUp First";

  final String invalidNumberTitle = "Invalid Phone Number";
  final String invalidNumber = "The Phone Number Is Not A Valid Format.";

  final String otpExpiredTitle = "Expired OTP";
  final String otpExpired = "Your OTP Has Expired Please Request New Otp";

  final String invalidOTPTitle = "Invalid OTP";
  final String invalidOTP =
      "THe Otp You Have Enter Is Invalid Please Enter The Valid OTP";

  final String userDisabledTitle = "Dissabled Account";
  final String userDisabled ="TYour Account Has Banned Please Contact Us On Help-Line Number To ReEnable Your Account ";

  final String userAlreadyExhistTitle = "User Exhist";
  final String userAlreadyExhist ="User with this email already present please try different email id ";

  final String invalidCrediantialsTitle = "Invalid CrediantialsTitle";
  final String invalidCrediantials ="No such account is exhisted with this email id or you have entered wrong crediantials ";

  final String multipalRequestSendTitle = "Too Many Request Send";
  final String multipalRequestSend ="You have tried to login too many time . Please Try to log in after 24 hrs ";

  void firebasePhoneAuthExceptionHandler(BuildContext context, errorCode) {
    switch (errorCode) {
      case 'network-request-failed':
        ListnersUtils.showFlushbarMessage(noInternet, errorColor, white,
            noInternetTitle, errorIcon, context);
        break;
      case 'invalid-phone-number':
        ListnersUtils.showFlushbarMessage(invalidNumber, errorColor, white,
            invalidNumberTitle, errorIcon, context);
        break;
      case 'invalid-account':
        ListnersUtils.showFlushbarMessage(noAccount, errorColor, white,
            noAccountTitle, errorIcon, context);
        break;
      case 'code-expired':
        ListnersUtils.showFlushbarMessage(otpExpired, errorColor, white,
            otpExpiredTitle, errorIcon, context);
        break;
      case 'invalid-verification-code':
        ListnersUtils.showFlushbarMessage(invalidOTP, errorColor, white,
            invalidOTPTitle, errorIcon, context);
        break;
      case 'user-disabled':
        ListnersUtils.showFlushbarMessage(userDisabled, errorColor, white,
            userDisabledTitle, errorIcon, context);
        break;
      case 'email-already-in-use':
        ListnersUtils.showFlushbarMessage(userAlreadyExhist, errorColor, white,
            userAlreadyExhistTitle, errorIcon, context);
        break;
      case 'invalid-credential':
        ListnersUtils.showFlushbarMessage(invalidCrediantials, errorColor, white,
            invalidCrediantialsTitle, errorIcon, context);
        break;
      case 'too-many-requests':
        ListnersUtils.showFlushbarMessage(multipalRequestSend, errorColor, white,
            multipalRequestSendTitle, errorIcon, context);
        break;

      default:
        ListnersUtils.showFlushbarMessage(
            "The Server Is Under Maintainane Please Try After Some Time",
            errorColor,
            white,
            "Internal Server Error",
            Icons.error,
            context);
    }
  }
}
