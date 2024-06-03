import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/src/ChatListScreen/data/model/UserMessageListModel.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/entity/UserChatMessageEntity.dart';

abstract interface class ChatListRepository {
  
  
  Stream<List<UserMessageListModel>> getAllFriendsChattingStreamList(List<FollowEntity> following);

  Stream<List<UserChatMessageEntity>> getUserConversationStreamList(String senderId , String reciverId);

  Future<bool> sendMessage(UserEntity sender ,UserEntity reciver ,UserChatMessageEntity chat );

  Future<void> viewedMessage(String senderId , String reciverId, String messageId);

  Future<void> viewedLastMessage(String senderId , String reciverId,);

  Future<bool>  deletMessage(String senderId , String reciverId, String messageId);

  

}
