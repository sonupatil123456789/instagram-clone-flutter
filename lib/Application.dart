import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebaseBookmarkCollection.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebaseChatCollection.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebaseNotificationCollection.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebasePostCollection.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebaseStatusCollection.dart';
import 'package:instagram_clone/core/firebaseServices/db/firebaseUserCollection.dart';
import 'package:instagram_clone/core/firebaseServices/storage/storageBucket.dart';
import 'package:instagram_clone/src/AddPostScreen/data/data_sources/remote_data_source_impl.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/PostModel.dart';
import 'package:instagram_clone/src/AddPostScreen/data/repository_impl/repository_impl.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/use_cases/GetAllStatusUsecase.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/use_cases/GetMyStatusUsecase.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/use_cases/IsStatusViewed.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/use_cases/UploadPostsUsecase.dart';
import 'package:instagram_clone/src/AddPostScreen/domain/use_cases/UploadStatusUsecase.dart';
import 'package:instagram_clone/src/AddPostScreen/presentation/bloc/PostBloc.dart';
import 'package:instagram_clone/src/Authantication/data/auth_repository_impl/auth_repository_impl.dart';
import 'package:instagram_clone/src/Authantication/data/data_sources/auth_local_data_source_impl.dart';
import 'package:instagram_clone/src/Authantication/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:instagram_clone/src/Authantication/data/model/HiveUserModel.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/CreatAccountUsecase.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/GetUserStreamListUsecase.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/GetUserUsecase.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/IsUserOnline.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/LogInUsecase.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/LogOutUsecase.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/ResetPasswordUsecase.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/UpdateUserUsecase.dart';
import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthBloc.dart';
import 'package:instagram_clone/src/BookmarkScreen/data/data_sources/remote_data_source_impl.dart';
import 'package:instagram_clone/src/BookmarkScreen/data/repository_impl/repository_impl.dart';
import 'package:instagram_clone/src/BookmarkScreen/domain/use_cases/AddToBookmarkUsecase.dart';
import 'package:instagram_clone/src/BookmarkScreen/domain/use_cases/DeletBookmarkUsecase.dart';
import 'package:instagram_clone/src/BookmarkScreen/domain/use_cases/GetAllUsersBookmarkUsecase.dart';
import 'package:instagram_clone/src/BookmarkScreen/presentation/bloc/BookmarkBloc.dart';
import 'package:instagram_clone/src/ChatListScreen/data/data_sources/remote_data_source_impl.dart';
import 'package:instagram_clone/src/ChatListScreen/data/repository_impl/repository_impl.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/use_cases/DeletMessageUsecase.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/use_cases/GetAllFriendsChattingUserStreamListUsecase.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/use_cases/GetUserConversationStreamListUsecase.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/use_cases/SendMessageUsecase.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/use_cases/ViewedLastMessageUsecase.dart';
import 'package:instagram_clone/src/ChatListScreen/domain/use_cases/ViewedMessageUsecase.dart';
import 'package:instagram_clone/src/ChatListScreen/presentation/bloc/ChatListBloc.dart';
import 'package:instagram_clone/src/DiscoverScreen/data/data_sources/remote_data_source_impl.dart';
import 'package:instagram_clone/src/DiscoverScreen/data/repository_impl/repository_impl.dart';
import 'package:instagram_clone/src/DiscoverScreen/domain/use_cases/followUserUsecase.dart';
import 'package:instagram_clone/src/DiscoverScreen/presentation/bloc/DiscoverBloc.dart';
import 'package:instagram_clone/src/HomeScreen/data/data_sources/remote_data_source_impl.dart';
import 'package:instagram_clone/src/HomeScreen/data/repository_impl/repository_impl.dart';
import 'package:instagram_clone/src/HomeScreen/domain/use_cases/DeletCommentReplyUsecase.dart';
import 'package:instagram_clone/src/HomeScreen/domain/use_cases/GetAllFriendsPostStreamUsecase.dart';
import 'package:instagram_clone/src/HomeScreen/domain/use_cases/GetAllFriendsPostUsecase.dart.dart';
import 'package:instagram_clone/src/HomeScreen/domain/use_cases/GetAllPostStreamUsecase.dart';
import 'package:instagram_clone/src/HomeScreen/domain/use_cases/GetAllPostUsecase.dart';
import 'package:instagram_clone/src/HomeScreen/domain/use_cases/LikePostUsecase.dart';
import 'package:instagram_clone/src/HomeScreen/domain/use_cases/PostCommentReplyUsecase.dart';
import 'package:instagram_clone/src/HomeScreen/presentation/bloc/HomeBloc.dart';
import 'package:instagram_clone/src/MainSection/presentation/MainSection.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/data/data_sources/remote_data_source_impl.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/data/repository_impl/repository_impl.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/domain/use_cases/GetOtherUserDetailsStreamUsecase.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/domain/use_cases/GetOtherUserPostsUsecase.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/domain/use_cases/GetOthersUserDetailsUsecase.dart';
import 'package:instagram_clone/src/OtherUserProfileScreen/presentation/bloc/OtherUserBloc.dart';
import 'package:instagram_clone/src/ReelsScreen/data/data_sources/remote_data_source_impl.dart';
import 'package:instagram_clone/src/ReelsScreen/data/repository_impl/repository_impl.dart';
import 'package:instagram_clone/src/ReelsScreen/domain/use_cases/GetAllVideoPostUsecase.dart';
import 'package:instagram_clone/src/ReelsScreen/presentation/bloc/ReelBloc.dart';
import 'package:instagram_clone/src/UserProfileScreen/data/data_sources/remote_data_source_impl.dart';
import 'package:instagram_clone/src/UserProfileScreen/data/repository_impl/repository_impl.dart';
import 'package:instagram_clone/src/UserProfileScreen/domain/use_cases/DeletPostUsecase.dart';
import 'package:instagram_clone/src/UserProfileScreen/domain/use_cases/GetMyPostUsecase.dart';
import 'package:instagram_clone/src/UserProfileScreen/presentation/bloc/UserProfileBloc.dart';
import 'package:instagram_clone/utils/routes/routes.dart';

