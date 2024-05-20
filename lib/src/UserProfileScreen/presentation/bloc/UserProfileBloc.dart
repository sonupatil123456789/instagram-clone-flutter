import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/UserProfileScreen/domain/use_cases/GetMyPostUsecase.dart';
import 'package:instagram_clone/src/UserProfileScreen/presentation/bloc/UserProfileEvent.dart';
import 'package:instagram_clone/src/UserProfileScreen/presentation/bloc/getMyPostState.dart';
import 'package:instagram_clone/utils/resources/enums.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  GetMyPostUsecase getMyPost;

  UserProfileBloc({
    required this.getMyPost,
  }) : super(UserProfileState(
            currentState: CurrentAppState.INITIAL, myPostList: [])) {
    on<GetMyPostEvent>(_getAllFriendsPostEvent);
  }

  _getAllFriendsPostEvent( GetMyPostEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(currentState: CurrentAppState.LOADING));
    try {
      final data = await getMyPost.call(event.isRefresh , event.context);
      emit(state.copyWith(currentState: CurrentAppState.SUCCESS, myPostList: data ?? []));
    } catch (e) {
      emit(state.copyWith(currentState: CurrentAppState.ERROR,
      ));
    }
  }
}
