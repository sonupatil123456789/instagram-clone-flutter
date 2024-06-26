import 'package:flutter/material.dart';
import 'package:instagram_clone/components/fileTypes/Image_details.dart';
import 'package:instagram_clone/components/fileTypes/pdf_details.dart';
import 'package:instagram_clone/components/fileTypes/video_details.dart';
import 'package:instagram_clone/src/AddPostScreen/presentation/screens/AddPostDetailsScreen.dart';
import 'package:instagram_clone/src/AddPostScreen/presentation/screens/AddFilePreviewScreen.dart';
import 'package:instagram_clone/src/Authantication/presentation/screens/LoginScreen.dart';
import 'package:instagram_clone/src/Authantication/presentation/screens/ResetPasswordScreen.dart';
import 'package:instagram_clone/src/Authantication/presentation/screens/SigneupScreen.dart';
import 'package:instagram_clone/src/Authantication/presentation/screens/UpdateUserScreen.dart';
import 'package:instagram_clone/src/BookmarkScreen/presentation/screens/BookmarkScreen.dart';
import 'package:instagram_clone/src/ChatDetailsScreen/presentation/screens/ChatDetailsScreen.dart';
import 'package:instagram_clone/src/ChatListScreen/presentation/screens/ChatListScreen.dart';
import 'package:instagram_clone/src/DiscoverScreen/presentation/screens/SearchUserScreen.dart';
import 'package:instagram_clone/src/MainSection/presentation/MainSection.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/presentation/screens/OtherUserProfileScreen.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';

import '../../src/AddPostScreen/presentation/screens/AddStatusDetailsScreen.dart';

class Routes {
  static MaterialPageRoute generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      // case RoutesName.homeScreen:
      //   return MaterialPageRoute(builder: (buildContext) => const NavigationScreenScction());

      // case RoutesName.splashScreen:
      //   return MaterialPageRoute(
      //       builder: (buildContext) =>  const SplashScreen());

      case RoutesName.chatListScreen:
        return MaterialPageRoute(
            builder: (buildContext) => const ChatListScreen());

      ////
      case RoutesName.chatDetailsScreen:
        final fileData = settings.arguments! as Map;
        return MaterialPageRoute(
          builder: (buildContext) => ChatDetailsScreen(
            reciverUser: fileData['reciverUser'],
          ));

      case RoutesName.signeUpScreen:
        return MaterialPageRoute(
            builder: (buildContext) => const SigneupScreen());
      case RoutesName.updateUserScreen:
        return MaterialPageRoute(
            builder: (buildContext) => const UpdateUserScreen());
      case RoutesName.bookmarkScreen:
        return MaterialPageRoute(
            builder: (buildContext) => const BookmarkScreen());

      case RoutesName.loginUserScreen:
        return MaterialPageRoute(
            builder: (buildContext) => const LoginScreen());

      case RoutesName.resetPasswordScreen:
        return MaterialPageRoute(
            builder: (buildContext) => ResetPasswordScreen());

      case RoutesName.mainSectionScreen:
        return MaterialPageRoute(
            builder: (buildContext) => const MainSection());

      case RoutesName.searcnUserScreen:
        return MaterialPageRoute(builder: (buildContext) => const SearchUserScreen());

      case RoutesName.imageDetailScreen:
       final userData = settings.arguments! as Map;
        return MaterialPageRoute(builder: (buildContext) => ImageDetails(url: userData['postUrl'],));

      case RoutesName.videoDetailScreen:
       final userData = settings.arguments! as Map;
        return MaterialPageRoute(builder: (buildContext) => VideoDetails(url: userData['postUrl'],));

      case RoutesName.fileDetailScreen:
       final userData = settings.arguments! as Map;
        return MaterialPageRoute(builder: (buildContext) => PdfDetails(url: userData['postUrl'],));

      case RoutesName.otherUserProfileScreen:
        final userData = settings.arguments! as Map;
        return MaterialPageRoute(
            builder: (buildContext) => OtherUserProfileScreen(
                  uuid: userData['uuid'],
                ),
          );

      case RoutesName.addPostDetailsScreen:
        final fileData = settings.arguments! as Map;
        return MaterialPageRoute(
            builder: (buildContext) => AddPostDetailsScreen(
                  fileData: fileData['fileData'],
                ));

      case RoutesName.addFilePreviewScreen:
        final fileData = settings.arguments! as Map;
        return MaterialPageRoute(
            builder: (buildContext) => AddFilePreviewScreen(
                  fileData: fileData['fileData'],
                  navigateToScreen: fileData['navigateToScreen'],
                ));

      case RoutesName.addStatusDetailsScreen:
        final fileData = settings.arguments! as Map;
        return MaterialPageRoute(
            builder: (buildContext) => AddStatusDetailsScreen(
                  fileData: fileData['fileData'],
                ));

      // case RoutesName.otpScreen:
      //   final data = settings.arguments! as Map;
      //   return MaterialPageRoute(
      //       builder: (buildContext) =>  OtpVerificationScreen(phoneNumber: data['phoneNumber'],));

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(child: Text("Default")),
          );
        });
    }
  }
}
