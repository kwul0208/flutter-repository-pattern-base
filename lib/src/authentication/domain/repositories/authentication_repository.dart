import 'package:flutter_repository_pattern_base/core/utils/typedef.dart';
import 'package:flutter_repository_pattern_base/src/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository{
  const AuthenticationRepository();

  ResultVoid createUser({required String name, required String avatar, required String createdAt});

  ResultFuture<List<User>> getUsers();
}