import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/services/graphql_client.dart';
import 'package:notification_app/widgets/Cards/HouseCard.dart';
import 'package:notification_app/widgets/Listviews/CardSliverGridView.dart';

class HousesQuery extends StatefulWidget {
  const HousesQuery({Key? key}) : super(key: key);

  @override
  State<HousesQuery> createState() => _HousesQueryState();
}

class _HousesQueryState extends State<HousesQuery> {
  GQLClient gqlClient = GQLClient();
  List<Map<String, dynamic>> houses = [];
  
  dynamic getHousesQuery() {
    return gql(r"""
      query getHouses($id: ID!) {
        getHouses(id: $id) {
          houseKey,
          id, 
          lease {
            rentalAddress {
              streetNumber,
              streetName,
              city,
              province,
              postalCode,
              unitName
            }
          }
        }
      }
      """);
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: gqlClient.getClient(),
      child: Query(
        options: QueryOptions(
            fetchPolicy: FetchPolicy.noCache,
            document:
                getHousesQuery(), // this is the query string you just created
            variables: const {"id": 3}),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return CardSliverGridView(
            builder: (context, index) {
              return HouseCard(house: result.data!["getHouses"][index]);
            },
            items: result.data!["getHouses"],
          );
        },
      ),
    );
  }
}
