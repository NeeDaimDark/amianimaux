import 'package:flutter/material.dart';
import '../race/racehome.dart';

class NavBottom extends StatefulWidget {
  final String userId; // Define userId here

  const NavBottom({Key? key, required this.userId}) : super(key: key);

  @override
  State<NavBottom> createState() => _NavBottomState();
}

class _NavBottomState extends State<NavBottom> {
  int _currentIndex = 0;
  late List<Widget> _interfaces;

  @override
  void initState() {
    super.initState();
    _interfaces = [Rhome(userId: widget.userId)]; // Initialize with userId from widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AmiNimaux"),
          backgroundColor: Colors.green
      ),
      drawer: Drawer(
        // ... drawer content
      ),
      body: _interfaces[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Store",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: "Bibiliothèque",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: "Panier",
          )
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
