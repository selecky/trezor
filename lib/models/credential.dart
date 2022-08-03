
import 'package:hive/hive.dart';

part 'credential.g.dart';

@HiveType(typeId: 0)
class Credential {

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String password;

  Credential({
    required this.id,
    required this.title,
    required this.username,
    required this.password
  });

}