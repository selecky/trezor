import 'package:flutter/material.dart';
import 'package:trezor/models/credential.dart';

class MyCredentialCard extends StatelessWidget {

  const MyCredentialCard({
    Key? key,
    required Credential credential,
    required Function() onTap,
  })
      : _credential = credential,
        _onTap = onTap,
        super(key: key);

  final Credential _credential;
  final Function() _onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: SizedBox(
          height: 80,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.topic),
                      const SizedBox(width: 8,),
                      Text(_credential.title, overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      const Icon(Icons.account_circle),
                      const SizedBox(width: 8,),
                      Text(_credential.username),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
