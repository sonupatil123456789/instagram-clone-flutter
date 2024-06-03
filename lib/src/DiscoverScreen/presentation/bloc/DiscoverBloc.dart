import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/DiscoverScreen/domain/use_cases/followUserUsecase.dart';
import 'package:instagram_clone/src/DiscoverScreen/presentation/bloc/DiscoverEvent.dart';
import 'package:instagram_clone/utils/resources/enums.dart';

import 'DiscoverState.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  FollowUserUsecase followUser;

  DiscoverBloc({required this.followUser})
      : super(DiscoverState(currentState: CurrentAppState.INITIAL, 
      // follow: FollowModel()
        isFollowing: false 
      )) {
    on<FollowUserEvent>(_followUserEvent);

  }

  _followUserEvent(FollowUserEvent event, Emitter<DiscoverState> emit) async {
    emit(state.copyWith(currentState: CurrentAppState.LOADING));
    try {
      final data = await followUser.call(FollowUserParams(following: event.following),event.context);
      emit(state.copyWith(currentState: CurrentAppState.SUCCESS,));
    } catch (e) {
      emit(state.copyWith(currentState: CurrentAppState.ERROR,));
    }
  }
}
