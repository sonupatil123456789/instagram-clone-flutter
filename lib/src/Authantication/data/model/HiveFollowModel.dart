
import 'package:hive/hive.dart';
import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';
part 'HiveFollowModel.g.dart';

 
@HiveType(typeId: 1)
class HiveFollowModel  {
   @HiveField(0)
    String?uuid ;
    @HiveField(1)
    String? uniqueName ;
    @HiveField(2)
    String? profileImage ;
    HiveFollowModel({this.uuid, this.uniqueName, this.profileImage});

    factory HiveFollowModel.fromEntity(FollowEntity entity){
      return HiveFollowModel(
        uuid: entity.uuid,
        uniqueName: entity.uniqueName,
        profileImage: entity.profileImage
      );
    }

    static FollowModel toEntity(HiveFollowModel hiveModel){
      return FollowModel(
         uuid: hiveModel.uuid,
        uniqueName: hiveModel.uniqueName,
        profileImage: hiveModel.profileImage
      );
    }
    

  }