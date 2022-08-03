import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trezor/blocs/cred_cubit.dart';
import 'package:trezor/locator/service_locator.dart';
import 'package:trezor/models/credential.dart';
import 'package:trezor/repos/cred_repo.dart';
import 'package:trezor/screens/master.dart';
import 'package:trezor/strings/strings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {

  // Initializing service locator
  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CredCubit(repo: locator<CredRepo>())..init(),
      child: MaterialApp(
        title: Strings.appTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Master(),
      ),
    );
  }
}