abstract class Field {
  String value = r"";

  Field(this.value);

  String getValue() {
    return value;
  }

  String? validate();
}



class Name extends Field {
  Name(String value) : super(value);

  @override
  String? validate() {
    if (value.isEmpty) {
      return "Please enter a name.";
    }
    return null;
  }
}

class City extends Field {
  City(String value) : super(value);

  @override
  String? validate() {
    if (value.isEmpty) {
      return "Please enter a city.";
    }
    return null;
  }
}

class POBox extends Field {
  POBox(String value) : super(value);

  @override
  String? validate() {
   
    return null;
  }
}

class PostalCode extends Field {
  PostalCode(String value) : super(value);

  @override
  String? validate() {
    if (value.isEmpty) {
      return "Please enter a postal code.";
    }
    RegExp regExp = RegExp(r"^[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJKLMNPRSTVWXYZ][ -]?\d[ABCEGHJKLMNPRSTVWXYZ]\d$");
    if (!regExp.hasMatch(value)) {
      return "Please enter a valid postal code.";
    }
    return null;
  }
}

class Province extends Field {
  Province(String value) : super(value);
 
  @override
  String? validate() {
    if (value.isEmpty) {
      return "Please enter a province.";
    }
    return null;
  }
}

class StreetName extends Field {
  StreetName(String value) : super(value);
  
  @override
  String? validate() {
    if (value.isEmpty) {
      return "Please enter a street name.";
    }
    return null;
  }
}

class StreetNumber extends Field {
  StreetNumber(String value) : super(value);
 
  @override
  String? validate() {
    if (value.isEmpty) {
      return "Please enter a street number.";
    }
    return null;
  }
}

class UnitName extends Field {
  UnitName(String value) : super(value);
 
  @override
  String? validate() {
    if (value.isEmpty) {
      return "Please enter a unit name.";
    }
    return null;
  }
}

class UnitNumber extends Field {
  UnitNumber(String value) : super(value);
 
  @override
  String? validate() {
    return null;
  }
}

class PaymentPeriod extends Field {
  PaymentPeriod(String value) : super(value);
 
  @override
  String? validate() {
    return null;
  }
}

class RentDueDate extends Field {
  RentDueDate(String name) : super(name);
  
  @override
  String? validate() {
    return null;
  }
}

class RentMadePayableTo extends Field {
  RentMadePayableTo(String name) : super(name);
 
  @override
  String? validate() {
    if (value.isEmpty) {
      return "Please enter who rent is made payable to.";
    }
    return null;
  }
}

class Email extends Field {
  Email(String name) : super(name);
  
  @override
  String? validate() {
    if (value.isEmpty) {
      return "Please enter an email.";
    }
    return null;
  }
}

class FirstName extends Field {
  FirstName(String value) : super(value);

  @override
  String? validate() {
    if (value.isEmpty) {
      return "Please enter a first name.";
    }
    return null;
  }

}

class LastName extends Field {
  LastName(String value) : super(value);

  @override
  String? validate() {
    if (value.isEmpty) {
      return "Please enter a last name.";
    }
    return null;
  }

}


class Password extends Field {
  Password(String value) : super(value);

  @override
  String? validate() {
    if (value.isEmpty) {
      return "Please enter a password";
    }
    return null;
  }
}

class ReTypePassword extends Field {
  ReTypePassword(String value) : super(value);

  @override
  String? validate() {
    if (value.isEmpty) {
      return "Please enter your password again";
    }
    return null;
  }

  @override
  String? validatePassword(String password) {
    if (value.isEmpty) {
      return "Please enter your password again";
    }
    if (value != password) {
      return "Please enter the same password";
    }
    return null;
  }
  


}

class HouseKey extends Field {
  HouseKey(String value) : super(value);

  @override
  String? validate() {
    if (value.isEmpty) {
      return "Please enter a house key.";
    }
    return null;
  }


}

class CommentField extends Field {
  CommentField(String value) : super(value);

  @override
  String? validate() {
    if (value.isEmpty) {
      return "Please enter a comment";
    }
    return null;
  }

}