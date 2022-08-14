import 'package:flutter/material.dart';
import 'package:trezor/locator/service_locator.dart';
import 'package:trezor/repos/cred_repo.dart';
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
          title: Text(Strings.pin),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.setPin,
                style: Theme.of(context).textTheme.titleLarge,
              ),

              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
// Num1
                  SizedBox(
                    width: 40,
                    child: TextFormField(
                      key: const Key('Num1'),
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
                      key: const Key('Num2'),
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
                      key: const Key('Num3'),
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
                      key: const Key('Num4'),
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
                height: 32,
              ),
// SavePinButton
              IgnorePointer(
                ignoring: !_isPinComplete,
                child: InkWell(
                    onTap: () {
                      String pin =
                          '${_num1Controller.text}${_num2Controller.text}${_num3Controller.text}${_num4Controller.text}';
                      locator<CredRepo>().setPin(pin);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const MasterScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Container(
                      key: const Key('SavePinButton'),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: _isPinComplete ? Theme.of(context).primaryColor : Colors.black12,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            Strings.savePin,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.white),
                          ),
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
