import 'package:flutter/material.dart';
import 'package:trezor/screens/master_screen.dart';
import 'package:trezor/strings/strings.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {

  late final FocusNode _focusNode1;
  late final FocusNode _focusNode2;
  late final FocusNode _focusNode3;
  late final FocusNode _focusNode4;

  late final TextEditingController _num1Controller;
  late final TextEditingController _num2Controller;
  late final TextEditingController _num3Controller;
  late final TextEditingController _num4Controller;

  late bool _isPinComplete;

  @override
  void initState() {
    super.initState();
    _isPinComplete = false;

    _num1Controller = TextEditingController();
    _num2Controller = TextEditingController();
    _num3Controller = TextEditingController();
    _num4Controller = TextEditingController();

    _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
    _focusNode3 = FocusNode();
    _focusNode4 = FocusNode();
  }

  @override
  void dispose() {
    _num1Controller.dispose();
    _num2Controller.dispose();
    _num3Controller.dispose();
    _num4Controller.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    Strings.pin,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(
                    width: 16,
                  ),
// Num1
                  SizedBox(
                    width: 40,
                    child: TextFormField(
                      focusNode: _focusNode1,
                      autofocus: true,
                      obscureText: true,
                      obscuringCharacter: '*',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      controller: _num1Controller,
                      onChanged: (String value) {
                        if (value != '') {
                          _focusNode2.requestFocus();
                        }
                        checkPinComplete();
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
// Num2
                  SizedBox(
                    width: 40,
                    child: TextFormField(
                      focusNode: _focusNode2,
                      obscureText: true,
                      obscuringCharacter: '*',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      controller: _num2Controller,
                      onChanged: (String value) {
                        if (value == '') {
                          _focusNode1.requestFocus();
                        } else {
                          _focusNode3.requestFocus();
                        }
                        checkPinComplete();
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
// Num3
                  SizedBox(
                    width: 40,
                    child: TextFormField(
                      focusNode: _focusNode3,
                      obscureText: true,
                      obscuringCharacter: '*',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      controller: _num3Controller,
                      onChanged: (String value) {
                        if (value == '') {
                          _focusNode2.requestFocus();
                        } else {
                          _focusNode4.requestFocus();
                        }
                        checkPinComplete();
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
// Num4
                  SizedBox(
                    width: 40,
                    child: TextFormField(
                      focusNode: _focusNode4,
                      obscureText: true,
                      obscuringCharacter: '*',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      controller: _num4Controller,
                      onChanged: (String value) {
                        if (value == '') {
                          _focusNode3.requestFocus();
                        }
                        checkPinComplete();
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              IgnorePointer(
                ignoring: !_isPinComplete,
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const MasterScreen()));
                    },
                    child: Card(
                      color: _isPinComplete
                          ? Theme.of(context).primaryColor
                          : Colors.white30,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          Strings.savePin,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ));
  }

  void checkPinComplete() {
    if (_num1Controller.text.isNotEmpty &&
        _num2Controller.text.isNotEmpty &&
        _num3Controller.text.isNotEmpty &&
        _num4Controller.text.isNotEmpty) {
      setState(() {
        _isPinComplete = true;
      });
    } else {
      setState(() {
        _isPinComplete = false;
      });
    }
  }
}
