import 'package:equatable/equatable.dart';

class TagPeopleEntity extends Equatable {
  String? uuid;
  String? uniqueName;
  String? profileImage;
  TagPeopleEntity({this.uuid, this.uniqueName, this.profileImage});

  @override
  List<Object?> get props => [uuid, uniqueName, profileImage];
}