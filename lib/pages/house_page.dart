import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/pages/add_lease_pages/add_rental_address_page.dart';
import 'package:notification_app/pages/add_lease_view_pager.dart';

import 'package:notification_app/services/FirebaseConfig.dart';
import 'package:notification_app/widgets/Cards/HouseCard.dart';
import 'package:notification_app/widgets/Listviews/CardSliverGridView.dart';
import 'package:notification_app/widgets/Queries/houses_query.dart';

class HousesPage extends StatefulWidget {
  final List<House> houses;
  const HousesPage({Key? key, required this.houses}) : super(key: key);

  @override
  State<HousesPage> createState() => _HousesPageState();
}

class _HousesPageState extends State<HousesPage> {
  final FirebaseConfiguration firebaseConfiguration = FirebaseConfiguration();
  String text = "";
  Lease lease = Lease();

  @override
  void initState() {
    super.initState();
    firebaseConfiguration.initialize();
    lease.services[0].addDetail("gdafdasfasf");
  }

  final GlobalKey<FormState> rentFormKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                final value = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddLeaseViewPager(),
                  ),
                );
                setState(() {});
              },
            ),
            appBar: AppBar(
              title: const Text("Documents"),
            ),
            body: AddRentalAddressPage(lease: lease, onBack: (context) {}, onNext: (context){},),));
  }
}
