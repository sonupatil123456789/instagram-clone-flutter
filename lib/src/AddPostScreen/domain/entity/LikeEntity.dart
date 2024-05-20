import 'package:equatable/equatable.dart';

class LikesEntity extends Equatable {
  String? uuid;
  String? uniqueName;
  String? profileImage;

  LikesEntity({this.uuid, this.uniqueName, this.profileImage});


  @override
  List<Object?> get props => [uuid, uniqueName, profileImage];
}