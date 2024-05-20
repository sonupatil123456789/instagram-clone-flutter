import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/components/coustom_button.dart';
import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthBloc.dart';
import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthEvents.dart';
import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthState.dart';
import 'package:instagram_clone/src/Authantication/presentation/widgets/AuthTextField.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/input_field_utils.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ScreenUtils {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  InputFielUtils inputs = InputFielUtils();

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

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
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    ImageResources.instagramLogo,
                    width: super.screenWidthPercentage(context, 25),
                    height: super.screenWidthPercentage(context, 25),
                  ),
                  SizedBox(
                    height: super.screenHeightPercentage(context, 5),
                  ),
                  Container(
                      width: super.screenWidthPercentage(context, 90),
                      height: super.screenHeightPercentage(context, 5),
                      child: Text(
                        "Log In",
                        style: CoustomTextStyle.heading3,
                        textAlign: TextAlign.start,
                      )),
                  SizedBox(
                    height: super.screenHeightPercentage(context, 5),
                  ),
                  AuthTextField(
                    onPress: () {},
                    controller: emailController,
                    touchDetecter: false,
                    startIcon: Icons.email,
                    width: super.screenWidthPercentage(context, 90),
                    validateTextField: (valEmail) {
                      return inputs.validateEmail(valEmail);
                    },
                    getTextFieldValue: (val) {},
                    lable: 'Enter Your EmailId',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthTextField(
                    onPress: () {},
                    controller: passwordController,
                    touchDetecter: false,
                    isPassword: true,
                    startIcon: Icons.pin,
                    endIcon: Icons.visibility,
                    width: super.screenWidthPercentage(context, 90),
                    validateTextField: (valPassword) {
                      return inputs.validatePassword(valPassword);
                    },
                    getTextFieldValue: (val) {},
                    lable: 'Enter Your Password',
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RoutesName.resetPasswordScreen);
                    },
                    child: Container(
                      width: super.screenWidthPercentage(context, 90),
                      padding: const EdgeInsets.only(top: 5),
                      height: 80,
                      alignment: Alignment.topRight,
                      child: Text(
                        "Forgot Password",
                        style: CoustomTextStyle.paragraph3,
                      ),
                    ),
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
                        text: 'Log In',
                        onTap: () async {
                          if (formState.currentState!.validate()) {
                            context
                                .read<AuthBloc>()
                                .add(LogInWithEmailPasswordEvent(
                                  context: context,
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ));
                          } else {
                            print("function not runned");
                          }
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
                  CoustomButton(
                    height: super.screenHeightPercentage(context, 6),
                    backgroundColor: primaryShade50,
                    text: 'Signe Up',
                    textColor: blac2,
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.signeUpScreen);
                    },
                    borderColor: Border.all(width: 1, color: primaryShade500),
                    width: super.screenWidthPercentage(context, 90),
                    borderRadious: screenWidthPercentage(context, 20),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
