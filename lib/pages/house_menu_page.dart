import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuItemCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const MenuItemCard({Key? key, required this.icon, required this.label})
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(label),
        ));
      },
    );
  }
}

class MenuItem {
  final IconData iconData;
  final String label;

  MenuItem(this.iconData, this.label);
}

class HouseMenuPage extends StatelessWidget {
  final int houseId;
  HouseMenuPage({Key? key, required this.houseId}) : super(key: key);

  final List<MenuItem> menuItems = [
    MenuItem(Icons.group_add_outlined, "Add Tenants"),
    MenuItem(Icons.assignment, "Create Lease")
  ];

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
                    icon: menuItem.iconData, label: menuItem.label);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
            )));
  }
}
