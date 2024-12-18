import 'package:flutter/material.dart';
import 'package:cash_in/src/screen/store_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TextEditingController myController = TextEditingController();
  int? selectedIndex;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: myController,
                          decoration: const InputDecoration(
                            labelText: "Cari Tempat Penukaran Uang",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return _minButton(
                          text: "Item $index",
                          isSelected: selectedIndex == index,
                          onPressed: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.1,
              maxChildSize: 0.8,
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return _storeButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const StoreScreen()));
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _minButton({required String text, required bool isSelected, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: isSelected ? Colors.blue : Colors.white,
        margin: const EdgeInsets.all(10),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}

Widget _storeButton({required VoidCallback onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.grey[200],
              ),
              child: const Center(
                child: Text(
                  "Img",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "nama warung",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 16),
                      SizedBox(width: 4),
                      Text("4.7 (6)"),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    "591m",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}