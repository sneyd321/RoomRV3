import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/pages/house_page.dart';

import '../business_logic/house.dart';
import '../business_logic/landlord.dart';
import '../graphql/graphql_client.dart';
import '../graphql/query_helper.dart';
import 'notification_page.dart';

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
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.exit_to_app_sharp),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.notifications),
                    text: "Notification Feed",
                  ),
                  Tab(
                    icon: Icon(Icons.home),
                    text: "Houses",
                  ),
                ],
              ),
            ),
            body: QueryHelper(
              isList: true,
              queryName: 'getHouses',
              variables: {"id": widget.landlord.id},
              onComplete: (json) {
                if (json.length != houses.length) {
                  houses =
                      json.map<House>((json) => House.fromJson(json)).toList();
                }
                return TabBarView(
                  children: [
                    NotificationPage(
                      houses: houses,
                      landlord: widget.landlord,
                    ),
                    HousesPage(
                      houses: houses,
                      landlord: widget.landlord,
                    )
                  ],
                );
              },
            ),
            
  
          ),
        ),
      ),
    );
  }
}
