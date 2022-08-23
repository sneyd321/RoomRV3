import 'package:flutter/material.dart';
import 'package:lease_generation/business_logic/address.dart';
import 'package:lease_generation/business_logic/fields/field.dart';
import 'package:lease_generation/business_logic/lease.dart';
import 'package:lease_generation/business_logic/list_items/additional_term.dart';
import 'package:lease_generation/business_logic/list_items/rent_discount.dart';
import 'package:lease_generation/business_logic/list_items/service.dart';
import 'package:lease_generation/business_logic/list_items/tenant_name.dart';
import 'package:lease_generation/business_logic/list_items/utility.dart';
import 'package:lease_generation/business_logic/tenancy_terms.dart';
import 'package:lease_generation/services/network.dart';
import 'package:lease_generation/widgets/Buttons/PrimaryButton.dart';
import 'package:lease_generation/widgets/Buttons/SecondaryButton.dart';
import 'package:lease_generation/widgets/Forms/BottomSheetForm/AddNameAmountForm.dart';
import 'package:lease_generation/widgets/Forms/BottomSheetForm/AddNameForm.dart';
import 'package:lease_generation/widgets/Forms/PageForm/LandlordAddressForm.dart';
import 'package:lease_generation/widgets/Forms/PageForm/RentForm.dart';
import 'package:lease_generation/widgets/Forms/PageForm/RentalAddressForm.dart';
import 'package:lease_generation/widgets/Forms/PageForm/TenancyTermsForm.dart';
import 'package:lease_generation/widgets/Wrappers/SliverAddItemStateWrapper.dart';
import 'package:provider/provider.dart';

import '../business_logic/rent.dart';

class EditLeaseStatePager extends StatefulWidget {
  final Lease lease;
  const EditLeaseStatePager({Key? key, required this.lease}) : super(key: key);

  @override
  State<EditLeaseStatePager> createState() => _EditLeaseStatePagerState();
}

