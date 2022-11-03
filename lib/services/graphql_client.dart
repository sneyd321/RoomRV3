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

  HiveStore? getHiveStore() {
    HiveStore.open().then((value) {
      return value;
    });
    return null;
  }

  ValueNotifier<GraphQLClient> getTestClient(HttpLink link) {
    return ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(store: getHiveStore()),
        link: link,
      ),
    );
  }

  ValueNotifier<GraphQLClient> getSubscriptionClient() {
    return ValueNotifier(GraphQLClient(
      link: Link.split((request) => request.isSubscription,
          WebSocketLink('ws://192.168.100.110:8081/graphql')),
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    ));
  }
}
