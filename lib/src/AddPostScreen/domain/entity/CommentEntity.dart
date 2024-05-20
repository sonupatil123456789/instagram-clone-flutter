import 'package:equatable/equatable.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/ReplyedToEntity.dart';

class CommentsEntity extends Equatable {
  String? uuid;
  String? commentId;
  String? uniqueName;
  String? profileImage;
  ReplyedTo? replyedTo;
  String? commentMessage;
  String? createdAt;
  CommentsEntity({
  this.uuid, this.uniqueName, this.commentId, this.commentMessage,
   this.replyedTo,
   this.profileImage,this.createdAt});
  
  @override
  // TODO: implement props
  List<Object?> get props => [uuid, uniqueName,commentId,replyedTo , commentMessage,profileImage, createdAt];

}

