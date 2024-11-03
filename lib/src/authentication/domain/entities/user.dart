import 'package:equatable/equatable.dart';

class User extends Equatable{

  const User({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.avatar
  });

  // const User.empty() 
  //   : this(
  //     id: '1',
  //     name: "asdas",

  //   )

  final int id;
  final String name;
  final String avatar;
  final String createdAt;

  @override
  List<Object?> get props => [id];
}