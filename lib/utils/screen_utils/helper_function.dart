

import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';

String getFollowingInformation(UserEntity data ){
    if ( data?.followers != null || data!.followers!.isNotEmpty) {
        if (data!.followers!.length > 0) {
          return "Followed by ${data!.followers![0].uniqueName.toString()} + ${data!.followers!.length} more ";
        } else {
          return "No followers yet";
        }
    } else {
      return "No followers yet";
    }
  }