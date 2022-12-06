import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/pages/edit_lease_view_pager.dart';
import 'package:notification_app/pages/house_page.dart';
import 'package:notification_app/pages/sign_up_page.dart';

import 'add_lease_view_pager.dart';
import 'house_menu_page.dart';
import 'notification_page.dart';

class Navigation {
  void navigateToEditLeasePage(BuildContext context, House house) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditLeaseStatePager(
                house: house,
              )),
    );
  }

  void navigateToNotificationsPage(
      BuildContext context, House house, Landlord landlord) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NotificationPage(
                house: house,
                landlord: landlord,
              )),
    );
  }

  void navigateToHousesPage(BuildContext context, Landlord landlord) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HousesPage(landlord: landlord)));
  }

  void navigateToAddHousePage(BuildContext context, Landlord landlord) {
    Navigator.push<House>(
      context,
      MaterialPageRoute(
        builder: (context) => AddLeaseViewPager(
          landlord: landlord,
        ),
      ),
    );
  }

  void navigateToHouseMenuPage(
      BuildContext context, House house, Landlord landlord) {
        Navigator.of(context).push(PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HouseMenuPage(house: house, landlord: landlord,),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
   

      final tween = Tween(begin: 0, end: 1);
      final offsetAnimation = animation.drive(tween);
      return child;
    },)
  );
  
  }


  void navigateToSignUpPage(BuildContext context) {
     Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const SignUpPage()),
    );
  }
}
