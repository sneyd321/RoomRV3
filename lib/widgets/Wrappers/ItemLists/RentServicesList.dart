import 'package:flutter/cupertino.dart';
import 'package:notification_app/business_logic/list_items/rent_services.dart';
import 'package:notification_app/business_logic/rent.dart';
import 'package:notification_app/widgets/Cards/RentServiceCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNameAmountForm.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemGeneratorWrapper.dart';

class RentServicesList extends StatefulWidget {
  final Rent rent;
  const RentServicesList({Key? key, required this.rent})
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
        generator: (index) {
          RentService rentService = widget.rent.rentServices[index];
          return RentServiceCard(
              rentService: rentService,
              onItemRemoved: (context, rentService) {
                setState(() {
                  widget.rent.removeRentService(rentService);
                });
              });
        },
        form: AddNameAmountForm(
          names: const ["Parking"],
          onSave: (BuildContext context, name, amount) {
            setState(() {
              widget.rent.addRentService(CustomRentService(name, amount));
        
            });
          },
        ));
  }
}
