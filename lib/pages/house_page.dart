import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/landlord.dart';

import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/widgets/Navigation/navigation.dart';
import 'package:notification_app/widgets/Cards/HouseCard.dart';
import 'package:notification_app/widgets/Listviews/CardSliverListView.dart';

import '../graphql/query_helper.dart';
import '../widgets/Navigation/bottom_nav_bar.dart';
import '../widgets/buttons/CallToActionButton.dart';

class HousesPage extends StatefulWidget {
  final Landlord landlord;
  const HousesPage({
    Key? key,
    required this.landlord,
  }) : super(key: key);

  @override
  State<HousesPage> createState() => _HousesPageState();
}

class _HousesPageState extends State<HousesPage>  {
  

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GQLClient().getClient(),
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ),
                bottomNavigationBar: BottomNavBar(landlord: widget.landlord),
                body: QueryHelper(
                    isList: true,
                    queryName: 'getHouses',
                    variables: {"id": widget.landlord.id},
                    onComplete: (json) {
                      List<House> houses = json
                          .map<House>((json) => House.fromJson(json))
                          .toList();
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(4),
                              child: CardSliverListView(
                                noItemsText: "No Properties",
                                shrinkWrap: true,
                                controller: ScrollController(),
                                builder: (context, index) {
                                  House house = houses[index];
                                  return HouseCard(
                                    landlord: widget.landlord,
                                    house: house,
                                    onHouse: (House house, Landlord landlord) {
                                      Navigation().navigateToHouseMenuPage(
                                          context, house, landlord);
                                    },
                                  );
                                },
                                items: houses,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: CallToActionButton(
                                  text: "Add Property",
                                  onClick: () {
                                    Navigation().navigateToAddHousePage(
                                        context, widget.landlord);
                                  }),
                            )
                          ],
                        ),
                      );
                    }))));
  }
}
