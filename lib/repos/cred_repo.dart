import 'package:hive/hive.dart';
import 'package:trezor/models/credential.dart';

class CredRepo {

  final Box _box;

  CredRepo({required Box box}) : _box = box;



  List<Credential> fetchCredentials() {
  }

  void addCredential({required Credential credential}) {
  }

  void removeCredential({required String id}) {
  }

  void updateCredential({required Credential credential}) {
  }

}