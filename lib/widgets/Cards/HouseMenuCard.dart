import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/address.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/widgets/Navigation/navigation.dart';

import '../../business_logic/landlord.dart';
import '../Buttons/IconTextColumn.dart';

class HouseMenuCard extends StatelessWidget {
  final House house;
  final Landlord landlord;
  const HouseMenuCard({
    Key? key,
    required this.house,
    required this.landlord,
  }) : super(key: key);

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
    return Hero(
      tag: house.houseKey,
      child: Card(
             
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
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                         
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
                  ),
            ),
    );
        
  }
}
