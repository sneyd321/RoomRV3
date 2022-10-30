import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/lease.dart';
import 'package:notification_app/pages/edit_lease_pages/update_additional_terms_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_landlord_address_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_landlord_info_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_rent_deposit_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_rent_discount_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_rent_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_rental_address_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_tenancy_terms_page.dart';
import 'package:notification_app/pages/edit_lease_pages/update_tenant_names_page.dart';
import 'package:notification_app/pages/edit_lease_view_pager.dart';
import 'package:notification_app/services/graphql_client.dart';
import 'package:notification_app/widgets/Buttons/PrimaryButton.dart';
import 'package:notification_app/widgets/Cards/HouseCard.dart';
import 'package:notification_app/widgets/Listviews/CardSliverGridView.dart';

import '../../pages/edit_lease_pages/update_services_page.dart';
import '../../pages/edit_lease_pages/update_utilities_page.dart';

class LeaseQuery extends StatefulWidget {
  const LeaseQuery({Key? key}) : super(key: key);

  @override
  State<LeaseQuery> createState() => _LeaseQueryState();
}

class _LeaseQueryState extends State<LeaseQuery> {
  GQLClient gqlClient = GQLClient();
    Lease lease = Lease();
  onUpdate(BuildContext context) {}

  dynamic getHousesQuery() {
    return gql(r"""
  query getLease($houseId: ID!){
    getLease(houseId: $houseId) {
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
      """);
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: gqlClient.getClient(),
      child: SafeArea(
        child: Scaffold(
          body: Query(
            options: QueryOptions(
                fetchPolicy: FetchPolicy.noCache,
                document:
                    getHousesQuery(), // this is the query string you just created
                variables: const {"houseId": 90}),
            builder: (result, {fetchMore, refetch}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }
              if (result.isLoading) {
                
                return Stack(
                  children: [
                    //EditLeaseStatePager(lease: Lease(),),
                    const Center(child: CircularProgressIndicator(),)
                  ],
                );
     
              }
              return const Center(child: CircularProgressIndicator(),);//EditLeaseStatePager(lease: Lease.fromJson(result.data!["getLease"]),);
                  /*
              return CardSliverGridView(
                builder: (context, index) {
                  return HouseCard(house: result.data!["getLease"][index]);
                },
                items: result.data!["getLease"],
                
              );
              */
            },
          ),
        ),
      ),
    );
  }
}
