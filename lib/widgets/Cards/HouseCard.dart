import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/fields/field.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/pages/house_menu_page.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/SecondaryButton.dart';
import 'package:notification_app/widgets/Helper/TextHelper.dart';

class HouseCard extends StatelessWidget {
  final Map<String, dynamic> house;
  const HouseCard({Key? key, required this.house}) : super(key: key);

  String parsePrimaryAddress(Map<String, dynamic> house) {
    Map<String, dynamic> rentalAddress = house["lease"]["rentalAddress"];
    String streetNumber = rentalAddress["streetNumber"];
    String streetName = rentalAddress["streetName"];
    return "$streetNumber $streetName";
  }

  String parseSecondaryAddress(Map<String, dynamic> house) {
    Map<String, dynamic> rentalAddress = house["lease"]["rentalAddress"];
    String city = rentalAddress["city"];
    String province = rentalAddress["province"];
    String postalCode = rentalAddress["postalCode"];
    return "$city, $province $postalCode";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Container(
            margin: const EdgeInsets.only(top: 8),
            alignment: Alignment.center,
            child: Text("House Key: ${house["houseKey"]}",
                style: const TextStyle(fontWeight: FontWeight.bold))),
        Expanded(
          child: Image.network(
              "https://storage.googleapis.com/roomr-222721.appspot.com/istockphoto-1323734048-170667a.jpg"),
        ),
        ListTile(
          title: TextHelper(text: parsePrimaryAddress(house)),
          subtitle: TextHelper(text: parseSecondaryAddress(house)),
        ),
        SecondaryButton(Icons.door_back_door, "Enter", (context) {
          print(house["id"]);
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HouseMenuPage(houseId: house["id"],)),
  );

        })
      ]),
    );
  }
}
