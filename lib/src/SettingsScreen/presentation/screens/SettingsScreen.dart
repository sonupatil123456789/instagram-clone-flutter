import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthBloc.dart';
import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthEvents.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class SettingsScreen extends StatelessWidget with ScreenUtils {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryShade50,
      body: SizedBox(
        width: super.screenWidthPercentage(context, 100),
        height: super.screenHeightPercentage(context, 100),
        child: SafeArea(
          child: Column(
            children: [
              BackButtonNavbar(
                onPress: () {
                  Navigator.pop(context);
                },
                center: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Settings",
                    style: CoustomTextStyle.paragraph1,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  children: [
                    heading('Features', context),
                    settingsInfo(
                        context: context,
                        title: 'Bookmarks',
                        subtitle: 'See all your saved bookmarked post here',
                        icons: Icons.bookmark,
                        ontap: () {
                            Navigator.pushNamed(context, RoutesName.bookmarkScreen);
                        }),
                    settingsInfo(
                        context: context,
                        title: 'Notification',
                        subtitle:
                            'You will recive all the important notifacation / events hear',
                        icons: Icons.notifications,
                        ontap: () {}),
                    heading('Account', context),
                    settingsInfo(
                        context: context,
                        title: 'Update User',
                        subtitle: 'Update your user information ',
                        icons: Icons.person,
                        ontap: () {
                            Navigator.pushNamed(context, RoutesName.updateUserScreen);
                        }),
                    settingsInfo(
                        context: context,
                        title: 'Reset Password',
                        subtitle: 'Reset your account password ',
                        icons: Icons.restart_alt,
                        ontap: () {
                          Navigator.pushNamed(context, RoutesName.resetPasswordScreen);
                        }),
                    settingsInfo(
                        context: context,
                        title: 'Log Out',
                        subtitle: 'By clicking logout you will be signe out from this account from this device ',
                        icons: Icons.logout,
                        ontap: ()async {
                        context.read<AuthBloc>().add(SigneOutEvent(context: context));
                        }),
                  ],
                ),
              ),
              Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  "Version  1.2.0",
                  style: CoustomTextStyle.paragraph4,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget heading(String heading, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: super.screenWidthPercentage(context, 90),
      padding: EdgeInsets.symmetric(
          horizontal: super.screenWidthPercentage(context, 8)),
      child: Text(
        heading,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style:
            CoustomTextStyle.paragraph2.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget settingsInfo(
      {required String title,
      required String subtitle,
      required IconData icons,
      required BuildContext context,
      required Function ontap}) {
    return GestureDetector(
      onTap:(){
        ontap();
      } ,
      child: Container(
        width: super.screenWidthPercentage(context, 90),
        height: super.screenHeightPercentage(context, 09),
        padding: EdgeInsets.symmetric(
            horizontal: super.screenWidthPercentage(context, 4)),
        child: Row(
          children: [
            SizedBox(
              width: screenWidthPercentage(context, 4),
            ),
            Container(
              width: super.screenWidthPercentage(context, 12),
              height: super.screenWidthPercentage(context, 12),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: primaryShade100,
              ),
              child: Icon(
                icons,
                size: 14,
                color: primaryShade500,
              ),
            ),
            SizedBox(
              width: screenWidthPercentage(context, 4),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CoustomTextStyle.paragraph3
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CoustomTextStyle.paragraph4
                        .copyWith(fontWeight: FontWeight.w300, color: grey4),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screenWidthPercentage(context, 5),
            ),
          ],
        ),
      ),
    );
  }
}
