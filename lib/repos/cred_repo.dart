import 'package:hive/hive.dart';
import 'package:trezor/models/credential.dart';

class CredRepo {

  final Box _box;

  CredRepo({required Box box}) : _box = box;



  List<Credential> fetchCredentials() {
    return _box.values.toList().cast<Credential>();
  }

  void addCredential({required Credential credential}) {
    _box.put(credential.id , credential);
  }

  void deleteCredential({required String credId}) {
    _box.delete(credId);
  }

  void editCredential({required Credential credential}) {
    _box.put(credential.id , credential);
  }

}