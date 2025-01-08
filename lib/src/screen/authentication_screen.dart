import 'package:cash_in/src/screen/security_code_screen.dart';
import 'package:cash_in/src/widget/lanjutkan_button.dart';
import 'package:cash_in/src/widget/otp_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AuthenticationScreen extends StatefulWidget {
  String uid;
   AuthenticationScreen({super.key, required this.uid});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _showNotification(
      'OTP Code',
      'Your OTP code is 12345. Use this code to complete verification.',
    );
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'otp_channel',
      'OTP Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  void _onSubmit() {
    const String correctOtp = "12345";
    String userInput = _fieldOne.text +
        _fieldTwo.text +
        _fieldThree.text +
        _fieldFour.text +
        _fieldFive.text;

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => SecurityCodeScreen(
                  login: false, uid: widget.uid,
                )),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Center(
              child: Image(
                image: AssetImage('assets/images/Group 2.png'),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Kode OTP?',
                style: TextStyle(
                  color: Color.fromARGB(255, 71, 54, 140),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
            Image.asset(
              'assets/images/Moneyverse Business Balance.png',
              width: width * 0.5,
              height: height * 0.2,
            ),
            SizedBox(height: height * 0.05),
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
                  children: [
                    SizedBox(height: height * 0.1),
                    const Text(
                      'Masukkan OTP yang dikirim\nvia WhatsApp ke: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * 0.03),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OtpInput(
                            controller: _fieldOne,
                            colors: Colors.white,
                            autoFocus: true,
                          ),
                          OtpInput(
                            controller: _fieldTwo,
                            colors: Colors.white,
                            autoFocus: false,
                          ),
                          OtpInput(
                            controller: _fieldThree,
                            colors: Colors.white,
                            autoFocus: true,
                          ),
                          OtpInput(
                            controller: _fieldFour,
                            colors: Colors.white,
                            autoFocus: false,
                          ),
                          OtpInput(
                            controller: _fieldFive,
                            colors: Colors.white,
                            autoFocus: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    const Text(
                      'Ada masalah dengan kode OTP?\nsilahkan ulangi setelah 60 detik',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * 0.02),
                    LanjutkanButton(
                      width: width,
                      height: height,
                      context: context,
                      onCPressed: _onSubmit,
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
