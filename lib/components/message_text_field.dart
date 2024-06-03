import 'package:flutter/material.dart';

import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class MessageTextField extends StatelessWidget {
  TextEditingController? controller;
  FocusNode? focusNode;
  Function getTextFieldValue;
  Function onSend;
  Function onAttachFile;
  bool showAttachFile;

  MessageTextField(
      {super.key, this.controller,
       required this.getTextFieldValue,
       required this.onSend,
       required this.onAttachFile,
       required this.showAttachFile,
        this.focusNode,
       });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      alignment: Alignment.center,
      color: primaryShade50,
      // decoration: BoxDecoration(
      //     color: primaryShade100, borderRadius: BorderRadius.circular(6)),
      child: TextFormField(
          onFieldSubmitted: (String value) {},
          style: CoustomTextStyle.paragraph3,
          autocorrect: true,
          focusNode: focusNode,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlign: TextAlign.start,
          keyboardType: TextInputType.text,
          textAlignVertical: TextAlignVertical.center,
          cursorColor: primaryShade500,
          controller: controller,
          onChanged: (value) {
            getTextFieldValue(value);
          },
          decoration: InputDecoration(
              hintText: "Type Something Hear",
              hintStyle: CoustomTextStyle.paragraph3.copyWith(color: grey2),
              labelStyle:
                  CoustomTextStyle.paragraph3.copyWith(color: primaryShade500),
              suffixIcon: SizedBox(
                width: MediaQuery.of(context).size.width *0.28,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Visibility(
                      visible: showAttachFile,
                      child: GestureDetector(
                        onTap: () {
                          onAttachFile();
                        },
                        child: const Icon(
                          Icons.attach_file,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 1,),
                    GestureDetector(
                      onTap: () {
                        onSend();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: primaryShade500,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: const Icon(
                          Icons.send,
                          color: white,
                          size: 18,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  borderSide: BorderSide(width: 0, color: primaryShade50)),
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  borderSide: BorderSide(width: 0, color: primaryShade50)),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide(width: 0, color: primaryShade50),
              ))),
    );
  }
}
