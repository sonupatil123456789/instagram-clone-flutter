import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/components/coustom_button.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

import '../../../../utils/resources/enums.dart';
import '../bloc/AuthBloc.dart';
import '../bloc/AuthEvents.dart';
import '../bloc/AuthState.dart';
import '../widgets/AuthTextField.dart';

class ResetPasswordScreen extends StatelessWidget with ScreenUtils {
  ResetPasswordScreen({super.key});

  TextEditingController emailController = TextEditingController();
  final formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryShade50,
      body: SizedBox(
        width: super.screenWidthPercentage(context, 100),
        height: super.screenHeightPercentage(context, 100),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BackButtonNavbar(
                    onPress: () {
                      Navigator.pop(context);
                    },
                    center: null
                  ),
                  SizedBox(
                    height: super.screenHeightPercentage(context, 2),
                  ),
                  Container(
                      width: super.screenWidthPercentage(context, 90),
                      height: super.screenHeightPercentage(context, 5),
                      child: Text(
                        "Reset Password",
                        style: CoustomTextStyle.heading3,
                        textAlign: TextAlign.start,
                      )),
                  SizedBox(
                    height: super.screenHeightPercentage(context, 5),
                  ),
                  Container(
                    width: super.screenWidthPercentage(context, 100),
                    // height: super.screenHeightPercentage(context, 6),
                    padding: EdgeInsets.symmetric(
                        horizontal: super.screenWidthPercentage(context, 6)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.error,
                          size: 18,
                          color: grey2,
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Text(
                            "Please enter the appropriate email address that you have registered during signing up processs , this will help you to recover your password by sending option to change yours account password ",
                            maxLines: 5,
                            softWrap: true,
                            style: CoustomTextStyle.paragraph4
                                .copyWith(color: grey2),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: super.screenHeightPercentage(context, 5),
                  ),
                  AuthTextField(
                    onPress: () {},
                    controller: emailController,
                    touchDetecter: false,
                    startIcon: Icons.email,
                    width: super.screenWidthPercentage(context, 90),
                    validateTextField: (val) {},
                    getTextFieldValue: (val) {},
                    lable: 'Enter Your EmailId',
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state.currentState == CurrentAppState.LOADING) {
                        return CircularProgressIndicator(
                          color: primaryShade500,
                        );
                      }

                      return CoustomButton(
                        height: super.screenHeightPercentage(context, 6),
                        backgroundColor: primaryShade500,
                        text: 'Send Email',
                        onTap: () async {
                          context.read<AuthBloc>().add(ResetPasswordEvent(
                                context: context,
                                email: emailController.text.trim(),
                              ));

                          // Navigator.pushNamedAndRemoveUntil(context, RoutesName.mainSectionScreen, (route) => false);
                        },
                        width: super.screenWidthPercentage(context, 90),
                        borderRadious: screenWidthPercentage(context, 20),
                      );
                    },
                  ),
                  SizedBox(
                    height: super.screenHeightPercentage(context, 5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
