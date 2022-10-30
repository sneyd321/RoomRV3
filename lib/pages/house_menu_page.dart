import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/pages/add_tenant_page.dart';
import 'package:notification_app/pages/edit_lease_view_pager.dart';

class MenuItemCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final House house;

  const MenuItemCard({Key? key, required this.icon, required this.label, required this.house})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Column(children: [
          Icon(
            icon,
            size: 100,
          ),
          Container(
              margin: const EdgeInsets.all(8),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 18),
                  )))
        ]),
      ),
      onTap: () {
        switch (label) {
          case "Add Tenants":
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddTenantPage(house: house)));
            break;
          case "Edit Lease":
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditLeaseStatePager(house: house)));
            break;
        }
      },
    );
  }
}

class MenuItem {
  final IconData iconData;
  final String label;
  final House house;

  MenuItem(this.iconData, this.label, this.house);
}

class HouseMenuPage extends StatefulWidget {
  final House house;
  const HouseMenuPage({Key? key, required this.house}) : super(key: key);

  @override
  State<HouseMenuPage> createState() => _HouseMenuPageState();
}

class _HouseMenuPageState extends State<HouseMenuPage> {
  final List<MenuItem> menuItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuItems.add(MenuItem(Icons.group_add_outlined, "Add Tenants", widget.house));
    menuItems.add(MenuItem(Icons.assignment, "Edit Lease", widget.house));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(),
            body: GridView.builder(
              primary: false,
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                MenuItem menuItem = menuItems[index];

                return MenuItemCard(
                    icon: menuItem.iconData, label: menuItem.label, house: menuItem.house,);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
            )));
  }
}
