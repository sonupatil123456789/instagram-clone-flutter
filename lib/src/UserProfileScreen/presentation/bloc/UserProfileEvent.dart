import 'package:flutter/material.dart';

abstract class UserProfileEvent {}



class GetMyPostEvent extends UserProfileEvent{
  BuildContext context;
  bool isRefresh;

  GetMyPostEvent({
    required this.context,
    required this.isRefresh,
  });
}
