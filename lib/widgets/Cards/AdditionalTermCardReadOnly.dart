
import 'package:flutter/material.dart';
import 'package:notification_app/widgets/Cards/DetailCardReadOnly.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


import '../../services/FirebaseConfig.dart';
import '../Helper/TextHelper.dart';
import '../Listviews/CardSliverGenerator.dart';


class AdditionalTermCardReadOnly extends StatelessWidget {
  final AdditionalTerm additionalTerm;
  final String firebaseId;
  final Landlord landlord;

  const AdditionalTermCardReadOnly(
      {Key? key, required this.additionalTerm, required this.firebaseId, required this.landlord, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String term = additionalTerm.name;
        for (Detail detail in additionalTerm.details) {
          term += "\n${detail.detail}";
        }
        TextComment comment = TextComment.fromLandlord(landlord);
        comment.setComment(term);
        FirebaseConfiguration().setComment(firebaseId, comment);
        
       
        Navigator.pop(context);
        Navigator.pop(context);
      },
      child: Card(
        child: Column(children: [
          ListTile(
            leading: const Icon(Icons.assignment),
            title: TextHelper(text: additionalTerm.name),
          ),
          CardSliverGenerator(
              shrinkWrap: true,
              items: additionalTerm.details
                  .map<String>((Detail detail) => detail.detail)
                  .toList(),
              generator: (index) {
                String detail = additionalTerm.details[index].detail;
                return DetailCardReadOnly(
                  detail: detail,
                );
              })
        ]),
      ),
    );
  }
}
