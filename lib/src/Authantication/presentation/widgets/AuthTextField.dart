import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class AuthTextField extends StatefulWidget {
  double width;
  double? height;
  List? coustomInputFormatters;
  late TextEditingController? controller;
  Function getTextFieldValue;
  Function validateTextField;
  bool touchDetecter;
  Function onPress;
  dynamic startIcon;
  dynamic endIcon;
  String lable;
  bool? isPassword;
  TextInputType? keyboardType;

  AuthTextField({
    super.key,
    required this.onPress,
    required this.touchDetecter,
    this.height,
    this.coustomInputFormatters,
    this.keyboardType = TextInputType.text,
    required this.width,
    this.controller,
    this.startIcon,
    this.endIcon,
    this.isPassword = false,
    required this.validateTextField,
    required this.getTextFieldValue,
    required this.lable,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField>with ScreenUtils {
  int? maxLength;

  bool hidePassword= true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.onPress();
        },
        child: AbsorbPointer(
          absorbing: widget.touchDetecter,
          child: Container(
            width: widget.width,
            height: widget.height ?? super.screenHeightPercentage(context, 9),
            alignment: Alignment.center,
            // color: Colors.amberAccent,
            // decoration: BoxDecoration(
            //     color: primaryShade100, borderRadius: BorderRadius.circular(6)),
            child: TextFormField(
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                onFieldSubmitted: (String value) {},
                style: CoustomTextStyle.paragraph3,
                autocorrect: true,
                obscuringCharacter: "*",
                inputFormatters: const [],
                obscureText: widget.isPassword == true && hidePassword == true ? true : false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textAlign: TextAlign.start,
                keyboardType: widget.keyboardType ?? TextInputType.text,
                textAlignVertical: TextAlignVertical.center,
                maxLength: maxLength,
                cursorColor: primaryShade500,
                validator: (value) {
                  return widget.validateTextField(value);
                },
                controller: widget.controller,
                onChanged: (value) {
                  widget.getTextFieldValue(value);
                },
                decoration: InputDecoration(
                    hintText: widget.lable ?? "",
                    labelText: widget.lable ?? "",
                    // filled: true,
                    // fillColor: primaryShade100,
                    hintStyle:
                        CoustomTextStyle.paragraph3.copyWith(color: grey2),
                    labelStyle: CoustomTextStyle.paragraph3
                        .copyWith(color: primaryShade500),
                    counterText: "",
                    prefixIcon: widget.startIcon != null
                        ? SizedBox(
                            width: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  widget.startIcon,
                                  size: 20,
                                )
                              ],
                            ),
                          )
                        : null,
                    suffixIcon: widget.endIcon != null
                        ? GestureDetector(
                          onTap: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          child: Icon(
                              widget.endIcon,
                              size: 20,
                            ),
                        )
                        : null,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        borderSide:
                            BorderSide(width: 1, color: primaryShade200)),
                    errorStyle:
                        CoustomTextStyle.paragraph4.copyWith(color: errorColor),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(width: 1, color: errorColor)),
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        borderSide:
                            BorderSide(width: 1, color: primaryShade500)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      borderSide: BorderSide(width: 2, color: primaryShade500),
                    ))),
          ),
        ));
  }
}
