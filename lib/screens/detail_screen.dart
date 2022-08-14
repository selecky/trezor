import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trezor/blocs/cred_cubit.dart';
import 'package:trezor/locator/service_locator.dart';
import 'package:trezor/models/credential.dart';
import 'package:trezor/repos/cred_repo.dart';
import 'package:trezor/screens/add_edit_cred_screen.dart';
import 'package:trezor/screens/master_screen.dart';
import 'package:trezor/strings/strings.dart';

class DetailScreen extends StatefulWidget {

  DetailScreen({Key? key, required this.credential, CredRepo? credRepo}) : super(key: key) {
    _credRepo = credRepo?? locator<CredRepo>();
  }

  final Credential credential;
  CredRepo? _credRepo;


  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isPasswordVisible = false;
  late final Future _getSecretsFuture;
  String? _savedPin;
  String? _savedPassword;
  late final TextEditingController pinController;

  @override
  void initState() {
    super.initState();
    _getSecretsFuture = getSecrets(credRepo: widget._credRepo!);
    pinController = TextEditingController();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.delete_forever),
            onPressed: () {
              deleteCred(widget.credential.id);
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
                            credential: widget.credential.copyWith(password: _savedPassword),
                          )));
            },
          ),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(Strings.detail),
      ),
      body: FutureBuilder(
          future: _getSecretsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<String> listSecrets = snapshot.data as List<String>;
              _savedPin = listSecrets[0];
              _savedPassword = listSecrets[1];
              return Padding(
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
                            SelectableText(widget.credential.title),
                            const Expanded(child: SizedBox()),
                            InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(Strings.textCopied),
                                    duration: const Duration(seconds: 1),
                                  ));
                                  Clipboard.setData(
                                      ClipboardData(text: (widget.credential.title)));
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
                            SelectableText(widget.credential.username),
                            const Expanded(child: SizedBox()),
                            InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(Strings.textCopied),
                                    duration: const Duration(seconds: 1),
                                  ));
                                  Clipboard.setData(
                                      ClipboardData(text: (widget.credential.username)));
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
                              _isPasswordVisible ? _savedPassword! : '******',
                            ),
                            const Expanded(child: SizedBox()),
                            InkWell(
                                onTap: () {
                                  // Ask for PIN
                                  pinController.text = '';
                                  if (!_isPasswordVisible) {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            title: Text(Strings.pin),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(Strings.insertPin),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                SizedBox(
                                                  width: 160,
                                                  child: TextFormField(
                                                    obscureText: true,
                                                    obscuringCharacter: '*',
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context).textTheme.titleLarge,
                                                    maxLength: 4,
                                                    keyboardType: TextInputType.number,
                                                    controller: pinController,
                                                    decoration: InputDecoration(
                                                      counterText: '',
                                                      border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(16)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    return;
                                                  },
                                                  child: Text(Strings.cancel.toUpperCase())),
                                              TextButton(
                                                  onPressed: () {
                                                    if (pinController.text != _savedPin) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (_) => AlertDialog(
                                                                title: Text(Strings.pinIncorrect),
                                                                content:
                                                                    Text(Strings.pinIncorrectInfo),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                        return;
                                                                      },
                                                                      child: Text(
                                                                          Strings.ok.toUpperCase()))
                                                                ],
                                                              ));
                                                    } else {
                                                      setState(() {
                                                        _isPasswordVisible = !_isPasswordVisible;
                                                      });
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: Text(Strings.ok.toUpperCase())),
                                            ],
                                          );
                                        });
                                  } else {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  }
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
                                      text: (_isPasswordVisible
                                          ? widget.credential.password
                                          : '******')));
                                },
                                child: const Icon(Icons.copy)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  void deleteCred(String credId) async {
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(Strings.delete),
              content: Text(Strings.deleteInfo),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      return;
                    },
                    child: Text(Strings.cancel.toUpperCase())),
                TextButton(
                    onPressed: () {
                      context.read<CredCubit>().deleteCredential(credId);
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const MasterScreen()));
                    },
                    child: Text(Strings.delete.toUpperCase())),
              ],
            ));
  }

  Future<String?> getSavedPin(CredRepo credRepo) async {
    return await credRepo.getPin();
  }

  Future<List<String>> getSecrets({required CredRepo credRepo}) async{
    String? pin = await credRepo.getPin();
    String? password = await credRepo.getCredPassword(widget.credential.id);
    return [pin!,password!];
  }
}
