import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


abstract class ReelEvent {}



class GetAllVideoPostEvent extends ReelEvent{

  BuildContext context;
  bool isRefresh;

  GetAllVideoPostEvent({
    required this.isRefresh,
    required this.context,
  });
}


