import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/components/message_text_field.dart';
import 'package:instagram_clone/components/user_avatar.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/CommentEntity.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/entity/PostEntity.dart';
import 'package:instagram_clone/src/Authantication/data/model/HiveUserModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/src/HomeScreen/presentation/bloc/HomeBloc.dart';
import 'package:instagram_clone/src/HomeScreen/presentation/bloc/HomeEvent.dart';
import 'package:instagram_clone/src/HomeScreen/presentation/bloc/HomeState.dart';
import 'package:instagram_clone/src/HomeScreen/presentation/widgets/replay_comment.dart';
import 'package:instagram_clone/utils/resources/Image_resources.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';
import '../../../AddPostScreen/data/model/CommentModel.dart';
import '../../../AddPostScreen/data/model/ReplyedToModel.dart';

class CommentUserPostBottomSheet extends StatefulWidget{
  PostEntity postData;

  CommentUserPostBottomSheet({
    Key? key,
    required this.postData,
  }) : super(key: key);

  @override
  State<CommentUserPostBottomSheet> createState() => _CommentUserPostBottomSheetState();
}

class _CommentUserPostBottomSheetState extends State<CommentUserPostBottomSheet>  with ScreenUtils  {
  Box<HiveUserModel> userDataBase = Hive.box<HiveUserModel>('UserDataBase');

