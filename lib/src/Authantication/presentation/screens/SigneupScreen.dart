import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/components/coustom_button.dart';
import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthBloc.dart';
import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthEvents.dart';
import 'package:instagram_clone/src/Authantication/presentation/widgets/AuthTextField.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import '../../../../utils/screen_utils/input_field_utils.dart';
import '../../../../utils/theams/text_theams.dart';
import '../bloc/AuthState.dart';

class SigneupScreen extends StatefulWidget {
  const SigneupScreen({super.key});

  @override
  State<SigneupScreen> createState() => _SigneupScreenState();
}

class _SigneupScreenState extends State<SigneupScreen> with ScreenUtils {
  TextEditingController uniqueName = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  InputFielUtils inputs = InputFielUtils();

  @override
  void dispose() {
    uniqueName.dispose();
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
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
                  BackButtonNavbar(
                    onPress: () {
                      Navigator.pop(context);
                    },
                    center: null,
                  ),
                  SizedBox(
                    height: super.screenHeightPercentage(context, 2),
                  ),
                  SizedBox(
                      width: super.screenWidthPercentage(context, 90),
                      height: super.screenHeightPercentage(context, 5),
                      child: Text(
                        "Signe Up",
                        style: CoustomTextStyle.heading3,
                        textAlign: TextAlign.start,
                      )),
                  SizedBox(
                    height: super.screenHeightPercentage(context, 5),
                  ),
                  AuthTextField(
                    onPress: () {},
                    controller: uniqueName,
                    touchDetecter: false,
                    startIcon: Icons.badge,
                    width: super.screenWidthPercentage(context, 90),
                    validateTextField: (val) {},
                    getTextFieldValue: (val) {},
                    lable: 'Enter User Unique Name',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthTextField(
                    onPress: () {},
                    touchDetecter: false,
                    controller: name,
                    startIcon: Icons.person,
                    width: super.screenWidthPercentage(context, 90),
                    validateTextField: (valName) {
                      return inputs.validateName(valName);
                    },
                    getTextFieldValue: (val) {},
                    lable: 'Enter User Name',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthTextField(
                    onPress: () {},
                    touchDetecter: false,
                    controller: email,
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
                    touchDetecter: false,
                    controller: phone,
                    startIcon: Icons.dialpad,
                    keyboardType: TextInputType.phone,
                    width: super.screenWidthPercentage(context, 90),
                    validateTextField: (valPhone) {
                      return inputs.validatePhoneNumber(valPhone);
                    },
                    getTextFieldValue: (val) {},
                    lable: 'Enter Your PhoneNo',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthTextField(
                    onPress: () {},
                    touchDetecter: false,
                    isPassword: true,
                    controller: password,
                    startIcon: Icons.pin,
                    endIcon: Icons.visibility,
                    width: super.screenWidthPercentage(context, 90),
                    validateTextField: (valPassword) {
                      return inputs.validatePassword(valPassword);
                    },
                    getTextFieldValue: (val) {},
                    lable: 'Enter Your Password',
                  ),
                  const SizedBox(
                    height: 80,
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
                        text: 'Signe Up',
                        onTap: () {
                          if (formState.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                CreateAccountWithEmailPasswordEvent(
                                    uniqueName: uniqueName.text.trim(),
                                    context: context,
                                    userName: name.text.trim(),
                                    email: email.text.trim(),
                                    password: password.text.trim(),
                                    phoneNumber: phone.text.trim()));
                          } else {
                            print("function not runned");
                          }
                        },
                        width: super.screenWidthPercentage(context, 90),
                        borderRadious: screenWidthPercentage(context, 20),
                      );
                    },
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
