import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';

const BoxDecoration goldenBoxDecoration = BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.all(Radius.circular(20)),
    gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [yeallow1, yeallow3, yeallow1]));

const BoxDecoration blackBoxWhiteBorderDecoration = BoxDecoration(
  color: black,
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.all(Radius.circular(10)),
  border: Border(
    top: BorderSide(color: Colors.white, width: 1),
    left: BorderSide(color: Colors.white, width: 1),
  ),
);

ShapeDecoration transperentBlackBox = ShapeDecoration(
  color: Colors.black26,
  shape: RoundedRectangleBorder(
    side: const BorderSide(width: 1, color: Colors.transparent),
    borderRadius: BorderRadius.circular(50),
  ),
);
