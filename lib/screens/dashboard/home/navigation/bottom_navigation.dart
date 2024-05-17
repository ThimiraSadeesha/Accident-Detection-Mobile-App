import 'package:flutter/material.dart';

import '../home_screen.dart';
import '../insurance_screen.dart';
import '../map_screen.dart';
import '../profile_screen.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: const <Widget>[
          HomeScreen(),
          MapScreen(),
          InsuranceScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            pageController.jumpToPage(index);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.white,),
            backgroundColor: Colors.red,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            backgroundColor: Colors.red,
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_emergency),
            backgroundColor: Colors.red,
            label: 'Insurance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            backgroundColor: Colors.red,
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