  TextEditingController messageController = TextEditingController();
  final focusNode = FocusNode();
  CommentsModel commentModel = CommentsModel();
  ReplyedToModel byDefaultCommentReplyedTo = ReplyedToModel();
  UserModel userData = UserModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData=  HiveUserModel.toEntity(userDataBase.get("User"));
    context.read<HomeBloc>().getAllPostCommmentsStreamEvent( context,widget.postData.postId.toString());
  }




  @override
  Widget build(BuildContext context) {
  

    commentModel = commentModel.copyWith(
        uuid: userData.uuid,
        uniqueName: userData.uniqueName,
        profileImage: userData.profileImage);

    byDefaultCommentReplyedTo = byDefaultCommentReplyedTo.copyWith(
        uuid: widget.postData.uuid,
        uniqueName: widget.postData.uniqueName,
        profileImage: widget.postData.profileImage,
        commentId: null);

    return Container(
      decoration: BoxDecoration(color: primaryShade50,
      borderRadius: const BorderRadius.all(Radius.circular(30))),
      width: super.screenWidthPercentage(context, 100),
      height: super.screenHeightPercentage(context, 90),
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>previous.replyedTo != current.replyedTo,
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  /// app bar section'
                  BackButtonNavbar(
                    onPress: () {
                      Navigator.pop(context);
                    },
                    icon: Icons.close,
                    center: Text(
                      "Comments",
                      style: CoustomTextStyle.paragraph2,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                super.screenWidthPercentage(context, 6)),
                        child: StreamBuilder(
                          stream: context.read<HomeBloc>().state.postCommentListStream.stream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: primaryShade500,
                                ),
                              );
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              if (snapshot.data?.length == 0) {
                                return Container(
                                  height: 500,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "No Comment Yet",
                                    style: CoustomTextStyle.paragraph4,
                                  ),
                                );
                              }

                              return CommentTreeWidget<CommentsEntity,
                                  CommentsEntity>(
                                CommentsModel(
                                  uuid: widget.postData.uuid,
                                  uniqueName: widget.postData.uniqueName ?? "",
                                  profileImage: widget.postData.profileImage ??
                                      ImageResources.networkUserOne,
                                  commentMessage: widget.postData.postDiscription ??
                                      "No Discription",
                                ),
                                snapshot.data!,
                                treeThemeData: TreeThemeData(
                                    lineColor: primaryShade500, lineWidth: 2),
                                avatarRoot: (context, data) => PreferredSize(
                                  preferredSize: const Size.fromRadius(18),
                                  child: UserAvatar(
                                    imageSize: super
                                        .screenWidthPercentage(context, 10),
                                    url: data.profileImage.toString(),
                                    onPress: () {},
                                    radious: 100,
                                  ),
                                ),
                                avatarChild: (context, comment) =>
                                    PreferredSize(
                                  preferredSize: const Size.fromRadius(18),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: UserAvatar(
                                      imageSize: super
                                          .screenWidthPercentage(context, 8),
                                      url: comment.profileImage.toString(),
                                      onPress: () {},
                                      radious: 100,
                                    ),
                                  ),
                                ),
                                contentChild: (context, comment) {
                                  return CommentCard(
                                    context: context,
                                    delete: (CommentsModel commentData) {
                                      showDeletDialogBox(context, commentData, widget.postData);
                                    },
                                    replay: (CommentsModel commentData) {
                                      focusNode.requestFocus();
                                      final replay = ReplyedToModel(
                                        uuid: commentData.uuid,
                                        commentId: commentData.commentId,
                                        uniqueName:  commentData.uniqueName ?? "",
                                        profileImage:commentData.profileImage ?? ImageResources.networkUserOne,
                                      );

                                      context.read<HomeBloc>().add(SetReplay(replay: replay));
                                    },
                                    commentData: comment,
                                  );
                                },
                                contentRoot: (context, comment) {
                                  return CommentCard(
                                    context: context,
                                    delete: (CommentsModel commentData) {},
                                    replay: (CommentsModel commentData) {
                                      focusNode.requestFocus();
                                      final replay = ReplyedToModel(
                                        uuid: commentData.uuid,
                                        commentId: commentData.commentId,
                                        uniqueName:commentData.uniqueName ?? "",
                                        profileImage:commentData.profileImage ?? ImageResources.networkUserOne,
                                      );

                                      context
                                          .read<HomeBloc>()
                                          .add(SetReplay(replay: replay));
                                    },
                                    commentData: comment,
                                  );
                                },
                              );
                            }
                            return Container(
                              height: 500,
                              alignment: Alignment.center,
                              child: Text(
                                  snapshot.error.toString() ??
                                      "Some Error Occured",
                                  style: CoustomTextStyle.paragraph4),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // bottom: MediaQuery.of(context).viewInsets.bottom,
              Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                child: MessageTextField(
                  controller: messageController,
                  focusNode: focusNode,
                  getTextFieldValue: (value) {},
                  onSend: () {
                    if (messageController.text.toString() != null || messageController.text.toString().isNotEmpty) {
                      if (state.replyedTo != null) {
                        commentModel = commentModel.copyWith(
                            replyedTo:ReplyedToModel.fromEntity(state.replyedTo!),
                            commentMessage: messageController.text.toString());
                      } else {
                        commentModel = commentModel.copyWith(
                            replyedTo: byDefaultCommentReplyedTo,
                            commentMessage: messageController.text.toString());
                      }
                
                      context.read<HomeBloc>().add(PostCommentReplyEvent(
                          comment: commentModel,
                          postId: widget.postData.postId!,
                          context: context));
                          state.replyedTo = null;
                      messageController.clear();
                    }
                  }, onAttachFile: (){}, showAttachFile: false,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}



Future<dynamic> showDeletDialogBox(BuildContext context, CommentsModel commentData , PostEntity postData) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: primaryShade50,
        title: Text(
          'Delete Confirmation',
          style: CoustomTextStyle.paragraph1,
        ),
        content: Text('Are you sure you want to delete comment . After deleting we cannot cancell the deletion ?', style: CoustomTextStyle.paragraph4,),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
              child:  Text('Delet', style: CoustomTextStyle.paragraph3.copyWith(color: primaryShade500),),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child:  Text('Cancel', style: CoustomTextStyle.paragraph3,),
          ),
        ],
      );
    },
  ).then((confirmed) {
    if (confirmed == true) {
      context.read<HomeBloc>().add(DeletCommentReplyEvent(commentId:commentData.commentId! , postId: postData.postId!, context: context));
    } else {
      
    }
  });
}
