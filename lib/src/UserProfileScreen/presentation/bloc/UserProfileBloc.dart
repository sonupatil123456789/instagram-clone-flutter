import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/UserProfileScreen/domain/use_cases/DeletPostUsecase.dart';
import 'package:instagram_clone/src/UserProfileScreen/domain/use_cases/GetMyPostUsecase.dart';
import 'package:instagram_clone/src/UserProfileScreen/presentation/bloc/UserProfileEvent.dart';
import 'package:instagram_clone/src/UserProfileScreen/presentation/bloc/UserProfileState.dart';
import 'package:instagram_clone/utils/resources/enums.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  GetMyPostUsecase getMyPost;
  DeletMyPostUsecase deletPost ;

  UserProfileBloc({
    required this.getMyPost,
    required this.deletPost,
  }) : super(UserProfileState(
            currentState: CurrentAppState.INITIAL, myPostList: const [])) {
    on<GetMyPostEvent>(_getMyPostEvent);
    on<DeletMyPostEvent>(_deletMyPostEvent);
  }

  _getMyPostEvent( GetMyPostEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(currentState: CurrentAppState.LOADING));
    try {
      final data = await getMyPost.call(event.isRefresh , event.context);
      emit(state.copyWith(currentState: CurrentAppState.SUCCESS, myPostList: data ?? []));
    } catch (e) {
      emit(state.copyWith(currentState: CurrentAppState.ERROR,
      ));
    }
  }
  _deletMyPostEvent( DeletMyPostEvent event, Emitter<UserProfileState> emit) async {
     emit(state.copyWith(currentState: CurrentAppState.LOADING,myPostList:state.myPostList ));
    try {
      final data = await deletPost.call(event.postId , event.context);
      if (data == true) {
      final deleteddata =  state.myPostList!.where((element) => element.postId == event.postId).toList();
      state.myPostList!.remove(deleteddata.first);
      emit(state.copyWith(currentState: CurrentAppState.SUCCESS,myPostList:state.myPostList ));
      } else {
         emit(state.copyWith(currentState: CurrentAppState.ERROR,myPostList:state.myPostList ));
      }
    } catch (e) {
    emit(state.copyWith(currentState: CurrentAppState.ERROR,myPostList:state.myPostList ));
    }
  }
}
