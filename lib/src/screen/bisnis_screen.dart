import 'package:cash_in/src/screen/home_screen.dart';
import 'package:cash_in/src/widget/bottom_navigation_bar.dart';
import 'package:cash_in/src/widget/gradient_text.dart';
import 'package:cash_in/src/widget/navigation_button_widget.dart';
import 'package:flutter/material.dart';

class BisnisScreen extends StatefulWidget {
  
  const BisnisScreen({super.key});

  @override
  State<BisnisScreen> createState() => _BisnisScreenState();
}

class _BisnisScreenState extends State<BisnisScreen> {
   int _selectedIndex = 0;
  final bool _animateWave = false;
  String uang = '1.000.000';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    
                    Color(0xFF4C378A),
                    Color(0xFF10003E),
                  ],
                ),
              ),
              height: height * 0.28,
            ),
            Column(
              
              children: [
              SizedBox(height: height * 0.06),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 
              ),  
              const NavigationButtonWidget(home: false),
              
              const SizedBox(
                height: 20,
              ),
              _buildProfile(height, width),
              const SizedBox(
                height: 15,
              ),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: width * 0.8,
                    height: 200,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _textLabel('Saldo Bisnis'),
                                _textUang('20.000.000'),
                              ],
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 71, 54, 140),
                                ),
                                child: const Text(
                                  'Tarik Saldo',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 71, 54, 140),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          width: width * 0.85,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _textLabel('Dapat Ditarik'),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    _textUang('20.000.000'),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _textLabel('Dapat Ditarik'),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    _textUang('20.000.000'),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _menuButton(
                                width: width,
                                onTap: () {},
                                icon: Icons.monetization_on,
                                text: 'Minta\nPembayaan '),
                            _menuButton(
                                width: width,
                                onTap: () {},
                                icon: Icons.qr_code_outlined,
                                text: 'QRIS\nBisnis '),
                            _menuButton(
                                width: width,
                                onTap: () {},
                                icon: Icons.store,
                                text: 'Pengaturan')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Riwayat Transaksi',
                      style: TextStyle(
                          color: Color.fromARGB(255, 71, 54, 140),
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    _textLabel('24 transaksi baru')
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Lihat Semua',
                    style: TextStyle(
                        color: Color.fromARGB(255, 71, 54, 140),
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                )
              ],
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10, // Number of items in the list
            itemBuilder: (context, index) {
              return Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: _cardRiwayat(width),
              );
            },
          ),
        )
      ],
    ),
      bottomNavigationBar:BottomNavigationWidget(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped) ,
    );
  }

  Widget _cardRiwayat(double width) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: width * 0.85,
          height: 60,
          decoration: BoxDecoration(  
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.casino),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Terima Pembayaran',
                    style: TextStyle(
                        color: Color.fromARGB(255, 71, 54, 140),
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  _textLabel('dari DANA')
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Rp 500',
                      style: TextStyle(
                          color: Color.fromARGB(255, 71, 54, 140),
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    _textLabel('15 Jul 2023 14:45 WIB')
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _menuButton(
      {required double width,
      required VoidCallback onTap,
      required var icon,
      required String text}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 71, 54, 140),
            ),
            borderRadius: BorderRadius.circular(10)),
        width: width * 0.22,
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color.fromARGB(255, 71, 54, 140),
            ),
            const SizedBox(
              height: 5,
            ),
            _labelBold(text)
          ],
        ),
      ),
    );
  }

  Text _labelBold(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Color.fromARGB(255, 71, 54, 140),
          fontSize: 10,
          fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Text _textLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey),
    );
  }

  Text _textUang(String text) {
    return Text(
      'RP $text',
      style: const TextStyle(
          color: Color.fromARGB(255, 71, 54, 140),
          fontWeight: FontWeight.bold,
          fontSize: 16),
    );
  }
}

Widget _buildProfile(double height, double width) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    elevation: 3,
    color: const Color.fromARGB(255, 71, 54, 140),
    child: Container(
      height: 80,
      width: width * 0.85,
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Placeholdder nama toko ",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Icon(
                    Icons.badge,
                    size: 13,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Hello,",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Expanded(
            child: Icon(
              Icons.qr_code,
              size: 40,
              color: Colors.white,
            ),
          ),
          SizedBox(width: width*0.005,)
        ],
      ),
    ),
  );
}
