import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/list_items/rent_services.dart';
import 'package:notification_app/business_logic/rent.dart';
import 'package:notification_app/widgets/Cards/RentServiceCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNameAmountForm.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemGeneratorWrapper.dart';

class RentServicesList extends StatefulWidget {
  final Rent rent;
  final Function(BuildContext context, RentService rentService)
      onAddRentService;
  final Function(BuildContext context, RentService rentService)
      onRemoveRentService;
  const RentServicesList(
      {Key? key,
      required this.rent,
      required this.onAddRentService,
      required this.onRemoveRentService})
      : super(key: key);

  @override
  State<RentServicesList> createState() => _RentServicesListState();
}

class _RentServicesListState extends State<RentServicesList> {
  @override
  Widget build(BuildContext context) {
    return SliverAddItemGeneratorWrapper(
        shirnkWrap: true,
        items: widget.rent.rentServices,
        addButtonTitle: "Add Service",
        noItemsText: "No Services",
        generator: (index) {
          RentService rentService = widget.rent.rentServices[index];
          return RentServiceCard(
              rentService: rentService,
              onItemRemoved: (context, rentService) {
                widget.rent.removeRentService(rentService);
                widget.onRemoveRentService(context, rentService);
              });
        },
        form: AddNameAmountForm(
          names: const [
            "Parking",
            "Gas",
            "Air conditioning",
            "Addtional storage space",
            "On-site Laundry",
            "Guest Parking",
            "Electricity",
            "Heat",
            "Water",
            "Internet"
          ],
          onSave: (BuildContext context, name, amount) {
            RentService rentService = CustomRentService(name, amount);
            widget.rent.addRentService(rentService);
            widget.onAddRentService(context, rentService);
            Navigator.pop(context);
          },
        ));
  }
}
