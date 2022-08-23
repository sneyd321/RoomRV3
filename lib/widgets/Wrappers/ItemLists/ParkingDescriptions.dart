import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/list_items/parking_description.dart';
import 'package:notification_app/widgets/Cards/DetailCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNameForm.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemGeneratorWrapper.dart';

class ParkingDescriptionsList extends StatefulWidget {
  final List<ParkingDescription> parkingDescriptions;
  const ParkingDescriptionsList({Key? key, required this.parkingDescriptions}) : super(key: key);

  @override
  State<ParkingDescriptionsList> createState() => _ParkingDescriptionsListState();
}

class _ParkingDescriptionsListState extends State<ParkingDescriptionsList> {
  @override
  Widget build(BuildContext context) {
    return SliverAddItemGeneratorWrapper(
      shirnkWrap: true,
      items: widget.parkingDescriptions, generator: (index) {
      ParkingDescription parkingDescription = widget.parkingDescriptions[index];
      return DetailCard(detail: parkingDescription.description, onItemRemoved: (context, parkingDescription) {
        setState(() {
          widget.parkingDescriptions.remove(ParkingDescription(parkingDescription));
        });
      });
    }, form: AddNameForm(names: [], onSave: (context, name) {
      setState(() {
        widget.parkingDescriptions.add(ParkingDescription(name));
      });
    },));
  }
}