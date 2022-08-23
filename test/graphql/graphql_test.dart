import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/widgets/mutations/add_house_mutation.dart';

import '../test_case_builder.dart';

void main() {
  HttpLink getSuccessResponse() {
    return HttpLink(
      'https://unused/graphql',
      httpClient: MockClient((request) async {
        return http.Response(r""" 
        {
          "data": {
            "createHouse": {
              "id": 50,
              "houseKey": "e55e36",
              "firebaseId": "abc123",
              "lease": {
                "landlordInfo": {
                  "fullName": "Ryan Sneyd"
                }
              }
            }
          }
        }
        """, 200);
      }),
    );
  }

  Future<ValueNotifier<GraphQLClient>> getClient(HttpLink mockResponse) async {
    return ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(store: await HiveStore.open()),
        link: mockResponse,
      ),
    );
  }

  Widget getAddHouseMutation(
      Function(BuildContext context, int houseId) onComplete,
      ValueNotifier<GraphQLClient> client) {
    return GraphQLProvider(
      client: client,
      child: AddHouseMutation(onComplete: onComplete, house: House()),
    );
  }

  setUpAll(() async {
    await initHiveForFlutter();
  });

  testWidgets("test mutation", (tester) async {
    Widget widget = getAddHouseMutation((context, houseId) {
      expect(houseId, equals(50));
    }, await getClient(getSuccessResponse()));
    await TestCaseBuilder(tester)
        .loadPage(widget)
        .then((value) => value.tapButton("Upload", scroll: false));
  });
}
