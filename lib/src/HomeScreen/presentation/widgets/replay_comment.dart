import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/CommentEntity.dart';
import 'package:instagram_clone/src/Authantication/data/model/HiveUserModel.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class CommentCard extends StatelessWidget {
  BuildContext context;
  CommentsEntity commentData;
  Function delete;
  Function replay;

  CommentCard(
      {super.key,
      required this.context,
      required this.commentData,
      required this.delete,
      required this.replay});

  Box<HiveUserModel> userDataBase = Hive.box<HiveUserModel>('UserDataBase');

  @override
  Widget build(BuildContext context) {
   final  userData = HiveUserModel.toEntity(userDataBase.get("User"));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          decoration: BoxDecoration(
              color: primaryShade50, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: commentData.uniqueName.toString(),
                        style: CoustomTextStyle.paragraph4.copyWith( fontSize: 13, fontWeight: FontWeight.w500)),
                    TextSpan(
                      text:commentData.replyedTo?.uniqueName == null ? '': '   to   ',
                      style: CoustomTextStyle.paragraph5.copyWith(fontSize: 11,),
                    ),
                    TextSpan(text: commentData.replyedTo?.uniqueName , style: CoustomTextStyle.paragraph5.copyWith(fontSize: 11,color: primaryShade500)),
                  ],
                ),
              ),
              // Text(commentData.uniqueName.toString(), style: CoustomTextStyle.paragraph4.copyWith(fontSize: 13, fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 4,
              ),
              Text(commentData.commentMessage.toString(),
                  style: CoustomTextStyle.paragraph5.copyWith(
                    fontSize: 11,
                  )),
            ],
          ),
        ),
        DefaultTextStyle(
          style: CoustomTextStyle.paragraph4
              .copyWith(color: grey4, fontWeight: FontWeight.bold),
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    replay(commentData);
                  },
                  child: const Text(
                    'Reply',
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                commentData.uuid == userData.uuid ?  InkWell(
                  onTap: () {
                    delete(commentData);
                  },
                  child: const Text(
                    'Delet',
                    style: TextStyle(color: errorColor),
                  ),
                ) : const SizedBox.shrink()
              ],
            ),
          ),
        )
      ],
    );
  }
}

















// import 'package:comment_tree/widgets/comment_tree_widget.dart';
// import 'package:comment_tree/widgets/tree_theme_data.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:instagram_clone/components/user_avatar.dart';
// import 'package:instagram_clone/src/AddPostScreen/data/model/CommentModel.dart';
// import 'package:instagram_clone/src/AddPostScreen/data/model/ReplyedToModel.dart';
// import 'package:instagram_clone/src/AddPostScreen/domain/entity/CommentEntity.dart';
// import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
// import 'package:instagram_clone/src/HomeScreen/presentation/bloc/HomeBloc.dart';
// import 'package:instagram_clone/src/HomeScreen/presentation/bloc/HomeEvent.dart';
// import 'package:instagram_clone/src/HomeScreen/presentation/bloc/HomeState.dart';
// import 'package:instagram_clone/src/HomeScreen/presentation/widgets/comment_user_post_bottomSheet.dart';
// import 'package:instagram_clone/utils/resources/Image_resources.dart';
// import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
// import 'package:instagram_clone/utils/theams/color_pallet.dart';
// import 'package:instagram_clone/utils/theams/text_theams.dart';

// class ReplayComment extends StatefulWidget {
//   CommentsEntity comment;
//   Function replayComment;
//   FocusNode focusNode;
//   PostEntity postData;
//   ReplayComment({
//     super.key,
//     required this.comment,
//     required this.focusNode,
//     required this.replayComment,
//     required this.postData,
//   });

//   @override
//   State<ReplayComment> createState() => _ReplayCommentState();
// }

// class _ReplayCommentState extends State<ReplayComment> with ScreenUtils {

