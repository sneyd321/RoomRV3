import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/house.dart';
import 'package:notification_app/services/graphql_client.dart';
import 'package:notification_app/widgets/Cards/HouseCard.dart';
import 'package:notification_app/widgets/Listviews/CardSliverGridView.dart';

class HousesQuery extends StatefulWidget {
  const HousesQuery({Key? key}) : super(key: key);

  @override
  State<HousesQuery> createState() => _HousesQueryState();
}

class _HousesQueryState extends State<HousesQuery> {
  GQLClient gqlClient = GQLClient();

  dynamic getHousesQuery() {
    return gql(r"""
      query getHouses($id: ID!) {
        getHouses(id: $id) {
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
    return GraphQLProvider(
      client: gqlClient.getClient(),
      child: Query(
        options: QueryOptions(
            fetchPolicy: FetchPolicy.noCache,
            document:
                getHousesQuery(), // this is the query string you just created
            variables: const {"id": 4}),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return CardSliverGridView(
            heightRatio: .5,
            widthRatio: 4,
            builder: (context, index) {
              House house = House.fromJson(result.data!["getHouses"][index]);
              return HouseCard(house: house);
            },
            items: result.data!["getHouses"],
          );
        },
      ),
    );
  }
}
