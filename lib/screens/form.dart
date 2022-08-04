import 'package:flutter/material.dart';
import 'package:trezor/models/credential.dart';
import 'package:trezor/strings/strings.dart';

class Form extends StatefulWidget {

  final Credential? _credential;

  const Form({Key? key, Credential? credential})
      : _credential = credential,
        super(key: key);



  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {

  late final bool _isEditing;


  @override
  void initState() {
    super.initState();
    _isEditing = widget._credential != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
      FloatingActionButton(
        child: Text(_isEditing? Strings.editCredential : Strings.addCredential),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){return }));


          // MaterialPageRoute(
          //     builder: (context) => MeteostationAddEditScreenBase(meteostation: widget.meteostation, listOfGws: widget.listOfGws,))

        },),
      appBar: AppBar(
        title: Text(_isEditing? Strings.editCredential : Strings.addCredential),
      ),
      body: Column(
        children: [
          Container(),
        ],
      )
    );
  }
}
