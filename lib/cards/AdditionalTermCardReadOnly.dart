
import 'package:flutter/material.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';


import '../../services/FirebaseConfig.dart';


class AdditionalTermCardReadOnly extends StatefulWidget {
  final AdditionalTerm additionalTerm;
  final String firebaseId;
  final Landlord landlord;
  

  const AdditionalTermCardReadOnly(
      {Key? key, required this.additionalTerm, required this.firebaseId, required this.landlord, })
      : super(key: key);

  @override
  State<AdditionalTermCardReadOnly> createState() => _AdditionalTermCardReadOnlyState();
}

class _AdditionalTermCardReadOnlyState extends State<AdditionalTermCardReadOnly> {
  final GlobalKey<SliverAnimatedListState> listKey =
      GlobalKey<SliverAnimatedListState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String term = widget.additionalTerm.name;
        for (Detail detail in widget.additionalTerm.details) {
          term += "\n${detail.name}";
        }
        TextComment comment = TextComment.fromLandlord(widget.landlord);
        comment.setComment(term);
        FirebaseConfiguration().setComment(widget.firebaseId, comment);
        
       
        Navigator.pop(context);
        Navigator.pop(context);
      },
      child: Card(
        child: Column(children: [
          ListTile(
            leading: const Icon(Icons.assignment),
            title: Text(widget.additionalTerm.name),
          ),
         
        ]),
      ),
    );
  }
}
