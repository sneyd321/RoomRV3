import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/address.dart';
import 'package:notification_app/business_logic/list_items/parking_description.dart';
import 'package:notification_app/widgets/Cards/DetailCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNameForm.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemGeneratorWrapper.dart';

class ParkingDescriptionsList extends StatefulWidget {
  final RentalAddress rentalAddress;
  const ParkingDescriptionsList({Key? key, required this.rentalAddress})
      : super(key: key);

  @override
  State<ParkingDescriptionsList> createState() =>
      _ParkingDescriptionsListState();
}

class _ParkingDescriptionsListState extends State<ParkingDescriptionsList> {
  @override
  Widget build(BuildContext context) {
    return SliverAddItemGeneratorWrapper(
        shirnkWrap: true,
        addButtonTitle: "Add Description",
        noItemsText: "No Parking Descriptions",
        items: widget.rentalAddress.parkingDescriptions,
        generator: (index) {
          String parkingDescription =
              widget.rentalAddress.parkingDescriptions[index].description;
          return DetailCard(
              detail: parkingDescription,
              onItemRemoved: (context, parkingDescription) {
                setState(() {
                  ParkingDescription description = widget
                      .rentalAddress.parkingDescriptions
                      .where((element) =>
                          element.description == parkingDescription)
                      .first;
                  widget.rentalAddress.parkingDescriptions.remove(description);
                });
              });
        },
        form: AddNameForm(
          names: const [
            "Indoors",
            "Outdoors",
            "Garage",
          ],
          onSave: (context, name) {
            setState(() {
              if (widget.rentalAddress.parkingDescriptions
                  .where((element) => element.description == name)
                  .isNotEmpty) {
                return;
              }
              ParkingDescription description = ParkingDescription(name);
              widget.rentalAddress.parkingDescriptions.add(description);
            });
          },
        ));
  }
}
