import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/main.dart';
import 'package:notification_app/services/FirebaseConfig.dart';
import 'package:notification_app/widgets/buttons/TenantRow.dart';
import 'package:notification_app/widgets/Cards/HouseMenuCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNotificationForm.dart';
import 'package:notification_app/widgets/Helper/BottomSheetHelper.dart';
import 'package:notification_app/widgets/builders/notifications_limit.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../graphql/graphql_client.dart';
import '../graphql/mutation_helper.dart';
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
                scrollController.position.maxScrollExtent,
                duration: Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
              );
            },
          ),
        ),
        Container(
            color: Colors.transparent,
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
                      Navigator.pop(context);
                    }))).show(context);
              },
              label: const Text("Compose Notification"),
              icon: const Icon(Icons.draw),
            ))
      ],
    );
  }



  Widget rightPanel() {
    return Container(
        margin: const EdgeInsets.all(8),
        child: ListView(
          shrinkWrap: true,
          children: [
          TenantRow(house: widget.house),
          Container(
              margin: const EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: const Text(
                "My Apps",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
          GestureDetector(
            onTap: () {
              Navigation().navigateToEditLeasePage(context, widget.house);
            },
            child: const ListTile(
              title: Text(
                "Edit Lease",
                style: TextStyle(color: Color(primaryColour)),
              ),
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Color(primaryColour),
              ),
            ),
          ),
          const Divider(
            color: Color(primaryColour),
          ),
          GestureDetector(
            onTap: () {
              Navigation().navigateToStore(context, widget.landlord);
            },
            child: const ListTile(
              title: Text(
                "Purchase Apps",
                style: TextStyle(color: Color(primaryColour)),
              ),
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Color(primaryColour),
              ),
            ),
          ),
          const Divider(
            color: Colors.red,
          ),
          GestureDetector(
            onTap: () {
              showDeleteDialog();
            },
            child: const ListTile(
              title: Text(
                "Delete House",
                style: TextStyle(color: Colors.red),
              ),
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Colors.red,
              ),
            ),
          )
        ]));
  }

  void showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return GraphQLProvider(
          client: GQLClient().getClient(),
          child: MutationHelper(
            builder: (runMutation) {
              return AlertDialog(
                  actions: [
                    TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text('Yes'),
                      onPressed: () {
                        runMutation({"houseId": widget.house.houseId});
                      },
                    ),
                  ],
                  content: Row(
                    children: const [
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.warning,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          "This will delete your property and all of your tenants.\nThis means tenants will NOT have access to your property.\nDo you still want to delete your property?",
                          softWrap: true,
                        ),
                      ),
                    ],
                  ));
            },
            mutationName: 'deleteHouse',
            onComplete: (json) {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        );
      },
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
            resizeToAvoidBottomInset: true,
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
                  ColoredBox(
                    color: const Color(primaryColour),
                    child: TabBar(
                    onTap: (value) {
                      FocusScope.of(context).requestFocus(FocusNode()); 
                    },
                      tabs: const [
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
