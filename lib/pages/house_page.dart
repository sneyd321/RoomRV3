import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/pages/select_document_type_page.dart';

import 'package:notification_app/services/graphql_client.dart';
import 'package:notification_app/widgets/Cards/HouseCard.dart';
import 'package:notification_app/widgets/Listviews/CardSliverGridView.dart';

import 'add_lease_view_pager.dart';

class HousesPage extends StatefulWidget {
  final List<House> houses;
  const HousesPage({
    Key? key,
    required this.houses,
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
                  label: const Text("Create Document"),
                  onPressed: () async {
                    final value = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectDocumentTypePage(),
                      ),
                    );
                    setState(() {});
                  },
                ),
              ),
              body: CardSliverGridView(
                heightRatio: .5,
                widthRatio: 4,
                builder: (context, index) {
                  House house = widget.houses[index];
                  return HouseCard(house: house);
                },
                items: widget.houses,
              ))),
    );
  }
}
