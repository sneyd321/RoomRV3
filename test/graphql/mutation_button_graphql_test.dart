import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:notification_app/services/graphql_client.dart';
import 'package:notification_app/widgets/mutations/mutation_button.dart';

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

  Future<Widget> createMutation(HttpLink httpLink, String queryName) async{
    return GraphQLProvider(
      client: GQLClient().getTestClient(httpLink),
      child: MaterialApp(
            home: Scaffold(
              body: MutationButton(builder: (p0, p1) {
                
              },)
            )
            )

        
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

}