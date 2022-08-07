import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trezor/blocs/cred_cubit.dart';
import 'package:trezor/locator/service_locator.dart';
import 'package:trezor/repos/cred_repo.dart';
import 'package:trezor/screens/master_screen.dart';
import 'package:trezor/screens/pin_screen.dart';
import 'package:trezor/strings/strings.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Initializing service locator
  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // Force portrait orientation
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,]);

    return BlocProvider(
      create: (context) => CredCubit(repo: locator<CredRepo>())..init(),
      child: MaterialApp(
        title: Strings.appTitle,
        home: const PinScreen(),
      ),
    );
  }
}