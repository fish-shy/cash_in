import 'package:cash_in/src/screen/map_screen.dart';
import 'package:cash_in/src/settings/payment_logo.dart';
import 'package:cash_in/src/widget/bottom_navigation_bar.dart';
import 'package:cash_in/src/widget/navigation_button_widget.dart';

import 'package:cash_in/src/widget/pay_button_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _animateWave = false;
  String uang = '1.000.000';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _animateWave = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFF10003E),
              Color(0xFF4C378A),
            ],
          ),
        ),
        height: height,
        child: Column(
          children: [
            SizedBox(height: height * 0.06),
            const NavigationButtonWidget(
              home: true,
            ),
            const SizedBox(height: 24),
            _buildCard(height, width),
            SizedBox(height: height * 0.03),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.02),
                    _buildMenuRow(width),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return index == 3
                              ? tambahPayButton(() {})
                              : payButton(
                                  onPressed: () {},
                                  link: paymentMethods['payment'][index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }

  Widget _buildCard(double height, double width) {
    return Card(
      elevation: 3,
      color: const Color.fromARGB(255, 71, 54, 140),
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFA770EF),
              Color(0xFFF992F1),
              Color(0xFFFF926E),
            ],
            stops: [0.0, 0.52, 1.0],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(40)),
              width: 40,
              height: 40,
              child: const Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 2),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello,",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Customer",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(width: width * 0.1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Balance",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  "RP $uang",
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMenuRow(double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _menuButton(
          width: width,
          color1: const Color(0xFFFFF9C1),
          color2: const Color(0xFFFFA587),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapScreen()),
            );
          },
          text: 'Tempat\nPenukaran',
          assets: Image.asset('assets/images/Group 2.png'),
        ),
        _menuButton(
          width: width,
          color1: const Color(0xFF68C5FF),
          color2: const Color(0xFF4F31A5),
          text: 'Riwayat\nHPenukran',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
          assets: const Icon(
            Icons.history,
            color: Colors.white,
            size: 55,
          ),
        ),
        _menuButton(
          width: width,
          color1: const Color(0xFFFFC1F5),
          color2: const Color(0xFF412889),
          text: 'Tambah\nE-Wallet',
          onTap: () {},
          assets: const Icon(
            Icons.account_balance_wallet,
            color: Colors.white,
            size: 55,
          ),
        ),
      ],
    );
  }

  Widget _menuButton({
    required double width,
    required Color color1,
    required Color color2,
    required String text,
    required Widget assets,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: width * 0.19,
            height: width * 0.19,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color1, color2],
                stops: const [0.0, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(child: assets),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: textStyle(),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  TextStyle textStyle() {
    return const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
  }
}
