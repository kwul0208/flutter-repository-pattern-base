import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_repository_pattern_base/src/authentication/domain/entities/user.dart';
import 'package:flutter_repository_pattern_base/src/authentication/domain/usecases/create_user.dart';
import 'package:flutter_repository_pattern_base/src/authentication/domain/usecases/get_user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  
  AuthenticationBloc({required CreateUser createUser, required GetUser getUser}) 
    : _createUser = createUser,
      _getUser    = getUser,
      super(const AuthenticationInitial()) 
  {

    on<CreateUserEvent>(_createUserHandler);
    on<GetUserEvent>(_getUserHandler);

  }
    
  final CreateUser _createUser;
  final GetUser _getUser;

  Future<void> _createUserHandler(CreateUserEvent event, Emitter<AuthenticationState> emit)async{
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(name: event.name, avatar: event.avatar, createdAt: event.createdAt));

    result.fold((failure) => emit(AuthenticationError(failure.errorMessage)), (_) => emit(const UserCreated()));
  }

  Future<void> _getUserHandler(GetUserEvent event, Emitter<AuthenticationState> emit)async{
    emit(const GettingUsers());

    final result = await _getUser();

    result.fold((failure) => failure.errorMessage, (users) => UsersLoaded(users));
  }

}
