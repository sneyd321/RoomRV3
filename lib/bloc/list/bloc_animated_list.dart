import 'package:flutter/material.dart';
import 'package:notification_app/bloc/helper/SecondaryActionButton.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';
import 'package:notification_app/bloc/form_builder/form_container.dart';
import 'package:notification_app/bloc/helper/bottom_sheet_helper.dart';

class BlocAnimatedList extends StatefulWidget {
  final int initialSize;
  final GlobalKey<AnimatedListState> listKey;
  final String label;
  final FormBuilder formBuilder;
  final void Function() onUpdate;
  final Widget Function(
      BuildContext context, int index, Animation<double> animation) itemBuilder;
  const BlocAnimatedList(
      {Key? key,
      this.label = "Add",
      required this.initialSize,
      required this.listKey,
      required this.itemBuilder,
      required this.formBuilder,
      required this.onUpdate})
      : super(key: key);

  @override
  State<BlocAnimatedList> createState() => _BlocAnimatedListState();
}

class _BlocAnimatedListState extends State<BlocAnimatedList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedList(
            shrinkWrap: true,
            key: widget.listKey,
            initialItemCount: widget.initialSize,
            itemBuilder: widget.itemBuilder),
        Container(
          margin: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width / 2,
          child: SecondaryActionButton(
            onClick: () {
              BottomSheetHelper(FormContainer(
                onUpdate: widget.onUpdate,
                formBuilder: widget.formBuilder,
                buttonText: widget.label,
              )).show(context);
            },
            text: widget.label,
          ),
        )
      ],
    );
  }
}
