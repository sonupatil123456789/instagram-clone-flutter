// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/StatusEntity.dart';

class UserStatusEntity extends Equatable {
  String? uuid;
  String? uniqueName;
  String? profileImage;
  List<StatusEntity>? statusList ;

  UserStatusEntity({this.uuid, this.uniqueName, this.profileImage , this.statusList});

  @override
  List<Object?> get props {
    return [
      uuid,
      uniqueName,
      profileImage,
      statusList
    ];
  }
}
