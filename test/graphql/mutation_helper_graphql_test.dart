import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:notification_app/business_logic/address.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/business_logic/landlord_info.dart';
import 'package:notification_app/business_logic/list_items/additional_term.dart';
import 'package:notification_app/business_logic/list_items/deposit.dart';
import 'package:notification_app/business_logic/list_items/rent_discount.dart';
import 'package:notification_app/business_logic/list_items/service.dart';
import 'package:notification_app/business_logic/list_items/utility.dart';
import 'package:notification_app/business_logic/maintenance_ticket.dart';
import 'package:notification_app/business_logic/rent.dart';
import 'package:notification_app/business_logic/tenancy_terms.dart';
import 'package:notification_app/business_logic/tenant.dart';
import 'package:notification_app/graphql/mutation_helper.dart';
import 'package:notification_app/services/graphql_client.dart';
import 'package:notification_app/widgets/Cards/RentDiscoutCard.dart';

void main() {
  Widget getMutation(String responseFileName, String mutationName,
      dynamic Function(dynamic json) convert) {
    String result = "";
    String content =
        File("./test/responses/$responseFileName").readAsStringSync();
    return GraphQLProvider(
      client: GQLClient().getTestClient(HttpLink('https://unused/graphql',
          httpClient: MockClient((request) async {
        return http.Response(content, 200);
      }))),
      child: MaterialApp(
        home: MutationHelper(
          mutationName: mutationName,
          onComplete: (json) {
            dynamic data = convert(json);
            result = data.toJson().toString();
            printOnFailure(result);
          },
          builder: ((runMutation) {
            runMutation({});
            return SafeArea(child: Scaffold(body: Text(result)));
          }),
        ),
      ),
    );
  }


  Widget getMutationList(String responseFileName, String mutationName,
      dynamic Function(dynamic json) convert) {
    String result = "";
    String content =
        File("./test/responses/$responseFileName").readAsStringSync();
    return GraphQLProvider(
      client: GQLClient().getTestClient(HttpLink('https://unused/graphql',
          httpClient: MockClient((request) async {
        return http.Response(content, 200);
      }))),
      child: MaterialApp(
        home: MutationHelper(
          mutationName: mutationName,
          onComplete: (json) {
            dynamic data = convert(json);
            result = data.map((e) => e.toJson()).toList().toString();
            printOnFailure("Did it print?");
            printOnFailure(result);
          },
          builder: ((runMutation) {
            runMutation({});
            return SafeArea(child: Scaffold(body: Text(result)));
          }),
        ),
      ),
    );
  }

  setUpAll(() async {
    await initHiveForFlutter();
  });

  testWidgets("Mutation_helper_successfully_parses_tenant_on_add_tenant_email",
      (tester) async {
    Widget widget = getMutation("add_tenant_200.json", "addTenant", (json) {
      return Tenant.fromJson(json);
    });

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();
    expect(find.textContaining("Ryan"), findsOneWidget);
  });

  testWidgets("Mutation_helper_successfully_parses_landlord_on_login",
      (tester) async {
    Widget widget =
        getMutation("login_landlord_200.json", "loginLandlord", (json) {
      return Landlord.fromJson(json);
    });

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();
    expect(find.textContaining("Ryan"), findsOneWidget);
  });

  testWidgets("Mutation_helper_successfully_parses_landlord_on_sign_in",
      (tester) async {
    Widget widget =
        getMutation("create_landlord_200.json", "createLandlord", (json) {
      return Landlord.fromJson(json);
    });

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();
    expect(find.textContaining("Ryan"), findsOneWidget);
  });

  testWidgets("Mutation_helper_successfully_parses_house_on_create_house",
      (tester) async {
    Widget widget = getMutation("create_house_200.json", "createHouse", (json) {
      return House.fromJson(json);
    });

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();
    expect(find.textContaining("s2i1SboWPwM6jPglRIvl"), findsOneWidget);
  });

  testWidgets("Mutation_helper_successfully_parses_tenant_on_create_tenant",
      (tester) async {
    Widget widget =
        getMutation("create_tenant_200.json", "createTenant", (json) {
      return Tenant.fromJson(json);
    });

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();
    expect(find.textContaining("Ryan"), findsOneWidget);
  });

  testWidgets(
      "Mutation_helper_successfully_parses_maintenance_ticket_on_create_maitnenance_ticket",
      (tester) async {
    Widget widget = getMutation(
        "create_maintenance_ticket_200.json", "createMaintenanceTicket",
        (json) {
      return MaintenanceTicket.fromJson(json);
    });

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();
    expect(find.textContaining("fdagfdasfsdfasdfa"), findsOneWidget);
  });

  testWidgets("Mutation_helper_successfully_parses_tenant_on_login",
      (tester) async {
    Widget widget = getMutation("login_tenant_200.json", "loginTenant", (json) {
      return Tenant.fromJson(json);
    });

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();
    expect(find.textContaining("Ryan"), findsOneWidget);
  });

  testWidgets("Mutation_helper_successfully_parses_landlord_info_on_update",
      (tester) async {
    Widget widget = getMutation(
        "update_landlord_info_200.json", "updateLandlordInfo", (json) {
      return LandlordInfo.fromJson(json);
    });

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();
    expect(find.textContaining("Ryan Sneyd"), findsOneWidget);
  });

  testWidgets("Mutation_helper_successfully_parses_landlord_address_on_update",
      (tester) async {
    Widget widget = getMutation(
        "update_landlord_address_200.json", "updateLandlordAddress", (json) {
      return LandlordAddress.fromJson(json);
    });

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();
    expect(find.textContaining("Bronte Rd."), findsOneWidget);
  });

  testWidgets("Mutation_helper_successfully_parses_rental_address_on_update",
      (tester) async {
    Widget widget = getMutation(
        "update_rental_unit_address_200.json", "updateRentalAddress", (json) {
      return RentalAddress.fromJson(json);
    });

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();
    expect(find.textContaining("Raspberry"), findsOneWidget);
  });

  testWidgets("Mutation_helper_successully_parses_rent_on_update",
      (tester) async {
    Widget widget = getMutation("update_rent_200.json", "updateRent", (json) {
      return Rent.fromJson(json);
    });

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();
    expect(find.textContaining("2000"), findsOneWidget);
  });

  testWidgets("Mutation_helper_successfully_parses_tenancy_terms_on_update",
      (tester) async {
    Widget widget = getMutation(
        "update_tenancy_terms_200.json", "updateTenancyTerms", (json) {
      return TenancyTerms.fromJson(json);
    });

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();
    expect(find.textContaining("8/16/2022"), findsOneWidget);
  });

  testWidgets("Mutation_helper_successfully_parses_services_on update",
      (tester) async {
    Widget widget =
        getMutationList("update_services_200.json", "updateServices", (json) {
      return json.map<Service>((e) => CustomService.fromJson(e)).toList();
    });

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();
    expect(find.textContaining("Gas"), findsOneWidget);
  });

  testWidgets("Mutation_helper_successfully_parses_utilities_on_update",
      (tester) async {
    Widget widget =
        getMutationList("update_utilities_200.json", "updateUtilities", (json) {
      return json.map<Utility>((e) => CustomUtility.fromJson(e)).toList();
    });

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();
    expect(find.textContaining("Electricity"), findsOneWidget);
  });

  testWidgets("Mutation_helper_successfully_parses_rent_discounts_on_update",
      (tester) async {
    Widget widget =
        getMutationList("update_rent_discount_200.json", "updateRentDiscounts", (json) {
      return json.map<RentDiscount>((e) => CustomRentDiscount.fromJson(e)).toList();
    });

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();
    expect(find.textContaining("Snow Removal"), findsOneWidget);
  });

  testWidgets("Mutation_helper_successfully_parses_rent_deposits_on_update",
      (tester) async {
    Widget widget =
        getMutationList("update_rent_deposits_200.json", "updateRentDeposits", (json) {
      return json.map<Deposit>((e) => CustomDeposit.fromJson(e)).toList();
    });

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();
    expect(find.textContaining("2000"), findsOneWidget);
  });

  testWidgets("Mutation_helper_successfully_parses_additional_terms_on_update",
      (tester) async {
    Widget widget =
        getMutationList("update_additional_terms_200.json", "updateAdditionalTerms", (json) {
      return json.map<AdditionalTerm>((e) => CustomTerm.fromJson(e)).toList();
    });

    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pump();
    expect(find.textContaining("Post Dated Cheques"), findsOneWidget);
  });
}
