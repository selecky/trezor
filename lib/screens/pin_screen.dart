import 'package:flutter/material.dart';
import 'package:trezor/strings/strings.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {

  String? _pin;

  String? _num1;
  String? _num2;
  String? _num3;
  String? _num4;


  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  final TextEditingController _num3Controller = TextEditingController();
  final TextEditingController _num4Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _num1Controller.dispose();
    _num2Controller.dispose();
    _num3Controller.dispose();
    _num4Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Strings.setPin),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
// Num1
              TextFormField(
                controller: _num1Controller,
                onChanged: (String value) {
                  _num1 = value;
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

// Num2
              TextFormField(
                controller: _num2Controller,
                onChanged: (String value) {
                  _num2 = value;
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

// Num3
              TextFormField(
                controller: _num3Controller,
                onChanged: (String value) {
                  _num3 = value;
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
}