import 'package:instagram_clone/utils/theams/color_pallet.dart';

import 'src/Authantication/presentation/screens/LoginScreen.dart';
import 'src/HomeScreen/domain/use_cases/GetAllPostCommentsStreamUsecase.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  UserModel? data;
  Box<HiveUserModel> userDataBase = Hive.box<HiveUserModel>('UserDataBase');

  @override
  void initState() {
    authanticateScreen();
    super.initState();
  }

  Stream<UserModel?> authanticateScreen() async* {
    data = HiveUserModel.toEntity(userDataBase.get("User"));
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    final firebaseCollection = FirebaseUserCollection();
    final userModel = UserModel();
    final firebasePostCollection = FirebasePostCollection();
    final firebaseStatusCollection = FirebaseStatusCollection();
    final firebaseChatCollection = FirebaseChatCollection();
    final firebaseBookmarkCollection = FirebaseBookmarkCollection();
    final firebaseNotificationCollection = FirebaseNotificationCollection();
    final postModel = PostModel();
    final firebaseStorage = StorageBucket();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) {
            return AuthBloc(
              createAcount: CreatAccountUsecase(
                AuthRepositoryImpl(
                  RemoteDataSourceImpl(
                      firebaseCollection,
                      userModel,
                      firebaseStatusCollection,
                      firebaseBookmarkCollection,
                      firebaseNotificationCollection,firebaseStorage),
                  LocalDataSourceImpl(userDataBase),
                ),
              ),
              logIn: LoginUsecase(
                AuthRepositoryImpl(
                  RemoteDataSourceImpl(
                      firebaseCollection,
                      userModel,
                      firebaseStatusCollection,
                      firebaseBookmarkCollection,
                      firebaseNotificationCollection,firebaseStorage),
                  LocalDataSourceImpl(userDataBase),
                ),
              ),
              resetPassword: ResetPasswordUsecase(
                AuthRepositoryImpl(
                  RemoteDataSourceImpl(
                      firebaseCollection,
                      userModel,
                      firebaseStatusCollection,
                      firebaseBookmarkCollection,
                      firebaseNotificationCollection,firebaseStorage),
                  LocalDataSourceImpl(userDataBase),
                ),
              ),
              isonline: IsOnlineUsecase(
                AuthRepositoryImpl(
                  RemoteDataSourceImpl(
                      firebaseCollection,
                      userModel,
                      firebaseStatusCollection,
                      firebaseBookmarkCollection,
                      firebaseNotificationCollection,firebaseStorage),
                  LocalDataSourceImpl(userDataBase),
                ),
              ),
              getStreamOfUserList: GetUserStreamListUsecase(
                AuthRepositoryImpl(
                  RemoteDataSourceImpl(
                      firebaseCollection,
                      userModel,
                      firebaseStatusCollection,
                      firebaseBookmarkCollection,
                      firebaseNotificationCollection,firebaseStorage),
                  LocalDataSourceImpl(userDataBase),
                ),
              ),
              getUser: GetUserUsecase(
                AuthRepositoryImpl(
                  RemoteDataSourceImpl(
                      firebaseCollection,
                      userModel,
                      firebaseStatusCollection,
                      firebaseBookmarkCollection,
                      firebaseNotificationCollection,firebaseStorage),
                  LocalDataSourceImpl(userDataBase),
                ),
              ),
              logOut: LogOutUsecase(
                AuthRepositoryImpl(
                  RemoteDataSourceImpl(
                      firebaseCollection,
                      userModel,
                      firebaseStatusCollection,
                      firebaseBookmarkCollection,
                      firebaseNotificationCollection,firebaseStorage),
                  LocalDataSourceImpl(userDataBase),
                ),
              ),
              updateUser: UpdateUserUsecase(
                AuthRepositoryImpl(
                  RemoteDataSourceImpl(
                      firebaseCollection,
                      userModel,
                      firebaseStatusCollection,
                      firebaseBookmarkCollection,
                      firebaseNotificationCollection,firebaseStorage),
                  LocalDataSourceImpl(userDataBase),
                ),
              ),
            );
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return PostBloc(
              uploadPost: UploadPostsUsecase(
                PostRepositoryImpl(
                  PostRemoteDataSourceImpl(firebasePostCollection, postModel,
                      firebaseStorage, firebaseStatusCollection, data!),
                ),
              ),
              uploadStatus: UploadStatusUsecase(
                PostRepositoryImpl(
                  PostRemoteDataSourceImpl(firebasePostCollection, postModel,
                      firebaseStorage, firebaseStatusCollection, data!),
                ),
              ),
              isStatusViewed: IsStatusViewedUsecase(
                PostRepositoryImpl(
                  PostRemoteDataSourceImpl(firebasePostCollection, postModel,
                      firebaseStorage, firebaseStatusCollection, data!),
                ),
              ),
              getAllStatus: GetAllStatusUsecase(
                PostRepositoryImpl(
                  PostRemoteDataSourceImpl(firebasePostCollection, postModel,
                      firebaseStorage, firebaseStatusCollection, data!),
                ),
              ),
              getMyStatus: GetMyStatusUsecase(
                PostRepositoryImpl(
                  PostRemoteDataSourceImpl(firebasePostCollection, postModel,
                      firebaseStorage, firebaseStatusCollection, data!),
                ),
              ),
            );
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return ChatListBloc(
              getFriendsChattingUserList:
                  GetAllFriendsChattingUserStreamListUsecase(
                ChatListRepositoryImpl(
                  ChatListRemoteDataSourceImpl(firebaseCollection, userModel,
                      firebaseChatCollection, firebaseStorage),
                ),
              ),
              sendMessage: SendMessageUsecase(
                ChatListRepositoryImpl(
                  ChatListRemoteDataSourceImpl(firebaseCollection, userModel,
                      firebaseChatCollection, firebaseStorage),
                ),
              ),
              getUserConversationStreamList:
                  GetUserConversationStreamListUsecase(
                ChatListRepositoryImpl(
                  ChatListRemoteDataSourceImpl(firebaseCollection, userModel,
                      firebaseChatCollection, firebaseStorage),
                ),
              ),
              viewedMessage: ViewedMessageUsecase(
                ChatListRepositoryImpl(
                  ChatListRemoteDataSourceImpl(firebaseCollection, userModel,
                      firebaseChatCollection, firebaseStorage),
                ),
              ),
              deletMessage: DeletMessageUsecase(
                ChatListRepositoryImpl(
                  ChatListRemoteDataSourceImpl(firebaseCollection, userModel,
                      firebaseChatCollection, firebaseStorage),
                ),
              ),
              viewedLastMessage: ViewedLastMessageUsecase(
                ChatListRepositoryImpl(
                  ChatListRemoteDataSourceImpl(firebaseCollection, userModel,
                      firebaseChatCollection, firebaseStorage),
                ),
              ),
            );
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return ReelBloc(
              getAllVideoPost: GetAllVideoPostUsecase(ReelScreenRepositoryImpl(
                  ReelScreenRemoteDataSourceImpl(
                      firebasePostCollection, postModel))),
            );
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return BookmarkBloc(
                deletBookmark: DeletBookmarkUsecase(
                    BookmarkRepositoryImpl(BookmarkRemoteDataSourceImpl(
                  postModel,
                  firebaseBookmarkCollection,
                ))),
                addBookmark: AddToBookmarkUsecase(
                    BookmarkRepositoryImpl(BookmarkRemoteDataSourceImpl(
                  postModel,
                  firebaseBookmarkCollection,
                ))),
                getAllUserBookmark: GetAllUsersBookmarkUsecase(
                    BookmarkRepositoryImpl(BookmarkRemoteDataSourceImpl(
                  postModel,
                  firebaseBookmarkCollection,
                ))));
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return OtherUserBloc(
              getOtherUserDetailsStream: GetOtherUserDetailsStreamUsecase(
                OtherUserRepositoryImpl(
                  OtherUserRemoteDataSourceImpl(firebasePostCollection,
                      postModel, firebaseCollection, userModel),
                ),
              ),
              getOtherUserDetails: GetOtherUserDetailsUsecase(
                OtherUserRepositoryImpl(
                  OtherUserRemoteDataSourceImpl(firebasePostCollection,
                      postModel, firebaseCollection, userModel),
                ),
              ),
              getOtherUserPosts: GetOtherUserPostsUsecase(
                OtherUserRepositoryImpl(
                  OtherUserRemoteDataSourceImpl(firebasePostCollection,
                      postModel, firebaseCollection, userModel),
                ),
              ),
              followUser: FollowUserUsecase(
                DiscoverRepositoryImpl(
                  DiscoverRemoteDataSourceImpl(FirebaseUserCollection(),
                      HiveUserModel.toEntity(userDataBase.get("User"))),
                ),
              ),
            );
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return UserProfileBloc(
              getMyPost: GetMyPostUsecase(
                UserProfileScreenRepositoryImpl(
                  UserProfileScreenRemoteDataSourceImpl(
                      firebasePostCollection, postModel),
                ),
              ),
              deletPost: DeletMyPostUsecase(
                UserProfileScreenRepositoryImpl(
                  UserProfileScreenRemoteDataSourceImpl(
                      firebasePostCollection, postModel),
                ),
              ),
            );
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return HomeBloc(
              getAllFriendsPost: GetAllFriendsPostUsecase(
                HomeScreenRepositoryImpl(
                  HomeScreenRemoteDataSourceImpl(
                      firebasePostCollection, postModel),
                ),
              ),
              getAllPost: GetAllPostUsecase(
                HomeScreenRepositoryImpl(
                  HomeScreenRemoteDataSourceImpl(
                      firebasePostCollection, postModel),
                ),
              ),
              likePost: LikePostUsecase(
                HomeScreenRepositoryImpl(
                  HomeScreenRemoteDataSourceImpl(
                      firebasePostCollection, postModel),
                ),
              ),
              getAllFriendsPostStream: GetAllFriendsPostStreamUsecase(
                HomeScreenRepositoryImpl(
                  HomeScreenRemoteDataSourceImpl(
                      firebasePostCollection, postModel),
                ),
              ),
              getAllPostStream: GetAllPostStreamUsecase(
                HomeScreenRepositoryImpl(
                  HomeScreenRemoteDataSourceImpl(
                      firebasePostCollection, postModel),
                ),
              ),
              getAllPostCommentsStream: GetAllPostCommentsStreamUsecase(
                HomeScreenRepositoryImpl(
                  HomeScreenRemoteDataSourceImpl(
                      firebasePostCollection, postModel),
                ),
              ),
              postCommentReply: PostCommentReplyUsecase(
                HomeScreenRepositoryImpl(
                  HomeScreenRemoteDataSourceImpl(
                      firebasePostCollection, postModel),
                ),
              ),
              deletCommentReply: DeletCommentReplyUsecase(
                HomeScreenRepositoryImpl(
                  HomeScreenRemoteDataSourceImpl(
                      firebasePostCollection, postModel),
                ),
              ),
            );
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return DiscoverBloc(
              followUser: FollowUserUsecase(
                DiscoverRepositoryImpl(
                  DiscoverRemoteDataSourceImpl(FirebaseUserCollection(),
                      HiveUserModel.toEntity(userDataBase.get("User"))),
                ),
              ),
            );
          },
        )
      ],
      child: MaterialApp(
        title: 'Instagram Clone ',
        onGenerateRoute: Routes.generateRoutes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            chipTheme: ChipThemeData(
              backgroundColor: primaryShade500,
              side: BorderSide(width: 0, color: primaryShade500),
            )),
        // home: const MainSection(),
        home: StreamBuilder(
          stream: authanticateScreen(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data?.uuid != null) {
                return const MainSection();
              } else {
                return const LoginScreen();
              }
            } else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: primaryShade500,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
