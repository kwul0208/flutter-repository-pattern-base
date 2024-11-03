import 'package:flutter_repository_pattern_base/core/usecase/usecase.dart';
import 'package:flutter_repository_pattern_base/core/utils/typedef.dart';
import 'package:flutter_repository_pattern_base/src/authentication/domain/entities/user.dart';
import 'package:flutter_repository_pattern_base/src/authentication/domain/repositories/authentication_repository.dart';

class GetUser extends UseCaseWithoutParams<List<User>>{
  const GetUser(this._repository);
  
  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();

  
}