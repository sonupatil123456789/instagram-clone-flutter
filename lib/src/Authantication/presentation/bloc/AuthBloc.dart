import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/CreatAccountUsecase.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/GetUserUsecase.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/IsUserOnline.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/LogInUsecase.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/ResetPasswordUsecase.dart';

import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthEvents.dart';
import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthState.dart';
import 'package:instagram_clone/utils/resources/enums.dart';


import '../../domain/entity/UserEntity.dart';
import '../../domain/use_cases/GetUserStreamListUsecase.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  CreatAccountUsecase createAcount;
  LoginUsecase logIn;
  ResetPasswordUsecase resetPassword;
  IsOnlineUsecase isonline;
  GetUserUsecase getUser;
  GetUserStreamListUsecase getStreamOfUserList;

  AuthBloc({
    required this.createAcount,
    required this.logIn,
    required this.resetPassword,
    required this.isonline,
    required this.getUser,
    required this.getStreamOfUserList,
  }) : super(AuthState(currentState: CurrentAppState.INITIAL, userModel: UserModel())) {
    on<CreateAccountWithEmailPasswordEvent>(_createAccountWIthEmailPassword);
    on<LogInWithEmailPasswordEvent>(_logInWIthEmailPassword);
    on<ResetPasswordEvent>(_resetPassword);
    on<IsOnlineEvent>(_isOnline);
    // on<GetAllUserStreamListEvent>(_getAllUserStreamList);
  }

  _logInWIthEmailPassword(
      LogInWithEmailPasswordEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(currentState: CurrentAppState.LOADING));
    final userEntity = await logIn.call(
        LogInParams(email: event.email, password: event.password),
        event.context);
    if (userEntity != null) {
      emit(state.copyWith(currentState: CurrentAppState.SUCCESS, userModel: userEntity));
    } else {
      emit(state.copyWith(currentState: CurrentAppState.ERROR));
    }
  }

  _createAccountWIthEmailPassword(CreateAccountWithEmailPasswordEvent event,
      Emitter<AuthState> emit) async {
    emit(state.copyWith(currentState: CurrentAppState.LOADING));
    final userEntity = await createAcount.call(
        CreatAccountParams(
            uniqueName: event.uniqueName,
            email: event.email,
            userName: event.userName,
            phoneNumber: event.phoneNumber,
            password: event.password),
        event.context);
    if (userEntity != null) {
      emit(state.copyWith(currentState: CurrentAppState.SUCCESS, userModel: userEntity));
    } else {
      emit(state.copyWith(currentState: CurrentAppState.ERROR));
    }
  }

  _resetPassword(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(currentState: CurrentAppState.LOADING));
      resetPassword.call(event.email, event.context);
      emit(state.copyWith(
        currentState: CurrentAppState.SUCCESS,
      ));
    } catch (e) {
      emit(state.copyWith(currentState: CurrentAppState.ERROR));
    } finally {
      emit(state.copyWith(currentState: CurrentAppState.INITIAL));
    }
  }

  _isOnline(IsOnlineEvent event, Emitter<AuthState> emit) async {
    try {
      isonline.call(event.isOnline, event.context);
    } catch (e) {}
  }

  Future<UserEntity> getUserDetails(context, isRefresh) async  {
     try {
      final data = await getUser.call(isRefresh,context);
      return data;
    } catch (e) {
      rethrow ;
    } 
  }

  // Stream<List<UserEntity>?>? _getAllUserStreamList(GetAllUserStreamListEvent event, Emitter<AuthState> emit)  {
  //   try {
  //     return getStreamOfUserList.call(event.searchQuery, event.context);
  //   } catch (e) {
  //     rethrow ;
  //   }
  // }





}
