
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class CoustomSearchBar extends StatelessWidget {
  double height;
  double width;
  late TextEditingController? controller;
  int? maxLength;
  Function getTextFieldValue;
  Function validateTextField;
  bool touchDetecter;
  Function onPress;

  CoustomSearchBar({
    super.key,
    required this.onPress,
    required this.touchDetecter,
    required this.height,
    required this.width,
    this.controller,
    required this.validateTextField,
    required this.getTextFieldValue,
  });



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: AbsorbPointer(
        absorbing: touchDetecter,
        child: Container(
            width: width,
            alignment: Alignment.center,
            // decoration: blackBoxWhiteBorderDecoration,
            child: TextFormField(
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                onFieldSubmitted: (String value) {
                },
                style: CoustomTextStyle.paragraph3,
                autocorrect: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.center,
                maxLength: maxLength,
                cursorColor: primaryShade500,
                validator: (value) {
                  return validateTextField(value);
                },
                controller: controller,
                onChanged: (value) {
                  getTextFieldValue(value);
                },
                decoration:  InputDecoration(
                    hintText: "Search here",
                    counterText: "",
                    prefixIcon: const SizedBox(
                      width: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                    hintStyle: CoustomTextStyle.paragraph3.copyWith(color: const Color.fromARGB(255, 101, 101, 101)),
                    // hintStyle:  TextStyle(
                    //     color: Color(0xFFD1D1D1),
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w400),
                    contentPadding: 
                    const EdgeInsets.symmetric(horizontal: 10.0),
                    border: InputBorder.none
                    ))),
      ),
    );
  }
}
