// LoginScreen.dart
import 'package:cash_in/src/screen/security_code_screen.dart';
import 'package:cash_in/src/screen/register_screen.dart';
import 'package:cash_in/src/services/auth.dart';
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

  final AuthService _auth = AuthService();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  dynamic result;
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
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      String emailOrPhone = myControllerEmail.text;
      String password = myControllerPassword.text;
      dynamic result;

      // First, attempt to sign in assuming it's an email
      try {
        result = await _auth.signInWithEmailAndPassword(emailOrPhone, password);
        if (result != null) {
          // Navigate to SecurityCodeScreen if email login is successful
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SecurityCodeScreen(login: true, uid: result.uid,),
            ),
            (route) => false,
          );
          return; // Exit the function as login was successful
        }
      } catch (e) {
        // Catch email login errors and continue to try phone login
        print("Email login failed: ${e.toString()}");
      }

      // If email login fails, try phone number-based login
      try {
        result = await _auth.signInWithPhoneNumberAndPassword(
            emailOrPhone, password);
        if (result != null) {
          // Navigate to SecurityCodeScreen if phone login is successful
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>  SecurityCodeScreen(login: true,uid: result.uid,),
            ),
            (route) => false,
          );
          return; // Exit the function as login was successful
        }
      } catch (e) {
        // Catch phone login errors
        print("Phone login failed: ${e.toString()}");
      }

      // If both login attempts fail

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Login failed. Please check your credentials.')),
      );
    }
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
    return masuk
        ? const RegisterScreen()
        : _loginScreen(height, width, context);
  }

  Scaffold _loginScreen(double height, double width, BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _formKey,
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
                  child: _emailOrPhoneTextField(
                    myControllerEmail,
                  ),
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
                                  height:
                                      MediaQuery.of(context).size.height * .12,
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
      child: TextFormField(
        controller: myControllerPassword,
        obscureText: !passwordVisible,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is required';
          }
       
          return null;
        },
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

  Widget _emailOrPhoneTextField(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email or phone number is required';
          }
          return null;
        
        },
        decoration: InputDecoration(
          labelText: 'Email or Phone Number',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
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
}
