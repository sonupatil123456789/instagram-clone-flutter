import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebaseChatCollection.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebaseUserCollection.dart';
import 'package:instagram_clone/core/firebaseServices/storage/storageBucket.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/src/ChatListScreen/data/model/UserChatMessageModel.dart';
import 'package:instagram_clone/src/ChatListScreen/data/model/UserMessageListModel.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/screen_utils/logging_utils.dart';
import 'package:uuid/uuid.dart';
import '../../../Authantication/data/model/FollowModel.dart';
import 'remote_data_source.dart';

class ChatListRemoteDataSourceImpl implements ChatListRemoteDataSource {
  FirebaseUserCollection userCollection;
  UserModel userModel;
  StorageBucket storage;
  FirebaseChatCollection chatCollection;

  ChatListRemoteDataSourceImpl(
    this.userCollection,
    this.userModel,
    this.chatCollection,
    this.storage,
  );

  FirebaseAuth get auth => userCollection.firebaseAuthInstance;
  UserCredential? _credential;
  bool isFetched = false;

  @override
  Stream<List<UserMessageListModel>> getAllFriendsChattingStreamList(
      List<FollowModel> following) {
    List<String> friendsId = following.map((e) => e.uuid.toString()).toList();

    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> userList =
          userCollection.getAllFriendsRealTime(friendsId);

      Stream<List<UserMessageListModel>> mappedStream =userList.asyncMap((event) async {
        List<Future<UserMessageListModel>> userChatListFutures = event.docs.map((doc) async {
          final data =UserMessageListModel.fromMap(doc.data());

          final lastMessageDoc = await chatCollection.getLastMessageDocument(
              auth.currentUser!.uid, data.uuid!);

          if (lastMessageDoc.exists) {
            final getMessage = lastMessageDoc.data() as Map<String, dynamic>;
            return data.copyWith(
              messageCreatedAt: getMessage['createdAt'],
              message: getMessage['message'],
              messageId: getMessage['messageId'],
              messageType: getMessage['messageType'],
              messageViewed: getMessage['messageViewed'],
            );
          }else{
            return data;
          }
          // return data;
        }).toList();
        // Await all futures to complete and return the list of results
        List<UserMessageListModel> userChatList =await Future.wait(userChatListFutures);
        return userChatList;
      });

      // mappedStream.listen((event) {
      //   CoustomLog.coustomLogData( "getAllFriendsChattingStreamList", event.toString());
      // });
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
    final messageId = const Uuid().v4();
    UserChatMessageModel message = UserChatMessageModel();

    try {
      if (chat.messageType !=
          CustomUploadFileType.TextDocument.enumToString()) {
        final fileUrl = await storage.uploadChatFile(
            chat.message.toString(), chat.messageType, sender.uuid.toString());
        message = chat.copyWith(
            messageViewed: false,
            messageId: messageId,
            uuid: sender.uuid,
            message: fileUrl);
      } else {
        message = chat.copyWith(
            messageViewed: false, messageId: messageId, uuid: sender.uuid);
      }

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
  Future<void> viewedMessage(
      String senderId, String reciverId, String messageId) async {
    try {
      await chatCollection.updateMessageDocument(
          senderId, reciverId, messageId, {'messageViewed': true});
      await chatCollection.updateMessageDocument(
          reciverId, senderId, messageId, {'messageViewed': true});
    } catch (error, stack) {
      CoustomLog.coustomLogError("viewedMessage", error, stack);
      rethrow;
    }
  }

  @override
  Future<void> viewedLastMessage(
      String senderId, String reciverId) async {
    try {
      await chatCollection.updateLastMessageDocument(senderId, reciverId, {'messageViewed': true});
      await chatCollection.updateLastMessageDocument(reciverId, senderId,  {'messageViewed': true});
    } catch (error, stack) {
      CoustomLog.coustomLogError("viewedLastMessage", error, stack);
      rethrow;
    }
  }

  @override
  Future<bool> deletMessage(
      String senderId, String reciverId, String messageId) async {
    try {
      await chatCollection.deletMessageDocument(senderId, reciverId, messageId);
      await chatCollection.deletMessageDocument(reciverId, senderId, messageId);
      return true;
    } catch (error, stack) {
      CoustomLog.coustomLogError("deletMessage", error, stack);
      rethrow;
    }
  }
}
