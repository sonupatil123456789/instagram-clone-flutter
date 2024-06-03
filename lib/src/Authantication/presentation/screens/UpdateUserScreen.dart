import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/components/coustom_button.dart';
import 'package:instagram_clone/components/date_picker.dart';
import 'package:instagram_clone/components/user_avatar.dart';
import 'package:instagram_clone/src/Authantication/data/model/HiveUserModel.dart';
import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthBloc.dart';
import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthEvents.dart';
import 'package:instagram_clone/src/Authantication/presentation/widgets/AuthTextField.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import '../../../../utils/screen_utils/input_field_utils.dart';
import '../../../../utils/theams/text_theams.dart';
import '../bloc/AuthState.dart';

class UpdateUserScreen extends StatefulWidget {
  const UpdateUserScreen({super.key});

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> with ScreenUtils {
  TextEditingController uniqueName = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  String gender = 'Male';
  String imageFile = '';
  InputFielUtils inputs = InputFielUtils();

  Box<HiveUserModel> userDataBase = Hive.box<HiveUserModel>('UserDataBase');
  late HiveUserModel? user;

  @override
  void initState() {
    super.initState();
    user = userDataBase.get("User");
    uniqueName.text = user!.uniqueName!;
    name.text = user!.userName!;
    email.text = user!.email!;
    phone.text = user!.phoneNumber!;
    imageFile = user!.profileImage!;
  }

  @override
  void dispose() {
    uniqueName.dispose();
    name.dispose();
    email.dispose();
    phone.dispose();
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
                    center: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Update user",
                        style: CoustomTextStyle.paragraph1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: super.screenHeightPercentage(context, 5),
                  ),
                  UserAvatar(
                    imageSize: super.screenWidthPercentage(context, 25),
                    url: user!.profileImage ?? ImageResources.networkUserOne,
                    onPress: () async {
                        final imageData = await InputFielUtils.getMyFile([], FileType.image, CustomUploadFileType.Image);
                        if (imageData != null) {
                          imageFile = imageData.fileData.path;
                        } else {}
                  
                    },
                    radious: 100.0,
                  ),
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
                  CoustomDatePicker(
                    pickedDate: (date) {
                      birthDate.text = date;
                    },
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: super.screenHeightPercentage(context, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state.currentState == CurrentAppState.LOADING) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: primaryShade500,
                    ),
                  );
                }

                return CoustomButton(
                  height: super.screenHeightPercentage(context, 6),
                  backgroundColor: primaryShade500,
                  text: 'Save',
                  onTap: () {
                    if (formState.currentState!.validate()) {
                      context.read<AuthBloc>().add(UpdateUserInformationEvent(
                          uniqueName: uniqueName.text.trim(),
                          context: context,
                          userName: name.text.trim(),
                          email: email.text.trim(),
                          phoneNumber: phone.text.trim(),
                          birthdate: birthDate.text.trim(),
                          profileImage: imageFile));
                    } else {
                      print("function not runned");
                    }
                  },
                  width: super.screenWidthPercentage(context, 90),
                  borderRadious: screenWidthPercentage(context, 20),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
