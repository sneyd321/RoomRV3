import 'package:flutter/cupertino.dart';
import 'package:notification_app/widgets/Cards/DetailCard.dart';
import 'package:notification_app/widgets/Forms/BottomSheetForm/AddNameForm.dart';
import 'package:notification_app/widgets/Wrappers/SliverAddItemGeneratorWrapper.dart';

class DetailsList extends StatefulWidget {
  final List<String> details;
  const DetailsList({Key? key, required this.details}) : super(key: key);

  @override
  State<DetailsList> createState() => _DetailsListState();
}

class _DetailsListState extends State<DetailsList> {
  @override
  Widget build(BuildContext context) {
    return SliverAddItemGeneratorWrapper(
            shirnkWrap: true,
            items: widget.details,
            noItemsText: "No Details",
            addButtonTitle: "Add Detail",
            generator:(index) {
              String detail = widget.details[index];
              return DetailCard(
                  detail: detail,
                  onItemRemoved: (context, detail) {
                    setState(() {
                     widget.details.remove(detail);
                    });
                  });
            },
            form: AddNameForm(
              onSave: (context, name) {
                setState(() {
                  widget.details.add(name);
                });
              },
              names: const [],
            ));
  }
}