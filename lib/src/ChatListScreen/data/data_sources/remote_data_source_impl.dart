import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebaseChatCollection.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebaseUserCollection.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/src/ChatListScreen/data/model/UserChatMessageModel.dart';
import 'package:instagram_clone/utils/screen_utils/logging_utils.dart';
import 'package:uuid/uuid.dart';
import '../../../Authantication/data/model/FollowModel.dart';
import 'remote_data_source.dart';

class ChatListRemoteDataSourceImpl implements ChatListRemoteDataSource {
  FirebaseUserCollection userCollection;
  UserModel userModel;
  FirebaseChatCollection chatCollection;

  ChatListRemoteDataSourceImpl(
    this.userCollection,
    this.userModel,
    this.chatCollection,
  );

  FirebaseAuth get auth => userCollection.firebaseAuthInstance;
  UserCredential? _credential;
  bool isFetched = false;

  @override
  Stream<List<UserModel>> getAllFriendsChattingStreamList(
      List<FollowModel> following) {
    List<String> friendsId = following.map((e) => e.uuid.toString()).toList();

    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> userList =
          userCollection.getAllFriendsRealTime(friendsId);
      Stream<List<UserModel>> mappedStream = userList.map((event) =>
          event.docs.map((e) => UserModel.fromMap(e.data())).toList());
      CoustomLog.coustomLogData(
          "getAllFriendsChattingStreamList", mappedStream);
      return mappedStream;
    } catch (error, stack) {
      CoustomLog.coustomLogError(
          "getAllFriendsChattingStreamList", error, stack);
      rethrow;
    }
  }

  @override
  Future<bool> sendMessage(
      UserModel sender, UserModel reciver, UserChatMessageModel chat) async {
    final messageId = Uuid().v4();

    try {
      final message = chat.copyWith(
          messageViewed: false, messageId: messageId, uuid: sender.uuid);

      CoustomLog.coustomLogData("message", message);

      await chatCollection.setMessageDocument(
          sender.uuid!, reciver.uuid!, messageId, message.toMap());
      await chatCollection.setMessageDocument(
          reciver.uuid!, sender.uuid!, messageId, message.toMap());

      Map<String, dynamic> lastMessage = message.toMap();
      lastMessage.remove('replyedToId');

      await chatCollection.setLastMessageDocument(
          sender.uuid!, reciver.uuid!, lastMessage);
      await chatCollection.setLastMessageDocument(
          reciver.uuid!, sender.uuid!, lastMessage);

      return true;
    } catch (error, stack) {
      CoustomLog.coustomLogError("sendMessage", error, stack);
      rethrow;
    }
  }

  @override
  Stream<List<UserChatMessageModel>> getUserConversationStreamList(
      String senderId, String reciverId) {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> userList =
          chatCollection.getUserConversationListStream(senderId, reciverId);
      Stream<List<UserChatMessageModel>> mappedStream = userList.map((event) =>
          event.docs
              .map((e) => UserChatMessageModel.fromMap(e.data()))
              .toList());
      CoustomLog.coustomLogData("getUserConversationStreamList", mappedStream);
      return mappedStream;
    } catch (error, stack) {
      CoustomLog.coustomLogError("getUserConversationStreamList", error, stack);
      rethrow;
    }
  }

  @override
  Future<void>  viewedMessage(String senderId, String reciverId, String messageId) async {
    await chatCollection.updateMessageDocument(senderId, reciverId, messageId, {'messageViewed': true});
    await chatCollection.updateMessageDocument(reciverId, senderId, messageId, {'messageViewed': true}); 
  }
}
