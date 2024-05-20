import 'package:equatable/equatable.dart';

class ViewedStatusEntity extends Equatable {
  String? uuid;
  String? uniqueName;
  String? profileImage;

  ViewedStatusEntity({this.uuid, this.uniqueName, this.profileImage});


  @override
  List<Object?> get props => [uuid, uniqueName, profileImage];
}