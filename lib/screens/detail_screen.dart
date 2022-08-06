import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trezor/blocs/cred_cubit.dart';
import 'package:trezor/models/credential.dart';
import 'package:trezor/screens/add_edit_cred_screen.dart';
import 'package:trezor/screens/master_screen.dart';
import 'package:trezor/strings/strings.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required Credential credential})
      : _credential = credential,
        super(key: key);

  final Credential _credential;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.delete_forever),
            onPressed: () {
              deleteCred(widget._credential.id);
            },
          ),
          const SizedBox(
            height: 16,
          ),
          FloatingActionButton(
            heroTag: 'FAB',
            child: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddEditCredScreen(
                            credential: widget._credential,
                          )));
            },
          ),
        ],
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
                    SelectableText(widget._credential.title),
                    const Expanded(child: SizedBox()),
                    InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(Strings.textCopied),
                            duration: const Duration(seconds: 1),
                          ));
                          Clipboard.setData(ClipboardData(text: (widget._credential.title)));
                        },
                        child: const Icon(Icons.copy)),
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
                    SelectableText(widget._credential.username),
                    const Expanded(child: SizedBox()),
                    InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(Strings.textCopied),
                            duration: const Duration(seconds: 1),
                          ));
                          Clipboard.setData(ClipboardData(text: (widget._credential.username)));
                        },
                        child: const Icon(Icons.copy)),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Icon(Icons.key),
                    const SizedBox(
                      width: 16,
                    ),
                    SelectableText(
                      _isPasswordVisible ? widget._credential.password : '******',
                    ),
                    const Expanded(child: SizedBox()),
                    InkWell(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Icon(
                          _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                        )),
                    const SizedBox(
                      width: 16,
                    ),
                    InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(Strings.textCopied),
                            duration: const Duration(seconds: 1),
                          ));
                          Clipboard.setData(ClipboardData(
                              text: (_isPasswordVisible ? widget._credential.password : '******')));
                        },
                        child: const Icon(Icons.copy)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteCred(String credId) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(Strings.delete),
              content: Text(Strings.deleteInfo),
              actions: [
                TextButton(onPressed: (), child: Text(Strings.cancel))],
            ));

    context.read<CredCubit>().deleteCredential(credId);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MasterScreen()));
  }
}
