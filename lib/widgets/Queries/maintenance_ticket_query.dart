import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MaintenanceTicketQuery extends StatefulWidget {
  final String houseKey;
  final int maintenanceTicketId;
  final Widget Function(QueryResult<Object?> result,
      {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
      Future<QueryResult<Object?>?> Function()? refetch}) onComplete;
  const MaintenanceTicketQuery(
      {Key? key,
      required this.onComplete,
      required this.houseKey,
      required this.maintenanceTicketId})
      : super(key: key);

  @override
  State<MaintenanceTicketQuery> createState() => _HouseQueryState();
}

class _HouseQueryState extends State<MaintenanceTicketQuery> {
  dynamic getQuery() {
    return gql(r"""
      query getMaintenanceTicket($houseKey: String!, $maintenanceTicketId: Int!) {
  getMaintenanceTicket(houseKey: $houseKey, maintenanceTicketId: $maintenanceTicketId) {
    houseId,
    name,
    imageURL,
    datePosted,
    firebaseId,
    description{
      descriptionText
    },
    urgency {
      name
    },
    sender {
      firstName,
      lastName,
      email
    }
  }
}
      """);
  }

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
            fetchPolicy: FetchPolicy.noCache,
            document: getQuery(), // this is the query string you just created
            variables: {
              "houseKey": widget.houseKey,
              "maintenanceTicketId": widget.maintenanceTicketId
            }),
        builder: widget.onComplete);
  }
}
