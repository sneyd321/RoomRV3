import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
       
                icon: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.home, color: Colors.black,),
                ),
                label: 'Properties',
              ),
              BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.account_circle, color: Colors.black,),
                  ),
                  label: "Account"),
            ],
            currentIndex: _selectedIndex,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
          );
  }
}