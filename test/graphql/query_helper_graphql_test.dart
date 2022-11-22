import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/testing.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/maintenance_ticket.dart';
import 'package:notification_app/business_logic/tenant.dart';
import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/graphql/query_helper.dart';
import 'package:http/http.dart' as http;

void main() {
  Widget getQuery(String responseFileName, String queryName,
      dynamic Function(dynamic json) convert) {
    String content =
        File("./test/responses/$responseFileName").readAsStringSync();
    return GraphQLProvider(
      client: GQLClient().getTestClient(HttpLink('https://unused/graphql',
          httpClient: MockClient((request) async {
        return http.Response(content, 200);
      }))),
      child: MaterialApp(
        home: QueryHelper(
          queryName: queryName,
          onComplete: (json) {
            if (json == null) {
              return CircularProgressIndicator();
            }
            dynamic data = convert(json);
            return SafeArea(
                child: Scaffold(body: Text(data.toJson().toString())));
          },
          variables: {},
          isList: false,
        ),
      ),
    );
  }

  Widget getQueryList(String responseFileName, String queryName, dynamic Function(dynamic json) convert) {
    String content =
        File("./test/responses/$responseFileName").readAsStringSync();
    return GraphQLProvider(
      client: GQLClient().getTestClient(HttpLink('https://unused/graphql',
          httpClient: MockClient((request) async {
        return http.Response(content, 200);
      }))),
      child: MaterialApp(
        home: QueryHelper(
          queryName: queryName,
          onComplete: (json) {
            if (json == null) {
              return CircularProgressIndicator();
            }
            dynamic data = convert(json);
            return SafeArea(
                child: Scaffold(
                    body: ListView(
              children: data
                  .map<ListTile>(
                      (e) => ListTile(title: Text(e.toJson().toString())))
                  .toList(),
            )));
          },
          variables: {},
          isList: true,
        ),
      ),
    );
  }

  /**
   * ###############################################################################
   * 
   * ###############################################################################
   * 
   * ###############################################################################
   * 
   */

  setUpAll(() async {
    await initHiveForFlutter();
  });

  testWidgets("Query_helper_successfully_parses_house", (tester) async {
    await tester.pumpWidget(
        getQuery("house_200.json", "getHouse",  (json) {
      return House.fromJson(json);
    }));
    await tester.pumpAndSettle();
    expect(find.textContaining("SoMfxJpiGxsfDiAhlIm4"), findsOneWidget);
  });

  testWidgets("Query_helper_successfully_parses_houses", (tester) async {
    await tester.pumpWidget(
        getQueryList("houses_200.json", "getHouses", (json) {
      return json.map<House>((e) => House.fromJson(e)).toList();
    }));
    await tester.pumpAndSettle();
    expect(find.textContaining("SoMfxJpiGxsfDiAhlIm4"), findsOneWidget);
  });

  testWidgets("Query_helper_successfully_parses_tenants", (tester) async {
    await tester.pumpWidget(
        getQueryList("tenants_200.json", "getTenants",  (json) {
      return json.map<Tenant>((e) => Tenant.fromJson(e)).toList();
    }));
    await tester.pumpAndSettle();
    expect(find.textContaining("Ryan"), findsOneWidget);
  });

  testWidgets("Query_helper_successfully_parses_maintenance_ticket",
      (tester) async {
    await tester.pumpWidget(getQuery(
        "maintenance_ticket_200.json",
        "getMaintenanceTicket",
       (json) {
      return MaintenanceTicket.fromJson(json);
    }));
    await tester.pumpAndSettle();
    expect(find.textContaining("fdagfdasfsdfasdfa"), findsOneWidget);
  });

  testWidgets("Query_helper_successfully_parses_maintenance_tickets", (tester) async {
    await tester.pumpWidget(
        getQueryList("maintenance_tickets_200.json", "getMaintenanceTickets", (json) {
      return json.map<MaintenanceTicket>((e) => MaintenanceTicket.fromJson(e)).toList();
    }));
    await tester.pumpAndSettle();
    expect(find.textContaining("Ryan"), findsNWidgets(9));
  });

}
