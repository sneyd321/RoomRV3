import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/business_logic/login_landlord.dart';
import 'package:notification_app/pages/edit_lease_view_pager.dart';
import 'package:notification_app/pages/edit_profile_page.dart';
import 'package:notification_app/pages/house_page.dart';
import 'package:notification_app/pages/profile_page.dart';
import 'package:notification_app/pages/sign_up_page.dart';

import '../../pages/add_lease_view_pager.dart';
import '../../pages/house_menu_page.dart';
import '../../pages/notification_page.dart';

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

  void navigateToProfilePage(BuildContext context, Landlord landlord) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfilePage(
                landlord: landlord,
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

  Future<bool?> navigateToHousesPage(BuildContext context, Landlord landlord) async {
    return await Navigator.push<bool>(
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

  Future<Landlord?> navigateToEditProfilePage(BuildContext context, Landlord landlord) async {
    return await Navigator.push<Landlord>(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
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


  Future<LoginLandlord?> navigateToSignUpPage(BuildContext context) async {
    return await Navigator.push<LoginLandlord>(
      context,
      MaterialPageRoute(
          builder: (context) => const SignUpPage()),
    );
  }
}