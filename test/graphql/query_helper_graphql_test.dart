import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/testing.dart';
import 'package:notification_app/services/graphql_client.dart';
import 'package:notification_app/graphql/query_helper.dart';
import 'package:http/http.dart' as http;


void main() {
  
  HttpLink getMockServer(String path, int responseCode) {
    String content = File(path).readAsStringSync();
    return HttpLink(
      'https://unused/graphql',
      httpClient: MockClient((request) async {
        return http.Response(content, responseCode)
        ;
      }),
    );
  }

  Future<Widget> createQuery(HttpLink httpLink, String queryName) async{
    return GraphQLProvider(
      client: GQLClient().getTestClient(httpLink),
      child: QueryHelper(
        queryName: queryName,
        onComplete: (json) {
          return MaterialApp(
            home: Scaffold(
              body: Text(json.toString())
              )
            );
        }, 
        variables: const {"houseId": 1},),
      );
  }

  Future<Widget> createQueryNoOnComplete(HttpLink httpLink, String queryName) async{
    return GraphQLProvider(
      client: GQLClient().getTestClient(httpLink),
      child: QueryHelper(
        queryName: queryName,
        variables: const {"houseId": 1},),
      );
  }

  Future<Widget> createQueryList(HttpLink httpLink, String queryName) async{
    return GraphQLProvider(
      client: GQLClient().getTestClient(httpLink),
      child: QueryHelper(
        queryName: queryName,
        onCompleteList: (json) {
          return MaterialApp(
            home: Scaffold(
              body: ListView.builder(itemBuilder: ((context, index) {
                return Text(json[index].toString());
              }))
              )
            );
        }, 
        variables: const {"houseId": 1},),
      );
  }

  setUpAll(() async {
    await initHiveForFlutter();
  });

  testWidgets("Verify that query helper returns error if missing on complete", (tester) async {
    HttpLink httpLink = getMockServer('./test/responses/maintenance_ticket_200.json', 200);
    await tester.pumpWidget(await createQueryNoOnComplete(httpLink, "getMaintenanceTicket"));
    await tester.pump();
    expect(find.textContaining("Forgot to add an on complete callback"), findsOneWidget);
  });

  testWidgets("Get Maintenance Ticket Successfully", (tester) async {
    HttpLink httpLink = getMockServer('./test/responses/maintenance_ticket_200.json', 200);
    await tester.pumpWidget(await createQuery(httpLink, "getMaintenanceTicket"));
    await tester.pump();
    expect(find.textContaining("description"), findsOneWidget);
  });

  testWidgets("Get Maintenance Tickets Successfully", (tester) async {
    HttpLink httpLink = getMockServer('./test/responses/maintenance_tickets_200.json', 200);
    await tester.pumpWidget(await createQueryList(httpLink, "getMaintenanceTickets"));
    await tester.pump();
    expect(find.textContaining("description"), findsNWidgets(7));
  });
   
}
