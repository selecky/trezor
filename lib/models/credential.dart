import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'credential.g.dart';

@HiveType(typeId: 0)
class Credential extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String password;

  const Credential(
      {required this.id, required this.title, required this.username, required this.password});

  Credential copyWith({String? id, String? title, String? username, String? password}) {
    return Credential(
        id: id?? this.id,
        title: title?? this.title,
        username: username?? this.username,
        password: password?? this.password
    );
  }

  @override
  List<Object?> get props => [id, title, username, password];
}
