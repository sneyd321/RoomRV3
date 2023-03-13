import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


import '../../graphql/mutation_helper.dart';

class HouseCard extends StatelessWidget {
  final House house;
  final Landlord landlord;
  final double height;
  final void Function(House house, Landlord landlord) onHouse;
  const HouseCard({Key? key, required this.house, required this.landlord, required this.onHouse, this.height = 200})
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
          
        },
        mutationName: 'deleteHouse',
        builder: (runMutation) {
          return GestureDetector(
            onTap: () {
              onHouse(house, landlord);
            },
            child: Hero(
              tag: house.houseKey,
              child: Card(
                margin: const EdgeInsets.all(4),
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/house.jpg"),
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        height: height,
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            const Spacer(),
                            Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  "House Key: ${house.houseKey}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )),
                            Text(
                              parsePrimaryAddress(house),
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              parseSecondaryAddress(house),
                              style: const TextStyle(color: Colors.white),
                            ),
                            
                          ],
                        ),
                      ),
                    ),

                  )),
            ),
          );
        });
  }
}


