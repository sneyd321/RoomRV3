import 'package:flutter/cupertino.dart';
import 'package:notification_app/lease/rent/rent_error_key.dart';
import 'package:notification_app/bloc/text/bloc_text.dart';


class TotalLawfulRentText extends BlocText {
  TotalLawfulRentText({TextStyle? textStyle, double? top, double? left, double? right, double? bottom, double? width})
      : super("", textStyle:textStyle, top: top, left: left, right: right, bottom: bottom, width: width);

  @override
  void setErrorKey() {
    errorKey = RentErrorKey.totalLawfulRent;
  }
  
  @override
  void setText() {
    text = "Total Rent (Lawful Rent): \$${bloc.getText(errorKey)}";
  }
}
