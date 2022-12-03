import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ApproveTenantNotificationCard extends StatefulWidget {
  final QueryDocumentSnapshot document;
  const ApproveTenantNotificationCard({Key? key, required this.document})
      : super(key: key);

  @override
  State<ApproveTenantNotificationCard> createState() =>
      _ApproveTenantNotificationCardState();
}

class _ApproveTenantNotificationCardState
    extends State<ApproveTenantNotificationCard> {
  late Map<String, dynamic> data;
  late String path;
  @override
  void initState() {
    super.initState();
    data = widget.document.data() as Map<String, dynamic>;
    path = widget.document.reference.path;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: ListTile(
        visualDensity: VisualDensity(vertical: 0.5),
        leading: const CircleAvatar(child: Icon(Icons.account_circle)),
        title: Text(
          "${data["data"]["firstName"]} ${data["data"]["lastName"]}",
          style: const TextStyle(fontSize: 16),
        ),
        isThreeLine: true,
        subtitle: const Text("Has signed the lease"),
        trailing: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(25)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(color: Colors.black)))),
              onPressed: () async {
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Container(
                          constraints: const BoxConstraints(maxWidth: 400),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 75,
                                margin: const EdgeInsets.all(8),
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Flexible(
                                      child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 8),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "name",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 16, bottom: 16, right: 8),
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: const Text("Download")),
                                    ),
                                    Text(
                                      "errorText",
                                      style: const TextStyle(color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: const Text(
                "View Details",
                style: TextStyle(fontSize: 16),
              )),
        ),
      ),
    );
  }
}
