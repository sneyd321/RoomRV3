import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/pages/house_page.dart';
import 'package:notification_app/widgets/Navigation/bottom_nav_bar.dart';

import '../business_logic/house.dart';
import '../business_logic/landlord.dart';
import '../graphql/graphql_client.dart';
import '../graphql/query_helper.dart';

class LandlordViewPager extends StatefulWidget {
  final Landlord landlord;
  const LandlordViewPager({Key? key, required this.landlord}) : super(key: key);

  @override
  State<LandlordViewPager> createState() => _LandlordViewPagerState();
}

class _LandlordViewPagerState extends State<LandlordViewPager> {
  final PageController controller = PageController();
  List<House> houses = [];
  

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          bottomNavigationBar: const BottomNavBar(),
          body: QueryHelper(
            isList: true,
            queryName: 'getHouses',
            variables: {"id": widget.landlord.id},
            onComplete: (json) {
              if (json.length != houses.length) {
                houses =
                    json.map<House>((json) => House.fromJson(json)).toList();
              }
              return HousesPage(
                houses: houses,
                landlord: widget.landlord,
              );
            },
          ),
        ),
      ),
    );
  }
}
