import 'package:flutter/material.dart';
import 'package:instagram_clone/src/Authantication/presentation/widgets/AuthTextField.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';

class CoustomDatePicker extends StatefulWidget {
  Function pickedDate;
  CoustomDatePicker({super.key, required this.pickedDate});

  @override
  State<CoustomDatePicker> createState() => _CoustomDatePickerState();
}

class _CoustomDatePickerState extends State<CoustomDatePicker> with ScreenUtils {
  DateTime selectedDate = DateTime.now();

  static TextEditingController dateController = TextEditingController();

  coustomDatepicker(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: primaryShade500),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: white, // Text color
                  backgroundColor:
                      primaryShade500 // Button background color
                  ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      await widget.pickedDate(
          "${picked.year.toString()}/${picked.month.toString()}/${picked.day.toString()}");
      setState(() {
        dateController.text =
            "${picked.year.toString()}/${picked.month.toString()}/${picked.day.toString()}";
      });

      print("Selected date -----> $selectedDate");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      onPress: () async{
        await coustomDatepicker(context);
      },
      controller: dateController,
      touchDetecter: true,
      startIcon: Icons.badge,
      width: super.screenWidthPercentage(context, 90),
      validateTextField: (val) {},
      getTextFieldValue: (val) {},
      lable: 'Selcet Date',
    );
  }
}
