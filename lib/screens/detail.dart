import 'package:flutter/material.dart';
import 'package:trezor/models/credential.dart';
import 'package:trezor/screens/add_edit_cred.dart';
import 'package:trezor/strings/strings.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key, required Credential credential})
      : _credential = credential,
        super(key: key);

  final Credential _credential;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEditCred(
                        credential: widget._credential,
                      )));
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(Strings.detail),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.topic),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(widget._credential.title),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Icon(Icons.account_circle),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(widget._credential.username),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Icon(Icons.key),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(widget._credential.password),
                    Expanded(child: Container()),
                    InkWell(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Icon(_isPasswordVisible? Icons.visibility_off : Icons.visibility, size: 40,)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
