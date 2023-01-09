import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/graphql/graphql_client.dart';


import '../widgets/buttons/IconTextColumn.dart';
import '../widgets/buttons/ProfilePicture.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<String> items = ["Dog", "Cat", "Mouse"];
  int counter = 0;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    counter = items.length;
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: Scaffold(
          body: Align(
        alignment: Alignment.topLeft,
        child: Row(children: [
          Flexible(
            child: SizedBox(
              height: 120,
              child: Scrollbar(
                thumbVisibility: true,
                scrollbarOrientation: ScrollbarOrientation.bottom,
                controller: scrollController,
                thickness: 10,
                child: AnimatedList(
                  controller: scrollController,
                  shrinkWrap: true,
                  key: listKey,
                  initialItemCount: counter,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index, animation) {
                    return FadeTransition(
                      opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
                      child: ProfilePicture(
                        profileSize: 40,
                        iconSize: 60,
                        profileColor: Colors.blueGrey,
                        textColor: Colors.black,
                        icon: Icons.account_circle,
                        profileURL: "",
                        text: items[index],
                        onClick: () {
                          items.remove(items[index]);
                          counter--;
                          listKey.currentState!.removeItem(index,
                              ((context, animation) {
                            return FadeTransition(
                                opacity: animation
                                    .drive(CurveTween(curve: Curves.easeOut)),
                                child: ProfilePicture(
                                  profileSize: 40,
                                  iconSize: 60,
                                  profileColor: Colors.blueGrey,
                                  textColor: Colors.black,
                                  icon: Icons.account_circle,
                                  profileURL: "",
                                  text: "Removing...",
                                  onClick: () {},
                                ));
                          }), duration: const Duration(milliseconds: 500));
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          IconTextColumn(
              icon: Icons.add,
              text: "Add Tenant",
              profileSize: 40,
              iconSize: 60,
              profileColor: Colors.blueGrey,
              textColor: Colors.black,
              onClick: () async {
                items.add("value");
                counter++;
                listKey.currentState!.insertItem(counter - 1);

                Future.delayed(Duration(milliseconds: 500), (() {
                  scrollController.animateTo(
                      scrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                }));
                setState(() {});
              }),
        ]),
      )),
    );
  }
}
