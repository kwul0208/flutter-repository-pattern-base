import 'dart:convert';

import 'package:flutter_repository_pattern_base/core/utils/typedef.dart';
import 'package:flutter_repository_pattern_base/src/authentication/domain/entities/user.dart';

class UserModel extends User{
  const UserModel({
    required super.id,
    required super.name,
    required super.avatar,
    required super.createdAt
  });

  factory UserModel.fromJson(String source) => 
    UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map) : 
    super(
      id: map['id'] as int,
      name: map['name'] as String,
      avatar: map['avatar'] as String,
      createdAt: map['createdAt'] as String,
    );

  UserModel copyWith({
    int? id,
    String? name,
    String? avatar,
    String? createdAt
  }){
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt
    );
  }

  

  DataMap toMap() => {
    'id': id,
    'name': name,
    'avatar': avatar,
    'createdAt': createdAt
  };

  String toJson() => jsonEncode(toMap());
}