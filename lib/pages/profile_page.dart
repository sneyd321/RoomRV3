import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/main.dart';
import 'package:notification_app/widgets/Buttons/CallToActionButton.dart';
import 'package:notification_app/widgets/Buttons/IconTextColumn.dart';
import 'package:notification_app/widgets/Navigation/bottom_nav_bar.dart';
import 'package:notification_app/widgets/Navigation/navigation.dart';

import '../graphql/mutation_helper.dart';

class ProfilePage extends StatefulWidget {
  final Landlord landlord;

  const ProfilePage({Key? key, required this.landlord}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> items = const [
    "Edit Profile",
    "Delete House",
    "Delete Profile"
  ];
  Landlord landlord = Landlord();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    landlord = widget.landlord;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        bottomNavigationBar: BottomNavBar(landlord: widget.landlord),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconTextColumn(
                profileColor: Colors.blueGrey,
                profileSize: 80,
                icon: Icons.account_circle,
                iconSize: 150,
                textSize: 18,
                textColor: Color(primaryColour),
                text: widget.landlord.getFullName(),
                onClick: () {}),
            Container(
                margin: const EdgeInsets.all(16),
                child:
                    CallToActionButton(text: "Change Picture", onClick: () {})),
            Container(
              margin: const EdgeInsets.all(8),
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    Color color = const Color(primaryColour);
                    if (items[index].contains("Delete")) {
                      color = Colors.red;
                    }
                    return GestureDetector(
                      onTap: () async {
                        switch (index) {
                          case 0:
                            Landlord? updatedLandlord = await Navigation()
                                .navigateToEditProfilePage(
                                    context, widget.landlord);
                            if (updatedLandlord != null) {
                              setState(() {
                                landlord = updatedLandlord;
                              });
                            }
                            break;
                          case 2:
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
                                                runMutation({
                                                  "landlord":
                                                      landlord.toLandlordJson()
                                                });
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
                                                  "This will delete your account but but not your properties.\nThis means tenants will still have access to your properties but you will not.\nDo you still want to delete your account?",
                                                  softWrap: true,
                                                ),
                                              ),
                                            ],
                                          ));
                                    },
                                    mutationName: 'deleteLandlord',
                                    onComplete: (json) {
                                      Navigator.popUntil(context, (route) => route.isFirst);
                                    },
                                  ),
                                );
                              },
                            );
                        }
                      },
                      child: ListTile(
                        title: Text(
                          items[index],
                          style: TextStyle(color: color),
                        ),
                        trailing: Icon(
                          Icons.chevron_right_rounded,
                          color: color,
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
            )
          ],
        ),
      ),
    );
  }
}
