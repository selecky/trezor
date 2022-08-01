import 'package:get_it/get_it.dart';
import 'package:trezor/repos/cred_repo.dart';

final locator = GetIt.I;

Future<void> setupLocator () async{

  locator.registerLazySingleton<CredRepo>(() => CredRepo());

}