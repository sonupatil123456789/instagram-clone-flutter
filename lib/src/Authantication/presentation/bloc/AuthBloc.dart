import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/CreatAccountUsecase.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/GetUserUsecase.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/IsUserOnline.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/LogInUsecase.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/LogOutUsecase.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/ResetPasswordUsecase.dart';
import 'package:instagram_clone/src/Authantication/domain/use_cases/UpdateUserUsecase.dart';

import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthEvents.dart';
import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthState.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/resources/use_case.dart';

import '../../domain/entity/UserEntity.dart';
import '../../domain/use_cases/GetUserStreamListUsecase.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  CreatAccountUsecase createAcount;
  LoginUsecase logIn;
  ResetPasswordUsecase resetPassword;
  IsOnlineUsecase isonline;
  GetUserUsecase getUser;
  GetUserStreamListUsecase getStreamOfUserList;
  UpdateUserUsecase updateUser;
  LogOutUsecase logOut;

  AuthBloc({
    required this.createAcount,
    required this.logIn,
    required this.resetPassword,
    required this.isonline,
    required this.getUser,
    required this.getStreamOfUserList,
    required this.logOut,
    required this.updateUser,
  }) : super(AuthState(
            currentState: CurrentAppState.INITIAL,
            userModel: UserModel(),
            userListStream: StreamController<List<UserEntity>>.broadcast())) {
    on<CreateAccountWithEmailPasswordEvent>(_createAccountWIthEmailPassword);
    on<LogInWithEmailPasswordEvent>(_logInWIthEmailPassword);
    on<ResetPasswordEvent>(_resetPassword);
    on<IsOnlineEvent>(_isOnline);
    on<SigneOutEvent>(_signeOutEvent);
    on<UpdateUserInformationEvent>(_updateUserInformationEvent);
  }

  _logInWIthEmailPassword(
      LogInWithEmailPasswordEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(currentState: CurrentAppState.LOADING));
    final userEntity = await logIn.call(
        LogInParams(email: event.email, password: event.password),
        event.context);
    if (userEntity != null) {
      emit(state.copyWith(
          currentState: CurrentAppState.SUCCESS, userModel: userEntity));
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
      emit(state.copyWith(
          currentState: CurrentAppState.SUCCESS, userModel: userEntity));
    } else {
      emit(state.copyWith(currentState: CurrentAppState.ERROR));
    }
  }

  _updateUserInformationEvent(
      UpdateUserInformationEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(currentState: CurrentAppState.LOADING));
    final userEntity = await updateUser.call(
        UserModel(
            uniqueName: event.uniqueName,
            birthdate: event.birthdate,
            userName: event.userName,
            email: event.email,
            phoneNumber: event.phoneNumber,
            profileImage: event.profileImage),
        event.context);
    if (userEntity == true) {
      emit(state.copyWith(
        currentState: CurrentAppState.SUCCESS,
      ));
    } else {
      emit(state.copyWith(currentState: CurrentAppState.ERROR));
    }
  }

  _resetPassword(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(currentState: CurrentAppState.LOADING));
      await resetPassword.call(event.email, event.context);
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
      await isonline.call(event.isOnline, event.context);
    } catch (e) {}
  }

  _signeOutEvent(SigneOutEvent event, Emitter<AuthState> emit) async {
    await logOut.call(EmptyParams(), event.context);
  }

  Future<UserEntity> getUserDetails(context, isRefresh) async {
    try {
      final data = await getUser.call(isRefresh, context);
      return data;
    } catch (e) {
      return UserEntity();
    }
  }

  // Stream<List<UserEntity>?>? _getAllUserStreamList(GetAllUserStreamListEvent event, Emitter<AuthState> emit)  {
  //   try {
  //     return getStreamOfUserList.call(event.searchQuery, event.context);
  //   } catch (e) {
  //     rethrow ;
  //   }
  // }

  getAllUserStreamList(context, searchQuery) {
    try {
      getStreamOfUserList.call(searchQuery, context).listen((event) {
        state.userListStream.sink.add(event);
      }).onError((error) {
        state.userListStream.sink.addError(error);
      });
    } catch (error) {
      state.userListStream.sink.addError(error);
    }
  }
}
