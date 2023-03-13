import 'package:flutter/cupertino.dart';
import 'package:notification_app/bloc/bloc.dart';

abstract class FormItem {
  late Bloc bloc;
  late TickerProvider tickerProvider;

  double? top;
  double? left;
  double? right;
  double? bottom;
  double? width;

  FormItem({this.top, this.left, this.right, this.bottom, this.width});


  void setBloc(Bloc bloc) {
    this.bloc = bloc;
  }

  void setTickerProvider(TickerProvider tickerProvider) {
    this.tickerProvider = tickerProvider;
  }


  Widget build(Object? error);

  void dispose();
}
