
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/pages/house_page.dart';

import '../business_logic/house.dart';
import '../business_logic/landlord.dart';
import '../services/graphql_client.dart';
import '../widgets/Queries/query_helper.dart';
import 'notification_page.dart';


class LandlordViewPager extends StatefulWidget {
  final Landlord landlord;
  const LandlordViewPager({Key? key, required this.landlord}) : super(key: key);

  @override
  State<LandlordViewPager> createState() => _LandlordViewPagerState();
}

class _LandlordViewPagerState extends State<LandlordViewPager> {
  final PageController controller = PageController();
  int index = 1;
  late Widget body;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body:  QueryHelper(
              onComplete: (result, {fetchMore, refetch}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }
                if (result.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<House> houses = result.data!["getHouses"].map<House>((json) => House.fromJson(json)).toList();
                switch (index) {
                  case 0:
                    return NotificationPage(house: houses[0], landlord: widget.landlord,);
                  case 1:
                    return HousesPage(houses: houses,);
                  default:
                    return HousesPage(houses: houses,);
                }
              }, queryName: 'getHouses', variables: {"id": 4},),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_sharp),
                label: 'Notification Feed',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                label: 'Documents',
              ),
            ],
            currentIndex: index,
            selectedItemColor: Colors.blue,
            onTap: (index) {
              setState(() {
                this.index = index;
                
              });
            },
          ),
        ),
      ),
    );
  }
}
