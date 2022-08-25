import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GQLClient {


  static final GQLClient _singleton = GQLClient._internal();

  factory GQLClient() {
    return _singleton;
  }

  GQLClient._internal();

  ValueNotifier<GraphQLClient> getClient() {
    return ValueNotifier(
    GraphQLClient(
      link: HttpLink(
        'http://192.168.100.110:8081/graphql',
      ),
      cache: GraphQLCache(store: HiveStore()),
    ),
  );
  }

  ValueNotifier<GraphQLClient> getSubscriptionClient() {
    return ValueNotifier(
    GraphQLClient(
      link: Link.split((request) => request.isSubscription, WebSocketLink('ws://192.168.100.110:8081/graphql')),
      cache: GraphQLCache(store: HiveStore(),
      ),
    )
    );

  }

}