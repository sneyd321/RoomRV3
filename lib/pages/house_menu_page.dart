import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/main.dart';
import 'package:notification_app/services/FirebaseConfig.dart';
import 'package:notification_app/widgets/buttons/TenantRow.dart';
import 'package:notification_app/widgets/Cards/HouseMenuCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNotificationForm.dart';
import 'package:notification_app/widgets/Helper/BottomSheetHelper.dart';
import 'package:notification_app/widgets/builders/notifications_limit.dart';

import '../business_logic/address.dart';
import '../graphql/graphql_client.dart';
import '../widgets/Navigation/navigation.dart';

class HouseMenuPage extends StatefulWidget {
  final House house;
  final Landlord landlord;
  const HouseMenuPage({Key? key, required this.house, required this.landlord})
      : super(key: key);

  @override
  State<HouseMenuPage> createState() => _HouseMenuPageState();
}

class _HouseMenuPageState extends State<HouseMenuPage> {
  List<Widget> tenantWidgets = [];
  final List<String> items = const ["Edit Lease", "Purchase Apps"];
  final ScrollController scrollController = ScrollController();

  String parsePrimaryAddress(House house) {
    RentalAddress rentalAddress = house.lease.rentalAddress;
    String streetNumber = rentalAddress.streetNumber;
    String streetName = rentalAddress.streetName;
    return "$streetNumber $streetName";
  }

  String parseSecondaryAddress(House house) {
    RentalAddress rentalAddress = house.lease.rentalAddress;
    String city = rentalAddress.city;
    String province = rentalAddress.province;
    String postalCode = rentalAddress.postalCode;
    return "$city, $province $postalCode";
  }

  Widget leftPanel() {
    return Column(
      children: [
        Expanded(
          child: NotificationLimit(
            house: widget.house,
            landlord: widget.landlord,
            onSearchFocus: () {
              scrollController.animateTo(
                0,
                duration: Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
              );
            },
          ),
        ),
        Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            alignment: Alignment.topRight,
            child: FloatingActionButton.extended(
              onPressed: () {
                BottomSheetHelper(AddNotificationForm(
                    names: const ["24 Hours Notice"],
                    onSave: ((context, title, body) {
                      FirebaseConfiguration().setCustomNotification(
                          widget.house, widget.landlord, title, body);
                      setState(() {});
                    }))).show(context);
              },
              label: const Text("Compose Notification"),
              icon: const Icon(Icons.draw),
            ))
      ],
    );
  }

  Widget rightPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TenantRow(house: widget.house),
        Container(
            margin: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: const Text(
              "My Apps",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )),
        Container(
          margin: const EdgeInsets.all(8),
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () async {
                    switch (index) {
                      case 0:
                        Navigation()
                            .navigateToEditLeasePage(context, widget.house);
                        break;
                      case 1:
                        Navigation().navigateToStore(context, widget.landlord);
                        break;
                    }
                  },
                  child: ListTile(
                    title: Text(
                      items[index],
                      style: const TextStyle(color: Color(primaryColour)),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(primaryColour),
                    ),
                  ),
                );
              }),
              separatorBuilder: (context, index) {
                Color color = const Color(primaryColour);
                return Divider(
                  color: color,
                );
              },
              itemCount: items.length),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            body: NestedScrollView(
              controller: scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    snap: false,
                    floating: false,
                    expandedHeight: 200.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: HouseMenuCard(
                          house: widget.house, landlord: widget.landlord),
                    ),
                  )
                ];
              },
              body: Column(
                children: [
                  const ColoredBox(
                    color: Color(primaryColour),
                    child: TabBar(
                      tabs: [
                        Tab(
                          icon: Icon(Icons.notifications),
                          text: "Notifications",
                        ),
                        Tab(
                          icon: Icon(Icons.home),
                          text: "Manage",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [leftPanel(), rightPanel()],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
