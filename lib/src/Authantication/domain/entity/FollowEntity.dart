  import 'package:equatable/equatable.dart';

class FollowEntity  extends Equatable{
    String?uuid ;
    String? uniqueName ;
    String? profileImage ;
    FollowEntity({this.uuid, this.uniqueName, this.profileImage});
    
      @override
      // TODO: implement props
      List<Object?> get props => [profileImage, uuid, uniqueName];
  }