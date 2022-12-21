import 'package:flutter/material.dart';
import 'package:notification_app/business_logic/landlord.dart';


class StorePage extends StatefulWidget {
  final Landlord landlord;
  const StorePage({Key? key, required this.landlord}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final TextEditingController searchTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(),
          
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  child: TextField(
                    controller: searchTextEditingController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                        filled: true,
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: (() {
                            setState(() {
                              searchTextEditingController.text = "";
                            });
                          }),
                        ),
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Search Keywords",
                        fillColor: Colors.white70),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(8),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "My Apps",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                Row(
                  children: [
                    Container(
                      height: 110,
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          border: Border.fromBorderSide(
                              BorderSide(color: Colors.white70, width: 1)),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(children: const [
                        Icon(
                          Icons.assignment,
                          size: 48,
                          color: Colors.white,
                        ),
                        Spacer(),
                        Text(
                          "Edit Lease",
                          style: TextStyle(color: Colors.white),
                        )
                      ]),
                    )
                  ],
                ),
                Container(
                    margin: const EdgeInsets.all(8),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Most Popular",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                ListView(
                  shrinkWrap: true,
                  children: [
                    GestureDetector(
                      onTap: () {
                        const snackBar = SnackBar(
                          content: Text('Coming Soon'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                border: Border.fromBorderSide(BorderSide(
                                    color: Colors.white70, width: 1)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: const Icon(
                              Icons.payment,
                              color: Colors.white,
                            ),
                          ),
                          title: const Text("View Payments"),
                          subtitle: const Text(
                              "Set up pre authorized payments and integration with quickbooks"),
                          isThreeLine: true,
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.chevron_right_rounded)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
