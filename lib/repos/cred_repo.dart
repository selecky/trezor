import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:trezor/models/credential.dart';

class CredRepo {

  final Box _box;
  final FlutterSecureStorage _secureStorage;

  CredRepo({required Box box, required FlutterSecureStorage secureStorage})
      : _box = box,
        _secureStorage = secureStorage;



  List<Credential> fetchCredentials() {
    return _box.values.toList().cast<Credential>();
  }

  void addEditCredential({required Credential credential}) {
    // Saving password to FlutterSecureStorage
    _secureStorage.write(key: credential.id, value: credential.password);
    // Saving the rest to Hive
    Credential credWithoutPassword = credential.copyWith(password: '');
    _box.put(credential.id , credWithoutPassword);
  }

  void deleteCredential({required String credId}) {
    _secureStorage.delete(key: credId);
    _box.delete(credId);
  }

  Future<void> setPin(String pin) async{
    await _secureStorage.write(key: 'pin', value: pin);
  }

  Future<String?> getPin() async{
    return await _secureStorage.read(key: 'pin');
  }

  Future<String?> getCredPassword(String credId) async{
    return await _secureStorage.read(key: credId);
  }

}