
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/graphql/graphql_client.dart';
import 'package:notification_app/lease/rent/form/rent_form.dart';
import 'package:notification_app/lease/tenancy_terms/form/tenancy_terms_form.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);
  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> with TickerProviderStateMixin {
  Lease lease = Lease();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: Scaffold(
          body: TenancyTermsForm(lease: lease, onUpdate: (rent) {
            
          },)
        
      ),
    );
  }
}
