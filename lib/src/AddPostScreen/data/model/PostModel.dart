
import 'package:instagram_clone/src/AddPostScreen/data/model/TagPeopleModel.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';

import 'LikeModel.dart';

class PostModel extends PostEntity {
  PostModel(
      {super.uuid,
      super.postId,
      super.postDiscription,
      super.uniqueName,
      super.postImage,
      super.postImageFileType,
      super.location,
      super.tags,
      super.tagPeople,
      super.profileImage,
      super.likes,
      super.createdAt});

  PostModel copyWith({
    String? uuid,
    String? postId,
    String? postDiscription,
    String? uniqueName,
    String? location,
    String? postImage,
    String? postImageFileType,
    List<String>? tags,
    List<TagPeopleModel>? tagPeople,
    List<LikeModel>? likes,
    String? profileImage,
    String? createdAt,
  }) {
    return PostModel(
      uuid: uuid ?? this.uuid,
      postId: postId ?? this.postId,
      postDiscription: postDiscription ?? this.postDiscription,
      uniqueName: uniqueName ?? this.uniqueName,
      location: location ?? this.location,
      postImage: postImage ?? this.postImage,
      postImageFileType: postImageFileType ?? this.postImageFileType,
      tags: tags ?? this.tags,
      likes: likes ?? this.likes,
      profileImage: profileImage ?? this.profileImage,
      tagPeople: tagPeople ?? this.tagPeople,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory PostModel.fromEntity(PostEntity entity) {
    return PostModel(
      uuid: entity.uuid,
      postId: entity.postId,
      postDiscription: entity.postDiscription,
      uniqueName: entity.uniqueName,
      location: entity.location,
      createdAt: entity.createdAt,
      profileImage: entity.profileImage,
      tagPeople: entity.tagPeople,
      tags: entity.tags,
      likes: entity.likes,
      postImage: entity.postImage,
      postImageFileType: entity.postImageFileType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'postId': postId,
      'location': location,
      'uniqueName': uniqueName,
      'profileImage': profileImage,
      'postDiscription': postDiscription,
      'postImage': postImage,
      'postImageFileType': postImageFileType,
      'likes': likes?.map((e) => LikeModel(
         uuid: e.uuid,
              uniqueName: e.uniqueName,
              profileImage: e.profileImage
      ).toMap()).toList(),
      'tagPeople': tagPeople?.map((e) => TagPeopleModel(
              uuid: e.uuid,
              uniqueName: e.uniqueName,
              profileImage: e.profileImage)
          .toMap()).toList(),
      'tags': tags?.map((e) => e).toList(),
      'createdAt': createdAt,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      postId: map['postId'] != null ? map['postId'] as String : null,
      postImage: map['postImage'] != null ? map['postImage'] as String : null,
      profileImage: map['profileImage'] != null ? map['profileImage'] as String : null,
      uniqueName: map['uniqueName'] != null ? map['uniqueName'] as String : null,
      postImageFileType: map['postImageFileType'] != null
          ? map['postImageFileType'] as String
          : null,
      postDiscription: map['postDiscription'] != null
          ? map['postDiscription'] as String
          : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      likes: map['likes'] != null ? (map['likes'] as List<dynamic>).map((data) => LikeModel.fromMap(data)).toList() : [],
      tagPeople: map['tagPeople'] != null ? (map['tagPeople'] as List<dynamic>).map((data) => TagPeopleModel.fromMap(data)).toList() : [],
      tags: map['tags'] != null ? (map['tags'] as List<dynamic>).map((data) => data as String).toList() : [],
    );
  }

  @override
  String toString() {
    return 'PostModel ('
        'uuid: $uuid, '
        'postId: $postId, '
        'uniqueName: $uniqueName, '
        'postImage: $postImage, '
        'postImageFileType: $postImageFileType, '
        'postDiscription: $postDiscription, '
        'location: $location, '
        'likes: $likes, '
        'tagPeople: $tagPeople, '
        'profileImage: $profileImage, '
        'tags: $tags, '
        'createdAt: $createdAt )';
  }
}






