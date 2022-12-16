import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/business_logic/maintenance_ticket.dart';
import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Buttons/TenantRow.dart';
import 'package:notification_app/widgets/Dialogs/loading_dialog.dart';
import 'package:notification_app/widgets/builders/notifications_limit.dart';

import '../business_logic/house.dart';
import '../graphql/mutation_helper.dart';
import '../widgets/Buttons/IconTextColumn.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  House house = House();
  List<Widget> widgets = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    house.houseId = 5;
   house.firebaseId = "TwIeQHeMqZMia0FAV7vm";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationLimit(house: house, landlord: Landlord())
    );
  }
}
