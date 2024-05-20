
import 'LikeEntity.dart';
import 'TagPeopleEntity.dart';

class PostEntity {
  String? uuid;
  String? postId;
  String? uniqueName;
  String? postDiscription;
  String? location;
  String? postImage;
  String? postImageFileType;
  List<String>? tags;
  List<TagPeopleEntity>? tagPeople;
  String? profileImage;
  List<LikesEntity>? likes;
  String? createdAt;

  PostEntity(
      {this.uuid,
      this.postDiscription,
      this.postId,
      this.uniqueName,
      this.location,
      this.tags,
      this.tagPeople,
      this.postImage,
      this.postImageFileType,
      this.likes,
      this.profileImage,
      this.createdAt});
}






