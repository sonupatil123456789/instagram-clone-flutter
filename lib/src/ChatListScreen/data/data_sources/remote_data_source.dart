import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/src/ChatListScreen/data/model/UserChatMessageModel.dart';
import 'package:instagram_clone/src/ChatListScreen/data/model/UserMessageListModel.dart';

abstract interface class ChatListRemoteDataSource {


  Stream<List<UserMessageListModel>> getAllFriendsChattingStreamList(List<FollowModel> following);

  Stream<List<UserChatMessageModel>> getUserConversationStreamList(String senderId , String reciverId);
  
  Future<bool> sendMessage(UserModel sender ,UserModel reciver ,UserChatMessageModel chat );

  Future<void>  viewedMessage(String senderId , String reciverId, String messageId);

  Future<void>  viewedLastMessage(String senderId , String reciverId);

  Future<bool>  deletMessage(String senderId , String reciverId, String messageId);




}
