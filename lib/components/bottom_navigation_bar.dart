
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';


// ignore: must_be_immutable
class CoustomBottomNavigationBar extends StatefulWidget {
  List<BottomMenuModel> items;
  Function onChange;

  CoustomBottomNavigationBar(
      {super.key, required this.items, required this.onChange});

  @override
  State<CoustomBottomNavigationBar> createState() =>
      _CoustomBottomNavigationBarState();
}

class _CoustomBottomNavigationBarState extends State<CoustomBottomNavigationBar>
    with ScreenUtils, SingleTickerProviderStateMixin  {
  int selectedIndex = 2;


  @override
  Widget build(BuildContext context) {
    return Container(
        height: super.screenHeightPercentage(context, 8),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: primaryShade100,
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.items.map((item) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = item.id;
                  widget.onChange(selectedIndex);
                });
              },
              child: SizedBox(
                width: super.screenWidthPercentage(context, 15),
                height: super.screenWidthPercentage(context, 15),
                child: Icon(
                  item.icon,
                  size: selectedIndex == item.id ? 26:22,
                  color: selectedIndex == item.id ? primaryShade500: item.color,
                ),
              ),
            );
          }).toList(),
        ));
  }
}

enum BottomBarEnum {
  HOME,
  SEARCH,
  ADD_POST,
  REELS,
  USER,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.id,
    required this.icon,
    this.title,
    required this.type,
    required this.color,
  });
  int id;
  IconData icon;
  String? title;
  BottomBarEnum type;
  Color color;
}
