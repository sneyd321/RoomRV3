import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/Navigation/navigation.dart';
import 'package:notification_app/buttons/CallToActionButton.dart';

import 'package:notification_app/graphql/graphql_client.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../graphql/query_helper.dart';

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
                  actions: [
                    IconButton(
                    icon: const Icon(Icons.account_circle),
                    onPressed: () => Navigation().navigateToProfilePage(context, widget.landlord),
                  ),
                  ],
                  leading: IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ),
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
