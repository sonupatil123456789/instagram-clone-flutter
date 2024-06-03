
import 'package:instagram_clone/src/Authantication/data/model/FollowModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/FollowEntity.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/src/ChatListScreen/data/data_sources/remote_data_source.dart';
import 'package:instagram_clone/src/ChatListScreen/data/model/UserChatMessageModel.dart';
import 'package:instagram_clone/src/ChatListScreen/data/model/UserMessageListModel.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/entity/UserChatMessageEntity.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/repository/repository.dart';


class ChatListRepositoryImpl implements ChatListRepository {
  ChatListRemoteDataSource remoteDataSource;


  ChatListRepositoryImpl(this.remoteDataSource, );

  @override
  Stream<List<UserMessageListModel>> getAllFriendsChattingStreamList(List<FollowEntity> following) {
   return remoteDataSource.getAllFriendsChattingStreamList(following.map((e) => FollowModel.fromEntity(e)).toList());
  }

  @override
  Future<bool> sendMessage(UserEntity sender, UserEntity reciver, UserChatMessageEntity chat) {
    return remoteDataSource.sendMessage(
      UserModel.fromEntity(sender),
      UserModel.fromEntity(reciver),
      UserChatMessageModel.fromEntity(chat)  
    );
  }
  
  @override
  Stream<List<UserChatMessageEntity>> getUserConversationStreamList(String senderId, String reciverId) {
    return remoteDataSource.getUserConversationStreamList(senderId, reciverId);
  }
  
  @override
  Future<void>  viewedMessage(String senderId, String reciverId, String messageId) {
    return remoteDataSource.viewedMessage(senderId, reciverId, messageId);
  }
  
  @override
  Future<void>  viewedLastMessage(String senderId, String reciverId) {
    return remoteDataSource.viewedLastMessage(senderId, reciverId);
  }
  
  @override
  Future<bool> deletMessage(String senderId, String reciverId, String messageId) {
    return remoteDataSource.deletMessage(senderId, reciverId, messageId);
  }

  
}
