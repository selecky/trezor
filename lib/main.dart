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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late final Future _getPinFuture;
  String? _savedPin;

  @override
  void initState() {
    super.initState();
    _getPinFuture = locator<CredRepo>().getPin();
  }

  @override
  Widget build(BuildContext context) {

    // Force portrait orientation
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,]);

    return FutureBuilder(
      future: _getPinFuture,
      builder: (context, snapshot) {

        if(snapshot.connectionState == ConnectionState.done){
          if (snapshot.data == null){
            _savedPin = null;
          } else {
            _savedPin = snapshot.data as String;
          }
          return BlocProvider(
            create: (context) => CredCubit(repo: locator<CredRepo>())..init(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Strings.appTitle,
              home: _savedPin != null? const MasterScreen() : const PinScreen(),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}