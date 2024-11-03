import 'dart:convert';

import 'package:flutter_repository_pattern_base/core/errors/exceptions.dart';
import 'package:flutter_repository_pattern_base/core/utils/constants.dart';
import 'package:flutter_repository_pattern_base/core/utils/typedef.dart';
import 'package:flutter_repository_pattern_base/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource{
  Future<void> createUser({
    required String name, 
    required String avatar, 
    required String createdAt
  });

  Future<List<UserModel>> getUsers();
}

const String kCreate = '/user';
const String kGet = '/users';

class AuthenticationRemoteDataSourceIml implements AuthenticationRemoteDataSource{

  AuthenticationRemoteDataSourceIml(this._client);

  final http.Client _client;

  @override
  Future<void> createUser({required String name, required String avatar, required String createdAt}) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kCreate'),
        body: jsonEncode({
          'name': name,
          'avatar': avatar,
          'createdAt': createdAt
        })
      );

      if (response.statusCode != 200 || response.statusCode != 201){
        throw ServerException(message: response.body, statusCode: response.statusCode);
      }
    } on ServerException{
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
    
      final response = await _client.get(Uri.parse('$kBaseUrl/$kGet'));
      
      if (response.statusCode != 200 || response.statusCode != 201){
        throw ServerException(message: response.body, statusCode: response.statusCode);
      }

      return List<DataMap>.from(jsonDecode(response.body) as List).map((userData) => UserModel.fromMap(userData)).toList();

    } on ServerException{
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

}