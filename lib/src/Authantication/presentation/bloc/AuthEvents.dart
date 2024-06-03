import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class AuthEvents {}

class CreateAccountWithEmailPasswordEvent extends AuthEvents {
  BuildContext context;
  String uniqueName;
  String userName;
  String password;
  String email;
  String phoneNumber;

  CreateAccountWithEmailPasswordEvent(
      {required this.uniqueName,
      required this.context,
      required this.userName,
      required this.email,
      required this.password,
      required this.phoneNumber});
}

class UpdateUserInformationEvent extends AuthEvents {
  BuildContext context;
  String uniqueName;
  String userName;
  String birthdate;
  String email;
  String phoneNumber;
  String profileImage;

  UpdateUserInformationEvent(
      {required this.uniqueName,
      required this.context,
      required this.userName,
      required this.email,
      required this.birthdate,
      required this.profileImage,
      required this.phoneNumber});
}

class LogInWithEmailPasswordEvent extends AuthEvents {
  BuildContext context;
  String password;
  String email;

  LogInWithEmailPasswordEvent({
    required this.context,
    required this.email,
    required this.password,
  });
}


class ResetPasswordEvent extends AuthEvents {
  BuildContext context;
  String email;

  ResetPasswordEvent({
    required this.context,
    required this.email,
  });
}
class SigneOutEvent extends AuthEvents {
  BuildContext context;
  SigneOutEvent({
    required this.context,
  });
}


class IsOnlineEvent extends AuthEvents {
  bool isOnline;
  BuildContext context;

  IsOnlineEvent({
    required this.context,
    required this.isOnline
  });
}



class GetAllUserStreamListEvent extends AuthEvents {
  BuildContext context;
  String searchQuery;

  GetAllUserStreamListEvent({
    required this.context,
    required this.searchQuery,
  });
}

class GetUserEvent extends AuthEvents {
  BuildContext context;

  GetUserEvent({
    required this.context,
  });
}
