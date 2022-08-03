import 'package:flutter/material.dart';
import 'package:trezor/models/credential.dart';

class MyCredentialCard extends StatelessWidget {

  const MyCredentialCard({
    Key? key,
    required Credential credential
  })
      : _credential = credential,
        super(key: key);

  final Credential _credential;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_credential.title),
          const SizedBox(height: 8,),
          Text(_credential.username),
        ],
      ),
    );
  }
}
