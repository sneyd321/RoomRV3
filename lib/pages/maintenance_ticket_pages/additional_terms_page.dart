
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../business_logic/house.dart';
import '../../business_logic/landlord.dart';
import '../../business_logic/list_items/additional_term.dart';
import '../../graphql/query_helper.dart';
import '../../graphql/graphql_client.dart';
import '../../widgets/Cards/AdditionalTermCardReadOnly.dart';
import '../../widgets/Listviews/CardSliverListView.dart';

class AdditionalTermsPage extends StatefulWidget {
  final String houseKey;
  final String firebaseId;
  final Landlord landlord;
  const AdditionalTermsPage(
      {Key? key,
      required this.houseKey,
      required this.firebaseId,
      required this.landlord})
      : super(key: key);

  @override
  State<AdditionalTermsPage> createState() => _AdditionalTermsPageState();
}

class _AdditionalTermsPageState extends State<AdditionalTermsPage> {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GQLClient().getClient(),
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(),
                body: QueryHelper(
                  isList: true,
                    queryName: "getHouse",
                    variables: {
                      "houseKey": widget.houseKey,
                    },
                    onComplete: (json) {
                      House house = House.fromJson(json);
                      return CardSliverListView(
                          items: house.lease.additionalTerms,
                          builder: (context, index) {
                            AdditionalTerm additionalTerm =
                                house.lease.additionalTerms[index];
                            return AdditionalTermCardReadOnly(
                                landlord: widget.landlord,
                                firebaseId: widget.firebaseId,
                                additionalTerm: additionalTerm);
                          },
                          controller: ScrollController());
                    }))));
  }
}
