import 'package:flutter_repository_pattern_base/src/authentication/data/datasource/auhtentication_remote_data_source.dart';
import 'package:flutter_repository_pattern_base/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:flutter_repository_pattern_base/src/authentication/domain/usecases/create_user.dart';
import 'package:flutter_repository_pattern_base/src/authentication/domain/usecases/get_user.dart';
import 'package:flutter_repository_pattern_base/src/authentication/presentation/cubit/cubit/authentication_cubit.dart';
import 'package:flutter_repository_pattern_base/src/authentication/repositories/authentication_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init()async{
  sl
    ..registerFactory(() => AuthenticationCubit(createUser: sl(), getUser: sl()))
    
    // use cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUser(sl()))

    // repositories
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImplementation(sl()))

    // data soruces
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceIml(sl()))

    // external dependecies
    ..registerLazySingleton(http.Client.new);
    
}