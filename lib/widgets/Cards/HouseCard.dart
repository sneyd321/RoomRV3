import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/address.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/pages/house_menu_page.dart';

import '../../graphql/mutation_helper.dart';

class HouseCard extends StatelessWidget {
  final House house;
  final void Function(String houseKey) onDeleteHouse;
  const HouseCard({Key? key, required this.house, required this.onDeleteHouse})
      : super(key: key);

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
    return MutationHelper(
        onComplete: (json) {
          onDeleteHouse(json["houseKey"]);
        },
        mutationName: 'deleteHouse',
        builder: (runMutation) {
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                runMutation({"houseId": house.houseId});
                              },
                              icon: const Icon(Icons.close))
                        ],
                      ),
                      Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: const Image(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/house.jpg")),
                      ),
                      Container(
                          margin:
                              const EdgeInsets.only(top: 8, bottom: 8, left: 8),
                          child: Row(
                            children: [
                              const Text("House Key: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
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
                      )
                    ])),
          );
        });
  }
}
