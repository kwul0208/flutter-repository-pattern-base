import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_repository_pattern_base/src/authentication/domain/entities/user.dart';
import 'package:flutter_repository_pattern_base/src/authentication/domain/usecases/create_user.dart';
import 'package:flutter_repository_pattern_base/src/authentication/domain/usecases/get_user.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({required CreateUser createUser, required GetUser getUser}) 
    : _createUser = createUser,
      _getUser    = getUser,
      super(const AuthenticationInitial());

  final CreateUser _createUser;
  final GetUser _getUser;

  Future<void> createUser({required String name, required String avatar, required String createdAt})async{
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(name: name, avatar: avatar, createdAt: createdAt));

    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)), (_) => emit(const UserCreated()));
  }

  Future<void> getUsers()async{
    emit(const GettingUsers());

    final result = await _getUser();

    result.fold((failure) => failure.errorMessage, (users) => UsersLoaded(users));
  }
}
