import 'package:flutter/material.dart';
import 'package:notification_app/bloc/helper/animated_list_helper.dart';
import 'package:notification_app/bloc/helper/list_error.dart';
import 'package:notification_app/bloc/list/card/card_template.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';
import 'package:notification_app/bloc/list/bloc_animated_list.dart';
import 'package:notification_app/bloc/form_builder/form_item.dart';

import '../bloc.dart';

abstract class ListContainer extends FormItem {
  String label = "";

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Enum errorKey = ErrorKey.empty;
  Enum selectionErrorKey = ErrorKey.empty;
  int initialSize = 0;
  
  late FormBuilder formBuilder;

  AnimatedListHelper animatedListHelper = AnimatedListHelper();
  late final AnimationController _controller;

  ListContainer({top, left, right, bottom, width})
      : super(top: top, left: left, right: right, bottom: bottom, width: width);

  @override
  void setTickerProvider(TickerProvider tickerProvider) {
    super.setTickerProvider(tickerProvider);
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: tickerProvider);
  }

  @override
  void setBloc(Bloc bloc) {
    super.setBloc(bloc);
    setErrorKey();
    setLabel();
    setSelectionErrorKey();
    formBuilder = FormBuilder(bloc);
    initialSize = bloc.getLength(errorKey);
  }

  @override
  void dispose() {
    _controller.dispose();
  }

  @override
  Widget build(Object? error) {
    setFormBuilder();
    List<Widget> children = [
      BlocAnimatedList(
        listKey: listKey,
        initialSize: bloc.getLength(errorKey),
        label: label,
        itemBuilder: (context, index, animation) {
          return SizeTransition(
              sizeFactor: animation,
              child: getCard(context, index, animation).build(context));
        },
        formBuilder: formBuilder,
        onUpdate: () {
          addItem(formBuilder.bloc.getData());
        },
      ),
    ];
    if (error != null) {
      Map<Enum, String> errorObject = error as Map<Enum, String>;
      if (errorObject.containsKey(errorKey)) {
        children.add(ListError(error: errorObject[errorKey]!));
      }
    }
    if (bloc.getSelectionValue(selectionErrorKey)) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return SizeTransition(
      sizeFactor: CurvedAnimation(
        curve: Curves.fastOutSlowIn,
        parent: _controller,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  void addItem(dynamic item) {
    int size = bloc.getLength(errorKey);
    bloc.add(item, errorKey);
    if (bloc.getLength(errorKey) > size) {
      animatedListHelper.animateAdd(listKey);
    }
  }

  void updateItem(dynamic item, index) {
    int size = bloc.getLength(errorKey);
    bloc.update(item, index, errorKey);
    if (bloc.getLength(errorKey) != size) {
      animatedListHelper.animateRemove(listKey, index);
    }
  }

  void removeItem(int index) {
    bloc.remove(index, errorKey);
    AnimatedListHelper().animateRemove(listKey, index);
  }

  void setLabel();
  void setErrorKey();
  void setSelectionErrorKey();
  void setFormBuilder();

  CardTemplate getCard(
      BuildContext context, int index, Animation<double> animation);
}
