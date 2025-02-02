import 'package:dartz/dartz.dart';
import 'package:flutter_repository_pattern_base/core/errors/exceptions.dart';
import 'package:flutter_repository_pattern_base/core/errors/failure.dart';
import 'package:flutter_repository_pattern_base/core/utils/typedef.dart';
import 'package:flutter_repository_pattern_base/src/authentication/data/datasource/auhtentication_remote_data_source.dart';
import 'package:flutter_repository_pattern_base/src/authentication/domain/entities/user.dart';
import 'package:flutter_repository_pattern_base/src/authentication/domain/repositories/authentication_repository.dart';
// import 'package:flutter_repository_pattern_base/src/authentication/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation implements AuthenticationRepository{
  
  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({required String name, required String avatar, required String createdAt}) async {
    // TDD
    // call the remote data source
    // check result

    try {
      await _remoteDataSource.createUser(name: name, avatar: avatar, createdAt: createdAt);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    print("Get Users");
    try {
      final result = await _remoteDataSource.getUsers();
      print('result');
      print(result);
      return Right(result);
    } on ServerException catch (e) {
      print(Left(ApiFailure.fromException(e)));
      return Left(ApiFailure.fromException(e));
    }
  }

}