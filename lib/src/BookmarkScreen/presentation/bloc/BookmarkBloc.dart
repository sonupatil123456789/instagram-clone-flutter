
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/BookmarkScreen/domain/use_cases/AddToBookmarkUsecase.dart';
import 'package:instagram_clone/src/BookmarkScreen/domain/use_cases/DeletBookmarkUsecase.dart';
import 'package:instagram_clone/src/BookmarkScreen/domain/use_cases/GetAllUsersBookmarkUsecase.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'BookmarkEvent.dart';
import 'BookmarkState.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  AddToBookmarkUsecase addBookmark;
  DeletBookmarkUsecase deletBookmark;
  GetAllUsersBookmarkUsecase getAllUserBookmark;



  BookmarkBloc(
      {required this.deletBookmark,
      required this.addBookmark,
      required this.getAllUserBookmark,

      })
      : super(BookmarkState(
          currentState: CurrentAppState.INITIAL,
          bookmarkList: [],
        )) {

          
    on<AddBookmarkEvent>(_addBookmarkEvent);
    on<DeletBookmarkEvent>(_deletBookmarkEvent);
    on<GetAllBookmarkEvent>(_getAllBookmarkEvent);
  }

  _addBookmarkEvent(AddBookmarkEvent event, Emitter<BookmarkState> emit) async {
    
      final data = await addBookmark.call(event.bookmark ,event.context);

  }
  _getAllBookmarkEvent(GetAllBookmarkEvent event, Emitter<BookmarkState> emit) async {
    emit(state.copyWith(currentState: CurrentAppState.LOADING));
    try {
      final data = await getAllUserBookmark.call(event.isRefresh ,event.context);
      emit(state.copyWith(currentState: CurrentAppState.SUCCESS, bookmarkList: data));
    } catch (e) {
      emit(state.copyWith(currentState: CurrentAppState.ERROR,));
    }
  }

  _deletBookmarkEvent(DeletBookmarkEvent event, Emitter<BookmarkState> emit) async {
       emit(state.copyWith(currentState: CurrentAppState.LOADING,bookmarkList:state.bookmarkList ));
    try {
      final data = await deletBookmark.call(event.bookmarkId , event.context);
      if (data == true) {
      final deleteddata =  state.bookmarkList!.where((element) => element.postId == event.bookmarkId).toList();
      state.bookmarkList!.remove(deleteddata.first);
      emit(state.copyWith(currentState: CurrentAppState.SUCCESS,bookmarkList:state.bookmarkList ));
      } else {
         emit(state.copyWith(currentState: CurrentAppState.ERROR,bookmarkList:state.bookmarkList ));
      }
    } catch (e) {
    emit(state.copyWith(currentState: CurrentAppState.ERROR,bookmarkList:state.bookmarkList ));
    }
  }







}
