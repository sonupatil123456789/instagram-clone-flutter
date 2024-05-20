class ReplyedTo{
  String? uuid;
  String? uniqueName;
  String? profileImage;
  String? commentId;

  ReplyedTo({this.uuid, this.uniqueName, this.profileImage, this.commentId});


  @override
  List<Object?> get props => [uuid, uniqueName, profileImage, commentId];
}