class _EditLeaseStatePagerState extends State<EditLeaseStatePager> {
  final GlobalKey<FormState> landlordAddressFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> rentalAddressFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> rentFormKey = GlobalKey();
  final GlobalKey<FormState> tenancyTermsFormKey = GlobalKey();
  final Network network = Network();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.location_on)),
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.monetization_on)),
              Tab(icon: Icon(Icons.date_range)),
              Tab(icon: Icon(Icons.home_repair_service)),
              Tab(icon: Icon(Icons.electrical_services)),
              Tab(icon: Icon(Icons.discount)),
              Tab(icon: Icon(Icons.assignment)),
              Tab(icon: Icon(Icons.account_circle)),
            ],
          ),
          title: const Text("Edit Lease"),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  LandlordAddressForm(
                    formKey: landlordAddressFormKey,
                    landlordAddress: widget.lease.landlordAddress,
                  ),
                  RentalAddressForm(
                    formKey: rentalAddressFormKey,
                    rentalAddress: widget.lease.rentalAddress,
                  ),
                  RentForm(
                    formKey: rentFormKey,
                    rent: widget.lease.rent,
                  ),
                  TenancyTermsForm(
                    formKey: tenancyTermsFormKey,
                    tenancyTerms: widget.lease.tenancyTerms,
                  ),
                  SliverAddItemStateWrapper(
                    items: widget.lease.services,
                    card: 'Service',
                    form: AddNameForm(
                      names: const [],
                      onSave: (context, Field name) {
                        setState(() {
                          widget.lease.services
                              .add(CustomPayPerUseService(name));
                        });
                      },
                    ),
                    addButtonTitle: "Add Service",
                  ),
                  SliverAddItemStateWrapper(
                    card: "Utility",
                    items: widget.lease.utilities,
                    form: AddNameForm(
                      names: [],
                      onSave: (context, Field name) {
                        setState(() {
                          widget.lease.utilities.add(CustomUtility(name));
                        });
                      },
                    ),
                    addButtonTitle: "Add Utility",
                  ),
                  SliverAddItemStateWrapper(
                    card: "RentDiscount",
                    items: widget.lease.rentDiscounts,
                    form: AddNameAmountForm(
                      names: [],
                      onSave: (context, name, amount) {
                        setState(() {
                          widget.lease.rentDiscounts
                              .add(CustomRentDiscount(name, amount));
                        });
                      },
                    ),
                  ),
                  SliverAddItemStateWrapper(
                    items: widget.lease.additionalTerms,
                    card: "AdditionalTerm",
                    addButtonTitle: "Add Term",
                    form: AddNameForm(
                      onSave: (context, Field name) {
                        setState(() {
                          widget.lease.additionalTerms.add(CustomTerm(name));
                        });
                      },
                      names: const [],
                    ),
                  ),
                  SliverAddItemStateWrapper(
                    items: widget.lease.tenantNames,
                    card: "TenantName",
                    addButtonTitle: "Add Tenant",
                    form: AddNameForm(
                      onSave: (context, Field name) {
                        setState(() {
                          widget.lease.tenantNames.add(TenantName(name));
                        });
                      },
                      names: const [],
                    ),
                  ),
                ],
              ),
            ),
            SecondaryButton(Icons.update, "Update", (context) async {
              switch (DefaultTabController.of(context)!.index) {
                case 0:
                  if (landlordAddressFormKey.currentState!.validate()) {
                    landlordAddressFormKey.currentState!.save();
                    LandlordAddress landlordAddress =
                        await network.updateLandlordAddress(
                            widget.lease.leaseId, widget.lease.landlordAddress);
                    widget.lease.setLandlordAddress(landlordAddress);
                    setState(() {});
                  }

                  break;
                case 1:
                  if (rentalAddressFormKey.currentState!.validate()) {
                    rentalAddressFormKey.currentState!.save();
                    RentalAddress rentalAddress =
                        await network.updateRentalAddress(
                            widget.lease.leaseId, widget.lease.rentalAddress);
                    widget.lease.setRentalAddress(rentalAddress);
                    setState(() {});
                  }
                  break;
                case 2:
                  if (rentFormKey.currentState!.validate()) {
                    rentFormKey.currentState!.save();
                    Rent rent = await network.updateRent(
                        widget.lease.leaseId, widget.lease.rent);
                    widget.lease.setRent(rent);
                    setState(() {});
                  }
                  break;
                case 3:
                  if (tenancyTermsFormKey.currentState!.validate()) {
                    tenancyTermsFormKey.currentState!.save();
                    TenancyTerms tenancyTerms =
                        await network.updateTenancyTerms(
                            widget.lease.leaseId, widget.lease.tenancyTerms);
                    widget.lease.setTenancyTerms(tenancyTerms);
                    setState(() {});
                  }
                  break;
                case 4:
                  List<Service> services = await network.updateServices(
                      widget.lease.leaseId, widget.lease.services);
                  widget.lease.setServices(services);
                  setState(() {});
                  break;
                case 5:
                  List<Utility> utilities = await network.updateUtilities(
                      widget.lease.leaseId, widget.lease.utilities);
                  widget.lease.setUtilities(utilities);
                  setState(() {});
                  break;
                case 6:
                  List<RentDiscount> rentDiscounts = await network.updateRentDiscounts(
                      widget.lease.leaseId, widget.lease.rentDiscounts);
                  widget.lease.setRentDiscounts(rentDiscounts);
                  setState(() {});
                  break;
                case 7:
                  List<AdditionalTerm> additionalTerms = await network.updateAdditionalTerms(
                      widget.lease.leaseId, widget.lease.additionalTerms);
                  widget.lease.setAdditionalTerms(additionalTerms);
                  setState(() {});
                  break;
                case 8:
                  List<TenantName> tenantNames = await network.updateTenantNames(
                      widget.lease.leaseId, widget.lease.tenantNames);
                  widget.lease.setTenantNames(tenantNames);
                  setState(() {});
                  break;
              }
            }),
            PrimaryButton(Icons.check, "Finalize", (context) {
              print(widget.lease.leaseId);
            })
          ],
        ),
      ),
    );
  }
}
