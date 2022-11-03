import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MutationHelper extends StatefulWidget {
  final String mutationName;
  final Function(dynamic json) onComplete;
  final Widget Function(
      MultiSourceResult<Object?> Function(Map<String, dynamic>,
              {Object? optimisticResult})
          runMutation) builder;
  const MutationHelper({
    Key? key,
    required this.onComplete,
    required this.mutationName,
    required this.builder,
  }) : super(key: key);

  @override
  State<MutationHelper> createState() => _MutationButtonState();
}

class _MutationButtonState extends State<MutationHelper> {
  bool isVisible = true;

  Future<String> getMutation(String name) async {
    switch (name) {
      case "createMaintenanceTicket":
        return await rootBundle
            .loadString('assets/createMaintenanceTicketMutation.txt');
      case "createHouse":
        return await rootBundle.loadString('assets/createHouseMutation.txt');
      case "updateLandlordInfo":
        return await rootBundle
            .loadString('assets/updateLandlordInfoMutation.txt');
      case "updateLandlordAddress":
        return await rootBundle
            .loadString('assets/updateLandlordAddressMutation.txt');
      case "updateRentalAddress":
        return await rootBundle
            .loadString('assets/updateRentalAddressMutation.txt');
      case "updateRent":
        return await rootBundle.loadString('assets/updateRentMutation.txt');
      case "updateTenancyTerms":
        return await rootBundle
            .loadString('assets/updateTenancyTermsMutation.txt');
      case "updateServices":
        return await rootBundle.loadString('assets/updateServicesMutation.txt');
      case "updateUtilities":
        return await rootBundle
            .loadString('assets/updateUtilitiesMutation.txt');
      case "updateRentDiscounts":
        return await rootBundle
            .loadString('assets/updateRentDiscountsMutation.txt');
      case "updateRentDeposits":
        return await rootBundle
            .loadString('assets/updateRentDepositsMutation.txt');
      case "updateAdditionalTerms":
        return await rootBundle
            .loadString('assets/updateAdditionalTermsMutation.txt');
      case "addTenantEmail":
        return await rootBundle.loadString('assets/addTenantEmailMutation.txt');
      case "createTenant":
        return await rootBundle.loadString('assets/createTenantMutation.txt');
      case "createLandlord":
        return await rootBundle.loadString('assets/createLandlordMutation.txt');
      case "loginTenant":
        return await rootBundle.loadString('assets/loginTenantMutation.txt');
      case "loginLandlord":
        return await rootBundle.loadString('assets/loginLandlordMutation.txt');
      case "scheduleLease":
        return await rootBundle.loadString("assets/scheduleLeaseMutation.txt");
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMutation(widget.mutationName),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return SafeArea(
              child: Scaffold(
                  body: AlertDialog(
                      content: Row(
            children: [
              const CircularProgressIndicator(),
              Container(
                  margin: const EdgeInsets.only(left: 7),
                  child: const Text("Loading...")),
            ],
          ))));
        }

        return Mutation(
            options: MutationOptions(
              document: gql(snapshot.data),
              onCompleted: (Map<String, dynamic>? resultData) async {
                if (resultData == null) {
                  return;
                }
              

                widget.onComplete(resultData[widget.mutationName]);
              },
            ),
            builder: (runMutation, result) {
              if (result != null) {
                if (result.isLoading) {
                  isVisible = true;
                  return Stack(children: [
                    widget.builder(runMutation),
                    AlertDialog(
                        content: Row(children: [
                      const CircularProgressIndicator(),
                      Container(
                          margin: const EdgeInsets.only(left: 7),
                          child: const Text("Loading...")),
                    ]))
                  ]);
                }
                if (result.hasException) {
                  return Stack(
                    children: [
                      widget.builder(runMutation),
                      Visibility(
                        visible: isVisible,
                        child: AlertDialog(
                          actions: [
                            TextButton(
                              child: const Text('Dismiss'),
                              onPressed: () {
                                setState(() {
                                  isVisible = false;
                                });
                              },
                            ),
                          ],
                          content: Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Icon(
                                  Icons.error,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  result.exception!.graphqlErrors.isNotEmpty
                                      ? result
                                          .exception!.graphqlErrors[0].message
                                      : "Failed to connect, connection timed out",
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
              return widget.builder(runMutation);
            });
      },
    );
  }
}
