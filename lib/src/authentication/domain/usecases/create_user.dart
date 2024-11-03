import 'package:equatable/equatable.dart';
import 'package:flutter_repository_pattern_base/core/usecase/usecase.dart';
import 'package:flutter_repository_pattern_base/core/utils/typedef.dart';
import 'package:flutter_repository_pattern_base/src/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UsecaseWithParam<void, CreateUserParams>{
  const CreateUser(this._repository);

  final AuthenticationRepository _repository;
  
  @override
  ResultVoid call(CreateUserParams params) async => _repository.createUser(
    name: params.name, 
    avatar: params.avatar, 
    createdAt: params.createdAt
  );

  // extends UsecaseWithParam
  // ResultVoid createUser({
  //   required String name,
  //   required String avatar,
  //   required String createdAt,
  // }) async => _repository.createUser(name: name, avatar: avatar, createdAt: createdAt);

}

class CreateUserParams extends Equatable{
  const CreateUserParams({required this.name, required this.avatar, required this.createdAt});

  final String name;
  final String avatar;
  final String createdAt;
  
  @override
  List<Object?> get props => [name, avatar, createdAt];
}