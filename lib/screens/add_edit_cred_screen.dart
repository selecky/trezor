import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trezor/blocs/cred_cubit.dart';
import 'package:trezor/models/credential.dart';
import 'package:trezor/screens/master_screen.dart';
import 'package:trezor/strings/strings.dart';

class AddEditCredScreen extends StatefulWidget {
  final Credential? _credential;

  const AddEditCredScreen({Key? key, Credential? credential})
      : _credential = credential,
        super(key: key);

  @override
  _AddEditCredScreenState createState() => _AddEditCredScreenState();
}

class _AddEditCredScreenState extends State<AddEditCredScreen> {
  late final bool _isEditing;
  Credential? _credential;

  String? _title;
  String? _username;
  String? _password;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget._credential != null) {
      _credential = widget._credential;
      _isEditing = true;
      _titleController.text = _credential!.title;
      _usernameController.text = _credential!.username;
      _passwordController.text = _credential!.password;
      _title = _credential!.title;
      _username = _credential!.username;
      _password = _credential!.password;
    } else {
      _isEditing = false;
      _title = '';
      _username = '';
      _password = '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          heroTag: 'FAB',
          label: Text(_isEditing ? Strings.editCredential : Strings.addCredential),
          onPressed: () {
            addEditCred();
          },
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(_isEditing ? Strings.editCredential : Strings.addCredential),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
// Title
              TextFormField(
                controller: _titleController,
                onChanged: (String value) {
                  _title = value;
                },
                decoration: InputDecoration(
                  label: Text(Strings.title),
                  icon: const Icon(Icons.topic),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

// Username
              TextFormField(
                controller: _usernameController,
                onChanged: (String value) {
                  _username = value;
                },
                decoration: InputDecoration(
                  label: Text(Strings.username),
                  icon: const Icon(Icons.account_circle),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

// Password
              TextFormField(
                controller: _passwordController,
                onChanged: (String value) {
                  _password = value;
                },
                decoration: InputDecoration(
                  label: Text(Strings.password),
                  icon: const Icon(Icons.key),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ],
          ),
        ));
  }

  void addEditCred() async{
    // Show snackbar when some fields are empty
    if (_title!.trim().isEmpty || _username!.trim().isEmpty || _password!.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
        children: [
          Text(Strings.fillAllFields + ': '),
          if (_title!.trim().isEmpty) const Icon(Icons.topic, color: Colors.white),
          if (_username!.trim().isEmpty) const Icon(Icons.account_circle, color: Colors.white),
          if (_password!.trim().isEmpty) const Icon(Icons.key, color: Colors.white),
        ],
      )));
      return;
    }

    // Validate password
    if(!isPasswordValid(_password!)){

      await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(Strings.weakPassword),
            content: Text(Strings.weakPasswordInfo),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(Strings.ok.toUpperCase())),
            ],
          ));
      return;
    }


    _credential = Credential(
        id: _credential == null
            ? DateTime.now().millisecondsSinceEpoch.toString()
            : _credential!.id,
        title: _title!,
        username: _username!,
        password: _password!);

    if (widget._credential == null) {
      context.read<CredCubit>().addCredential(_credential!);
    } else {
      context.read<CredCubit>().editCredential(_credential!);
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MasterScreen()),
      (Route<dynamic> route) => false,
    );
  }

  bool isPasswordValid(String password) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    return regex.hasMatch(password);
  }

}
