import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trezor/models/credential.dart';
import 'package:trezor/repos/cred_repo.dart';

final locator = GetIt.I;

Future<void> setupLocator () async{

  // Initializing Hive database
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  Hive.registerAdapter(CredentialAdapter());
  final Box<dynamic> box = await Hive.openBox('credentials');

  locator.registerLazySingleton<CredRepo>(() => CredRepo(box: box));

}