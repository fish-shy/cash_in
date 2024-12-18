import 'package:cash_in/src/screen/authentication_screen.dart';
import 'package:cash_in/src/screen/login_screen.dart';
import 'package:cash_in/src/settings/login_detail.dart';
import 'package:cash_in/src/widget/lanjutkan_button.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  final myControllerFullName = TextEditingController();
  final myControllerPassword = TextEditingController();
  final myControllerEmail = TextEditingController();
  final myControllerPhoneNumber = TextEditingController();

  bool passwordVisible = false;
  bool _animateOpacity = false;
  bool _animateWave = false;

  void register() async {
    String email = myControllerEmail.text;
    String nohp = myControllerPhoneNumber.text;
    String nama = myControllerFullName.text;
    String password = myControllerPassword.text;
     if (addLoginDetail(Email: email, password: password, phoneNumber: nohp,nama: nama)) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AuthenticationScreen()),
        (route) => false,
      );
                        
    } else {
       showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Register Failed'),
              content: const Text('Welcome! You have successfully gave an error.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
    }


   // String response = await ApiService().register(email, nohp, nama, password);
    // if (response == 'User registered successfully') {
    //  showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: const Text('Register Succesfull'),
    //           content: const Text('Welcome! You have successfully Register.'),
    //           actions: [
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.pushAndRemoveUntil(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) => const LoginScreen()),
    //                     (route) => false);
                        
    //                 Navigator.of(context).pop();
    //               },
    //               child: const Text('OK'),
    //             ),
    //           ],
    //         );
    //       });
    // } else {
    //    showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: const Text('Register Failed'),
    //           content: const Text('Welcome! You have successfully Register.'),
    //           actions: [
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               child: const Text('OK'),
    //             ),
    //           ],
    //         );
    //       });
    //}
  }

  @override
  void dispose() {
    myControllerFullName.dispose();
    myControllerPassword.dispose();
    myControllerEmail.dispose();
    myControllerPhoneNumber.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animateOpacity = true;
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _animateOpacity = true;
        _animateWave = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 71, 54, 140)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100))),
                    child: const Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.question_mark,
                        color: Color.fromARGB(255, 71, 54, 140),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Image.asset('assets/images/Group 2.png'),
            SizedBox(
              height: height * 0.025,
            ),
            const Text(
              'Buat Akun?',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 71, 54, 140),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                        controller: myControllerFullName,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          label: const Text('Nama'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: IntlPhoneField(
                      controller: myControllerPhoneNumber,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: const Text('Nomorhp'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                      initialCountryCode: 'ID',
                    ),
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                        controller: myControllerEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: const Text('Email'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: myControllerPassword,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        hintText: "Password",
                        label: const Text('Password'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(
                              () {
                                passwordVisible = !passwordVisible;
                              },
                            );
                          },
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Expanded(
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeInOut,
                    right: _animateWave
                        ? 0
                        : -MediaQuery.of(context).size.width - 600,
                    left: 0,
                    top: 0,
                    bottom:
                        _animateWave ? 0 : -MediaQuery.of(context).size.width,
                    child: Container(
                      padding: EdgeInsets.zero,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/WAVE.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Sudah punya akun? ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()),
                                        (route) => false)
                                  },
                                  child: const Text(
                                    'Masuk',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.001),
                            LanjutkanButton(
                                width: width,
                                height: height,
                                context: context,
                                onCPressed: register)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
