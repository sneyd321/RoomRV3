import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/landlord.dart';

import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/widgets/Cards/HouseCard.dart';
import 'package:notification_app/widgets/Listviews/CardSliverListView.dart';

import 'add_lease_view_pager.dart';

class HousesPage extends StatefulWidget {
  final List<House> houses;
  final Landlord landlord;
  const HousesPage({
    Key? key,
    required this.houses,
    required this.landlord,
  }) : super(key: key);

  @override
  State<HousesPage> createState() => _HousesPageState();
}

class _HousesPageState extends State<HousesPage> {
  final GlobalKey<FormState> rentFormKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: SafeArea(
          child: Scaffold(
              body: widget.houses.isNotEmpty
                  ? 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(4),
                            child: CardSliverListView(
                              shrinkWrap: true,
                              controller: ScrollController(),
                              builder: (context, index) {
                                House house = widget.houses[index];
                                return HouseCard(
                                  landlord: widget.landlord,
                                  house: house,
                                  onDeleteHouse: (String houseKey) {
                                    House house = widget.houses
                                        .where((element) =>
                                            element.houseKey == houseKey)
                                        .first;
                                    setState(() {
                                      widget.houses.remove(house);
                                    });
                                  },
                                );
                              },
                              items: widget.houses,
                            ),
                          ),
                        
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: ElevatedButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.all(25)),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.black),
                                      shape:
                                          MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  side: const BorderSide(
                                                      color: Colors.black)))),
                                  onPressed: () async {
                                    House? house = await Navigator.push<House>(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddLeaseViewPager(
                                          landlord: widget.landlord,
                                        ),
                                      ),
                                    );
                                    if (house == null) {
                                      return;
                                    }
                                    widget.houses.add(house);
                            
                                    setState(() {});
                                  },
                                  child: const Text(
                                    "Add Property",
                                    style: TextStyle(fontSize: 16),
                                  )),
                          ),
                          
                        ],
                   
                    )
                  : const Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        title: Text("No Properties"),
                      ),
                    ))),
    );
  }
}
