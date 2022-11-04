import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Cards/LeaseCompleteCard.dart';
import 'package:notification_app/widgets/Cards/LeaseUploadingCard.dart';
import 'package:notification_app/widgets/Listviews/CardSliverListView.dart';

class HouseNotifications extends StatelessWidget {
  final String firebaseId;
  const HouseNotifications({Key? key, required this.firebaseId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('House');
    return Scaffold(
        appBar: AppBar(
          title: const Text("Notifications"),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: collection.doc(firebaseId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              List notifications = data['notifications'];
              return CardSliverListView(
                shrinkWrap: true,
                reversed: true,
                  items: notifications,
                  builder: ((context, index) {
                    Map<String, dynamic> notification =
                        data['notifications'][index];
                    switch (notification["body"]) {
                      case "Lease uploading...":
                        return LeaseUploadingCard(
                            notification: notification, icon: Icons.assignment);
                      case "Lease Complete":
                        return LeaseCompleteCard(
                            notification: notification, icon: Icons.assignment);
                    }
                  }),
                  controller: ScrollController());
            }

            return Text("loading");
          },
        ));
  }
}
