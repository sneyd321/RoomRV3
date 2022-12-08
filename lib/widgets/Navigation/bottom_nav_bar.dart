
import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/landlord.dart';

import 'navigation.dart';


class BottomNavBar extends StatefulWidget {
  final Landlord landlord;
  const BottomNavBar({Key? key, required this.landlord}) : super(key: key);


  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          Navigation().navigateToHousesPage(context, widget.landlord);
          break;
        case 1:
        Navigation().navigateToProfilePage(context, widget.landlord);
          break;
        default:
        Navigation().navigateToHousesPage(context, widget.landlord);
          break;
      }
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