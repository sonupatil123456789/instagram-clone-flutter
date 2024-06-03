import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/utils/resources/enums.dart';

import '../../domain/use_cases/GetAllVideoPostUsecase.dart';
import 'ReelEvent.dart';
import 'ReelState.dart';

class ReelBloc extends Bloc<ReelEvent, ReelState> {
  GetAllVideoPostUsecase getAllVideoPost;

  ReelBloc({
    required this.getAllVideoPost,
  }) : super(ReelState(  currentState: CurrentAppState.INITIAL, videoPostList: const [])) {
    on<GetAllVideoPostEvent>(_getAllVideoPostEvent);
  }

  _getAllVideoPostEvent(
      GetAllVideoPostEvent event, Emitter<ReelState> emit) async {
    emit(state.copyWith(currentState: CurrentAppState.LOADING));
    try {
      final videoPost = await getAllVideoPost.call(event.isRefresh, event.context);
      emit(state.copyWith( currentState: CurrentAppState.SUCCESS, videoPostList: videoPost ?? []));
    } catch (e) {
      emit(state.copyWith(currentState: CurrentAppState.ERROR,
      ));
    }
  }
}
