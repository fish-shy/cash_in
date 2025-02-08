
import 'package:cash_in/src/screen/authentication_screen.dart';
import 'package:cash_in/src/screen/login_screen.dart';
import 'package:cash_in/src/services/auth.dart';
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
  
  final AuthService _auth = AuthService();
  bool passwordVisible = false;
  bool _animateOpacity = false;
  bool _animateWave = false;

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

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
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _animateOpacity = true;
        _animateWave = true;
      });
    });
  }

  void register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      String email = myControllerEmail.text;
      String phoneNumber = myControllerPhoneNumber.text;  
      String name = myControllerFullName.text;
      String password = myControllerPassword.text;

      dynamic result = await _auth.registerWithEmailAndPassword(email: email,password:  password,name:  name ,phoneNumber:  phoneNumber);
      if (result !=null) {
        Navigator.pushAndRemoveUntil(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) =>  AuthenticationScreen(uid: result.uid)),
          (route) => false,
        );
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Register Failed'),
                content:
                    const Text('Welcome! You have successfully gave an error.'),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: AnimatedOpacity(
          opacity: _animateOpacity ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 1000),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: AnimatedOpacity(
                          opacity: _animateOpacity ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 1000),
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 71, 54, 140)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.question_mark,
                                color: Color.fromARGB(255, 71, 54, 140),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  AnimatedOpacity(
                    opacity: _animateOpacity ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 1000),
                    child: Image.asset('assets/images/Group 2.png'),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  AnimatedOpacity(
                    opacity: _animateOpacity ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 1000),
                    child: const Text(
                      'Buat Akun?',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 71, 54, 140),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: AnimatedOpacity(
                      opacity: _animateOpacity ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 1000),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.025,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                                controller: myControllerFullName,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nama is required';
                                  }
                                  return null;
                                },
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: IntlPhoneField(
                              validator: (value) {
                                if (value == null) {
                                  return 'Email is required';
                                }
                                return null;
                              },
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required';
                                  }
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              controller: myControllerPassword,
                              obscureText: passwordVisible,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
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
                  ),
                  SizedBox(
                    height: height * 0.01,
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
                          bottom: _animateWave
                              ? 0
                              : -MediaQuery.of(context).size.width,
                          child: Container(
                            padding: EdgeInsets.zero,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/WAVE.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Center(
                              child: AnimatedOpacity(
                                opacity: _animateOpacity ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 1000),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Sudah punya akun? ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11),
                                        ),
                                        GestureDetector(
                                          onTap: () => {
                                            setState(() {
                                              _animateOpacity = false;
                                              _animateWave = false;
                                            }),
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 1000), () {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginScreen()),
                                                  (route) => false);
                                            })
                                          },
                                          child: const Text(
                                            'Masuk',
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.001),
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
