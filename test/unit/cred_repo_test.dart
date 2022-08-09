
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trezor/models/credential.dart';
import 'package:trezor/repos/cred_repo.dart';


class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

main() {

  late CredRepo repo;
  late MockFlutterSecureStorage mockFlutterSecureStorage;
  late Credential testCred;
  late Credential testCred2;
  late Directory tempDir;
  late Box<dynamic> box;
  late SharedPreferences prefs;

  setUpAll(() async{
    // Initializing Hive database
    tempDir = await getApplicationDocumentsDirectory();
    Hive.init(tempDir.path);
    Hive.registerAdapter(CredentialAdapter());
    box = await Hive.openBox('tests');
  });

  setUp(() async{
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    repo = CredRepo(box: box, secureStorage: mockFlutterSecureStorage);
    testCred = Credential(id: 'id', title: 'title', username: 'username', password: 'password');
    testCred2 = Credential(id: 'id2', title: 'title2', username: 'username2', password: 'password2');
  });

  tearDown((){
    // secureStorage.deleteAll();
    box.clear();
  });

  tearDownAll((){
    Hive.close();
  });

  group('CredRepo tests',() {

    test('test fetchCredentials() when no credentials', () async{
      List<Credential> credentials =  repo.fetchCredentials();
      expect(credentials, []);
    });

    // Other methods in CredRepo are unit-tested with SharedPreferences instead of FlutterSecureStorage
    // because FlutterSecureStorage can not run without device.

    // According to owner of the FlutterSecureStorage package:
    // The plugin could be run only on devices/simulators/emulators,
    // because it contains platform specific logic (keychain in iOS , key store in android).
    // (https://github.com/mogol/flutter_secure_storage/issues/29)

    test('test fetchCredentials(), addEditCredential(), deleteCredential()', () async{

      // adding credential
      when(() => mockFlutterSecureStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) => prefs.setString(testCred.id, testCred.password));
      repo.addEditCredential(credential: testCred);

      // adding another credential
      when(() => mockFlutterSecureStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) => prefs.setString(testCred2.id, testCred2.password));
      repo.addEditCredential(credential: testCred2);

      // deleting credential
      when(() => mockFlutterSecureStorage.delete(key: any(named: 'key')))
          .thenAnswer((_) => prefs.remove(testCred2.id));
      repo.deleteCredential(credId: testCred2.id);

      // fetching credentials
      List<Credential> list = repo.fetchCredentials();

      expect(list.length, 1);
    });


    test('test that password is not stored in Hive', () async{

      // adding credential
      when(() => mockFlutterSecureStorage.write(key: testCred.id, value: testCred.password))
          .thenAnswer((_) => prefs.setString(testCred.id, testCred.password));
      repo.addEditCredential(credential: testCred);

      List<Credential> list = repo.fetchCredentials();
      expect(list[0].password, '');
    });

  });
}