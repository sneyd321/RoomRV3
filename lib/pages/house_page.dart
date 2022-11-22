import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/landlord.dart';

import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/widgets/Cards/HouseCard.dart';
import 'package:notification_app/widgets/Listviews/CardSliverGridView.dart';

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
              floatingActionButton: Container(
                height: 60,
                margin: const EdgeInsets.only(bottom: 16),
                child: FloatingActionButton.extended(
                  icon: const Icon(Icons.add),
                  label: const Text("Create House"),
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
                ),
              ),
              body: widget.houses.isNotEmpty
                  ? CardSliverGridView(
                      childAspectRatio: (MediaQuery.of(context).size.width * 0.65) / MediaQuery.of(context).size.height * 2,
                      builder: (context, index) {
                        House house = widget.houses[index];
                        return HouseCard(house: house, onDeleteHouse: (String houseKey) {  
                          House house = widget.houses.where((element) => element.houseKey == houseKey).first;
                          setState(() {
                            widget.houses.remove(house);
                          });
                        
                        },);
                      },
                      items: widget.houses,
                    )
                  : const Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        title: Text("No Houses"),
                      ),
                    ))),
    );
  }
}
