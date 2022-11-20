
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/pages/house_page.dart';

import '../business_logic/house.dart';
import '../business_logic/landlord.dart';
import '../services/graphql_client.dart';
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
  int index = 1;


  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body:  QueryHelper(
            isList: true,
               queryName: 'getHouses', 
               variables: {"id": widget.landlord.id},
               onComplete: (json) {
                 List<House> houses = json.map<House>((json) => House.fromJson(json)).toList();
                 switch (index) {
                  case 0:
                    return NotificationPage(houses: houses, landlord: widget.landlord,);
                  case 1:
                    return HousesPage(houses: houses, landlord: widget.landlord,);
                  default:
                    return HousesPage(houses: houses, landlord: widget.landlord,);
                }
               },
               ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_sharp),
                label: 'Notification Feed',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Houses',
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
