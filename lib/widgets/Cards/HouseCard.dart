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
    print(city.length);
    String province = rentalAddress.province;
    String postalCode = rentalAddress.postalCode;
    return "$city, $province $postalCode";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HouseMenuPage(
                    house: house,
                  )),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Image(
            fit: BoxFit.fill,
            image: AssetImage("assets/house.jpg")),
          Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
              child: Row(
                children: [
                  const Text("House Key: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(house.houseKey,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue))
                ],
              )),
          Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(parsePrimaryAddress(house),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Text(parseSecondaryAddress(house)),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
