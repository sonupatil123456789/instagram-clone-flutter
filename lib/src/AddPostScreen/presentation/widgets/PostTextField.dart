import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class PostTextField extends StatefulWidget {
  double width;
  double? height;
  late TextEditingController? controller;
  Function getTextFieldValue;
  Function validateTextField;
  bool touchDetecter;
  Function onPress;
  dynamic startIcon;
  String lable;
  bool? isPassword;
  TextInputType? keyboardType;
  int? maxLine ;

  PostTextField({
    super.key,
    required this.onPress,
    required this.touchDetecter,
    this.height,
    this.keyboardType = TextInputType.text,
    required this.width,
    this.controller,
    this.startIcon,
    this.maxLine  ,
    this.isPassword = false,
    required this.validateTextField,
    required this.getTextFieldValue,
    required this.lable,
  });

  @override
  State<PostTextField> createState() => _PostTextFieldState();
}

class _PostTextFieldState extends State<PostTextField>with ScreenUtils {
  int? maxLength;


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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textAlign: TextAlign.start,
                keyboardType: widget.keyboardType ?? TextInputType.text,
                textAlignVertical: TextAlignVertical.center,
                maxLength: maxLength,
                maxLines: widget.maxLine ,
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
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide:
                            BorderSide(width: 1, color: primaryShade200)),
                    errorStyle:
                        CoustomTextStyle.paragraph4.copyWith(color: errorColor),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(width: 1, color: errorColor)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide:
                            BorderSide(width: 1, color: primaryShade500)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      borderSide: BorderSide(width: 2, color: primaryShade500),
                    ))),
          ),
        ));
  }
}