//   CommentsEntity commentData = CommentsModel();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeBloc, HomeState>(
//       builder: (context, state) {
//         return CommentTreeWidget<CommentsEntity, CommentsEntity>(
//           CommentsModel(
//               uuid: widget.comment.uuid,
//               commentId: widget.comment.commentId,
//               uniqueName: widget.comment.uniqueName ?? "",
//               profileImage:widget.comment.profileImage ?? ImageResources.networkUserOne,
//               commentMessage: widget.comment.commentMessage ?? "No Discription",
//               createdAt: widget.comment.createdAt),
//           state.replayCommentList ?? [],
//           treeThemeData:TreeThemeData(lineColor:primaryShade500 , lineWidth: 2),
//           // treeThemeData:TreeThemeData(lineColor: state.replayCommentList!.isEmpty || commentData.replyedTo?.commentId != widget.comment.commentId ? Colors.transparent : primaryShade500 , lineWidth: 2),
//           // treeThemeData:TreeThemeData(lineColor: state.replayCommentList!.isEmpty || commentData.replyedTo?.commentId != widget.comment.commentId ? Colors.transparent : primaryShade500 , lineWidth: 1),
//           avatarRoot: (context, data) => PreferredSize(
//               preferredSize: const Size.fromRadius(18),
//               child: UserAvatar(
//                 imageSize: super.screenWidthPercentage(context, 10),
//                 url: data.profileImage.toString(),
//                 onPress: () {},
//                 radious: 100,
//               )),
//           avatarChild: (context, comment) {
//             if (comment.replyedTo?.commentId == widget.comment.commentId) {
//               return PreferredSize(
//               preferredSize: const Size.fromRadius(18),
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 6),
//                 child: UserAvatar(
//                   imageSize: super.screenWidthPercentage(context, 8),
//                   url: comment.profileImage.toString(),
//                   onPress: () {},
//                   radious: 100,
//                 ),
//               )
//               ); 
//             } else {
//               return const PreferredSize(preferredSize:  Size.fromRadius(18),
//               child: SizedBox.shrink(),);
//             }
//           } ,
//           contentChild: (context, comment) {commentData = comment ;
//             if (comment.replyedTo?.commentId == widget.comment.commentId) {
//               return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 messageCard(comment),
//                  onReplayTextButtonReplayComment(
//                     context: context,
//                     viewMore: () {
//                       context.read<HomeBloc>().add(GetAllReplayToCommentEvent(
//                           commentId: comment.commentId!,
//                           postId: widget.postData.postId!,
//                           context: context));
//                     },
//                     replay: (CommentsModel commentData) { 
//                     widget.focusNode.requestFocus();
//                       widget.replayComment(
                          // ReplyedToModel(
                          //   uuid: comment.uuid,
                          //   commentId: comment.commentId,
                          //   uniqueName: comment.uniqueName ?? "",
                          //   profileImage: comment.profileImage ??ImageResources.networkUserOne,
                          // ),
                          // commentData.commentId);
//                     },
//                     commentData: comment)
              

//               ],
//             );
//             } else {
//               return const SizedBox.shrink();
//             }

           
            
//           },
//           contentRoot: (context, comment) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 messageCard(comment),
//                 onReplayTextButtonComment(
//                     context: context,
//                     viewMore: () {
//                       context.read<HomeBloc>().add(GetAllReplayToCommentEvent(
//                           commentId: comment.commentId!,
//                           postId: widget.postData.postId!,
//                           context: context));
//                     },
//                     replay: (CommentsModel commentData) { 
//                       widget.focusNode.requestFocus();
//                       widget.replayComment(
//                           ReplyedToModel(
//                             uuid: comment.uuid,
//                             commentId: comment.commentId,
//                             uniqueName: comment.uniqueName ?? "",
//                             profileImage: comment.profileImage ??ImageResources.networkUserOne,
//                           ),
//                           commentData.commentId);
//                     },
//                     commentData: comment)
//               ],
//             );
//           },
//         );
//       },
//     );
//   }


//   Widget onReplayTextButtonComment(
//     {required BuildContext context,
//     required CommentsEntity commentData,
//     required Function viewMore,
//     required Function replay}) {
//   return DefaultTextStyle(
//     style: CoustomTextStyle.paragraph4
//         .copyWith(color: grey4, fontWeight: FontWeight.bold),
//     child: Padding(
//       padding: const EdgeInsets.only(top: 6),
//       child: Row(
//         children: [
//           const SizedBox(
//             width: 8,
//           ),
//           InkWell(
//               onTap: () {
//                 viewMore();
//               },
//               child: const Text("View More")),
//           const SizedBox(
//             width: 24,
//           ),
//           InkWell(
//             onTap: () {
//               replay(commentData);
//             },
//             child: const Text('Reply'),
//           )
//         ],
//       ),
//     ),
//   );
// }
//   Widget onReplayTextButtonReplayComment(
//     {required BuildContext context,
//     required CommentsEntity commentData,
//     required Function viewMore,
//     required Function replay}) {
//   return DefaultTextStyle(
//     style: CoustomTextStyle.paragraph4
//         .copyWith(color: grey4, fontWeight: FontWeight.bold),
//     child: Padding(
//       padding: const EdgeInsets.only(top: 6),
//       child: Row(
//         children: [
//           const SizedBox(
//             width: 8,
//           ),
//           InkWell(
//             onTap: () {
//               replay(commentData);
//             },
//             child: const Text('Reply'),
//           )
//         ],
//       ),
//     ),
//   );
// }
// }


