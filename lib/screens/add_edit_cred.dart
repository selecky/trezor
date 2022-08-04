import 'package:flutter/material.dart';
import 'package:trezor/models/credential.dart';
import 'package:trezor/strings/strings.dart';

class AddEditCred extends StatefulWidget {

  final Credential? _credential;

  const AddEditCred({Key? key, Credential? credential})
      : _credential = credential,
        super(key: key);



  @override
  _AddEditCredState createState() => _AddEditCredState();
}

class _AddEditCredState extends State<AddEditCred> {

  late final bool _isEditing;
  late final Credential? _credential;

  String? _title;
  String? _username;
  String? _password;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  void initState() {
    super.initState();

    if(widget._credential != null){
      _credential = widget._credential;
      _isEditing = true;
      _titleController.text = _credential!.title;
      _usernameController.text = _credential!.username;
      _passwordController.text = _credential!.password;
      _title = _credential!.title;
      _username = _credential!.username;
      _password = _credential!.password;
    } else {
      _credential =null;
      _isEditing = false;
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
      floatingActionButton:
      FloatingActionButton.extended(
        label: Text(_isEditing? Strings.editCredential : Strings.addCredential),
        onPressed: () {

        },),
      appBar: AppBar(
        title: Text(_isEditing? Strings.editCredential : Strings.addCredential),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

// Title
              Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Container(
                        width: 80,
                          color: Colors.red,
                          child: Text(Strings.title, style: Theme.of(context).textTheme.titleMedium,))),
                  const SizedBox(width: 16,),
                  Flexible(
                    flex: 2,
                    child: Container(
                      color: Colors.blue,
                      child: TextField(
                        controller: _titleController,
                        onChanged: (String value) {
                          _title = value;
                        },
                      ),
                    ),
                  )
                ],
              ),

// Username
              Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Text(Strings.username, style: Theme.of(context).textTheme.titleMedium,)),
                  const SizedBox(width: 16,),
                  Flexible(
                    flex: 2,
                    child: TextField(
                      controller: _usernameController,
                      onChanged: (String value) {
                        _username = value;
                      },
                    ),
                  )
                ],
              ),

// Password
              Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Text(Strings.password, style: Theme.of(context).textTheme.titleMedium,)),
                  const SizedBox(width: 16,),
                  Flexible(
                    flex: 2,
                    child: TextField(
                      controller: _passwordController,
                      onChanged: (String value) {
                        _password = value;
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
