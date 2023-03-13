import 'package:flutter/material.dart';
import 'package:notification_app/lease/landlord_info/form/landlord_info_form.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';
import '../../graphql/mutation_helper.dart';

class UpdateLandlordInfoPage extends StatefulWidget {
  final Lease lease;
  const UpdateLandlordInfoPage({
    Key? key,
    required this.lease,
  }) : super(key: key);

  @override
  State<UpdateLandlordInfoPage> createState() => _UpdateLandlordInfoPageState();
}

class _UpdateLandlordInfoPageState extends State<UpdateLandlordInfoPage> {

  @override
  Widget build(BuildContext context) {
    return MutationHelper(
      builder: ((runMutation) {
        return LandlordInfoForm(
          lease: widget.lease,
          onUpdate: (LandlordInfo landlordInfo) {
            widget.lease.updateLandlordInfo(landlordInfo);
            runMutation({
              "houseId": widget.lease.houseId,
              "landlordInfo": widget.lease.landlordInfo.toLandlordInfoInput()
            });
          },
        );
      }),
      mutationName: 'updateLandlordInfo',
      onComplete: (json) {
        const snackBar = SnackBar(
          content: Text('Update Successful'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }
}
