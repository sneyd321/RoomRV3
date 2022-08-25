import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/widgets/Queries/houses_query.dart';
import 'package:notification_app/widgets/mutations/add_house_mutation.dart';

class GraphQLPage extends StatefulWidget {
  const GraphQLPage({Key? key}) : super(key: key);

  @override
  State<GraphQLPage> createState() => _GraphQLPageState();
}

class _GraphQLPageState extends State<GraphQLPage> {
  House house = House();

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: HttpLink(
        'http://192.168.100.110:8081/graphql',
      ),
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  String id = "";

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: client,
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  title: const Text("Documents"),
                ),
                body: HousesQuery())));
  }
}
