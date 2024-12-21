
import 'package:flutter/material.dart';
import 'package:cash_in/src/screen/scan_code.dart';

class BottomNavigationWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavigationWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 60,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.purple),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.attach_money, color: Colors.grey),
                label: 'Finance',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications, color: Colors.grey),
                label: 'Inbox',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.grey),
                label: 'Profile',
              ),
            ],
            currentIndex:
                selectedIndex > 1 ? selectedIndex + 1 : selectedIndex,
            selectedItemColor: Colors.purple,
            onTap: (index) {
              if (index == 2) return;
              onItemTapped(index > 1 ? index - 1 : index);
            },
          ),
        ),
        Positioned(
          bottom: 15,
          left: width / 2 - 40,
          child: GestureDetector(
            onTap: () {
              onItemTapped(2);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScanCode()),
              );
            },
            child: const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.orange,
              child: Text(
                'QRIS',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
