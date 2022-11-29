import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

//const String host = 'https://router-s5xgw6tidq-uc.a.run.app/graphql';
const String host = 'http://localhost:8081/graphql';

class GQLClient implements ResponseObserver {
  static final GQLClient _singleton = GQLClient._internal();
  
  ResponseReaderClient httpClient = ResponseReaderClient(host);
  late HttpLink httpLink;
  
  factory GQLClient() {
    return _singleton;
  }

  GQLClient._internal() {
    httpClient.registerObserver(this);
    httpLink = HttpLink(host, httpClient: httpClient);
  }

  ValueNotifier<GraphQLClient> getClient() {
    return ValueNotifier(
      GraphQLClient(
        link: httpLink,
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

  @override
  void onResponse(HttpLink link) {
    httpLink = link;
  }
}

abstract class ResponseObserver {
  void onResponse(HttpLink link);
}

abstract class ResponseObservable {
  void registerObserver(ResponseObserver observer);

  void clearObserver();

  void notify(HttpLink link);
}

class ResponseReaderClient extends http.BaseClient
    implements ResponseObservable {
  ResponseObserver? observer;
  final String host;

  ResponseReaderClient(this.host);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    http.StreamedResponse response = await request.send();
    Map<String, String> requestHeaders = {
      "Authorization": "Bearer ${response.headers["authorization"]}"  
    };
    HttpLink link = HttpLink(host,
        httpClient: this, defaultHeaders: requestHeaders);
    
    notify(link);
    return response;
  }

  @override
  void clearObserver() {
    observer = null;
  }

  @override
  void notify(HttpLink link) {
    if (observer == null) {
      return;
    }
    observer!.onResponse(link);
  }

  @override
  void registerObserver(ResponseObserver observer) {
    this.observer = observer;
  }
}
