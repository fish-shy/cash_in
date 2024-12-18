// LoginScreen.dart
import 'package:cash_in/src/screen/security_code_screen.dart';
import 'package:cash_in/src/screen/register_screen.dart';
import 'package:cash_in/src/settings/login_detail.dart';
import 'package:cash_in/src/widget/lanjutkan_button.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _animateOpacity = false;
  bool _animateWave = false;
  final myControllerEmail = TextEditingController();
  final myControllerPassword = TextEditingController();
  bool passwordVisible = false;
  bool masuk = false;

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

  void login() async {
    String emailOrNohp = myControllerEmail.text;
    String password = myControllerPassword.text;

     if (checkLoginDetails(Email: emailOrNohp, password: password, phoneNumber: emailOrNohp, )) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SecurityCodeScreen(login: true,)),
        (route) => false,
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('error'),
          );
        },
      );
    }

    // String response = await ApiService().login(emailOrNohp, password);

    // if (response == "Login successful") {
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => const HomeScreen()),
    //     (route) => false,
    //   );
    // } else {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         content: Text(response),
    //       );
    //     },
    //   );
    // }

  }

  @override
  void dispose() {
    myControllerEmail.dispose();
    myControllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return masuk ? const RegisterScreen() : _loginScreen(height, width, context);
  }

  Scaffold _loginScreen(double height, double width, BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: height * 0.07),
            AnimatedOpacity(
              opacity: _animateOpacity ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1000),
              child: Image.asset('assets/images/Group 2.png'),
            ),
            SizedBox(height: height * 0.052),
            AnimatedOpacity(
              opacity: _animateOpacity ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1000),
              child: const Text(
                'Masuk',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color.fromARGB(255, 71, 54, 140),
                ),
              ),
            ),
            SizedBox(height: height * 0.025),
            AnimatedOpacity(
              opacity: _animateOpacity ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1000),
              child: _emailTextField(myControllerEmail, 'Email'),
            ),
            SizedBox(height: height * 0.025),
            AnimatedOpacity(
              opacity: _animateOpacity ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1000),
              child: _passwordTextField(),
            ),
            SizedBox(height: height * 0.025),
            AnimatedOpacity(
              opacity: _animateOpacity ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1000),
              child: _daftarButton(context),
            ),
            SizedBox(height: height * 0.15),
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
                        : -MediaQuery.of(context).size.width + 300,
                    child: Container(
                      padding: EdgeInsets.zero,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/WAVE 2.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .12,
                            ),
                            const Text(
                              'Dengan Masuk. Kamu sudah setuju dengan ketentuan\nlayanan dan kebijakan privasi dari Cash-In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                            LanjutkanButton(
                              width: width,
                              height: height,
                              onCPressed: login,
                              context: context,
                            ),
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


  Row _daftarButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Belum Memiliki Akun? ",
          style: textStyle(),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _animateOpacity = false;
              _animateWave = false;
            });
            Future.delayed(const Duration(milliseconds: 1000), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterScreen(),
                ),
              );
            });
          },
          child: const Text(
            'Daftar Disini',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 12,
              color: Color.fromARGB(255, 71, 54, 140),
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Padding _passwordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        controller: myControllerPassword,
        obscureText: !passwordVisible,
        decoration: InputDecoration(
          hintText: "Password",
          labelText: "Password",
          suffixIcon: IconButton(
            icon: Icon(
              passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
      ),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(
      fontSize: 12,
      color: Color.fromARGB(255, 71, 54, 140),
      fontWeight: FontWeight.bold,
    );
  }

  Widget _emailTextField(TextEditingController controller, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          label: Text(text),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
      ),
    );
  }
}
