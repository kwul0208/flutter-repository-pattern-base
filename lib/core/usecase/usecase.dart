import 'package:flutter_repository_pattern_base/core/utils/typedef.dart';

abstract class UsecaseWithParam<Type, Params>{
  const UsecaseWithParam();

  ResultFuture<Type> call(Params params);
}

abstract class UseCaseWithoutParams<Type>{
  const UseCaseWithoutParams();

  ResultFuture<Type> call();
}