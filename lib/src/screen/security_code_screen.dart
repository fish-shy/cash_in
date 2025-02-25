import 'package:cash_in/src/screen/home_screen.dart';
import 'package:cash_in/src/services/auth.dart';
import 'package:cash_in/src/widget/lanjutkan_button.dart';
import 'package:cash_in/src/widget/otp_input.dart';
import 'package:flutter/material.dart';

class SecurityCodeScreen extends StatefulWidget {
  final bool login;
  final String? pin;
  final String uid;
  const SecurityCodeScreen(
      {super.key, required this.login, this.pin, required this.uid});

  @override
  State<SecurityCodeScreen> createState() => _SecurityCodeScreenState();
}

class _SecurityCodeScreenState extends State<SecurityCodeScreen> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  String combineFields() {
    return _fieldOne.text +
        _fieldTwo.text +
        _fieldThree.text +
        _fieldFour.text +
        _fieldFive.text;
  }

  bool areFieldsFilled() {
    return _fieldOne.text.isNotEmpty &&
        _fieldTwo.text.isNotEmpty &&
        _fieldThree.text.isNotEmpty &&
        _fieldFour.text.isNotEmpty &&
        _fieldFive.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: height * 0.1),
            Center(
              child: widget.login
                  ? null
                  : const Text(
                      'Buat!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 71, 54, 140),
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
            ),
            const Text(
              'Security Code',
              style: TextStyle(
                color: Color.fromARGB(255, 71, 54, 140),
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(height: height * 0.07),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OtpInput(
                    controller: _fieldOne,
                    colors: Colors.black,
                    autoFocus: true,
                  ),
                  OtpInput(
                    controller: _fieldTwo,
                    colors: Colors.black,
                    autoFocus: false,
                  ),
                  OtpInput(
                    controller: _fieldThree,
                    colors: Colors.black,
                    autoFocus: false,
                  ),
                  OtpInput(
                    controller: _fieldFour,
                    colors: Colors.black,
                    autoFocus: false,
                  ),
                  OtpInput(
                    controller: _fieldFive,
                    colors: Colors.black,
                    autoFocus: false,
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.07),
            const Image(
              image: AssetImage('assets/images/Stuck at Home Secured.png'),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Vector 3.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.08),
                    LanjutkanButton(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      context: context,
                      onCPressed: () async {
                        if (!areFieldsFilled()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please fill in all fields')),
                          );
                          return;
                        }

                        final enteredPin = combineFields();

                        if (widget.login) {
                          // Navigate to HomeScreen for login
                          if (await signInPin(
                              uid: widget.uid, enteredPin: enteredPin)) {
                            Navigator.pushAndRemoveUntil(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                              (route) => false,
                            );
                            print("login berhasil");
                          } else {
                            print("error");
                          }
                        } else if (widget.pin == null) {
                          // Set new PIN
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SecurityCodeScreen(
                                pin: enteredPin,
                                login: false,
                                uid: widget.uid,
                              ),
                            ),
                            (route) => false,
                          );
                        } else {
                          // Verify PIN
                          if (widget.pin == enteredPin) {
                            registerUserPin(pin: widget.pin!, uid: widget.uid);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                              (route) => false,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Incorrect Security Code')),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
