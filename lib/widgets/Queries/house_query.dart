import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../services/graphql_client.dart';

class HouseQuery extends StatefulWidget {
  final String houseKey;
  final Widget Function(QueryResult<Object?> result,
      {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore,
      Future<QueryResult<Object?>?> Function()? refetch}) onComplete;
  const HouseQuery({Key? key, required this.onComplete, required this.houseKey}) : super(key: key);

  @override
  State<HouseQuery> createState() => _HouseQueryState();
}

class _HouseQueryState extends State<HouseQuery> with TickerProviderStateMixin {
  GQLClient gqlClient = GQLClient();

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      value: .8,
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  dynamic getHousesQuery() {
    return gql(r"""
      query getHouse($houseKey: ID!) {
        getHouse(houseKey: $houseKey) {
          houseKey,
          id, 
          firebaseId,
          lease {
            id,
            documentName,
            documentURL
            landlordInfo {
            fullName,
            receiveDocumentsByEmail,
            emails {
              email
            },
            contactInfo,
            contacts {
                contact
              }
            },
          landlordAddress{
            streetNumber,
            streetName,
            city,
            province,
            postalCode,
            unitNumber,
            poBox
          },
          rentalAddress {
              streetNumber,
              streetName,
              city,
              province,
              postalCode,
              unitName,
              isCondo,
              parkingDescriptions {
                description
              }
          },
          rent {
            baseRent,
            rentMadePayableTo,
            rentServices {
                name,
                amount
            },
            paymentOptions {
              name
            }
          },
          tenancyTerms {
            rentalPeriod {
                rentalPeriod,
                endDate
            },
            startDate,
            rentDueDate,
            paymentPeriod,
            partialPeriod {
                amount,
                dueDate,
                startDate,
                endDate,
                isEnabled
            }
          },
          services {
            name,
            isIncludedInRent,
            isPayPerUse,
              details {
                detail
              }
          }
          utilities {
            name,
            responsibility,
            details {
              detail
            }
          }
          rentDiscounts {
            name,
            amount,
            details {
              detail
            }   
          }
          rentDeposits {
            name,
            amount,
            details {
              detail
            }
          }
          additionalTerms {
            name,
            details {
              detail
            }
          },
          tenantNames {
            name
          }
    
          }
        }
      }
      """);
  }

  

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
            fetchPolicy: FetchPolicy.noCache,
            document:
                getHousesQuery(), // this is the query string you just created
            variables: {"houseKey": widget.houseKey}),
        builder: widget.onComplete
      
    );
  }
}
