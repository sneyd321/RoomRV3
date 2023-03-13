import 'package:flutter/cupertino.dart';


abstract class CardTemplate<T> {
  final T item;
  final int index;
  final void Function(T t) onUpdate;
  final void Function() onRemove;

  CardTemplate(
      {required this.item,
      required this.index,
      required this.onUpdate,
      required this.onRemove});

  Widget build(BuildContext context);

}
