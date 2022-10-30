import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/address.dart';
import 'package:notification_app/business_logic/fields/field.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/pages/house_menu_page.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Helper/TextHelper.dart';

class HouseCard extends StatelessWidget {
  final House house;
  const HouseCard({Key? key, required this.house}) : super(key: key);

  String parsePrimaryAddress(House house) {
    RentalAddress rentalAddress = house.lease.rentalAddress;
    String streetNumber = rentalAddress.streetNumber;
    String streetName = rentalAddress.streetName;
    return "$streetNumber $streetName";
  }

  String parseSecondaryAddress(House house) {
    RentalAddress rentalAddress = house.lease.rentalAddress;
    String city = rentalAddress.city;
    String province = rentalAddress.province;
    String postalCode = rentalAddress.postalCode;
    return "$city, $province $postalCode";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: const EdgeInsets.only(top: 8),
                alignment: Alignment.center,
                child: Text("House Key: ${house.houseKey}",
                    style: const TextStyle(fontWeight: FontWeight.bold))),
            Image(image: AssetImage("assets/house.jpg")),
            ListTile(
              title: TextHelper(text: parsePrimaryAddress(house)),
              subtitle: TextHelper(text: parseSecondaryAddress(house)),
            ),
            SecondaryButton(Icons.door_back_door, "Enter", (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HouseMenuPage(
                          house: house,
                        )),
              );
            })
          ]),
    );
  }
}
