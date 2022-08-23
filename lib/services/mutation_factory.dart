import 'package:graphql_flutter/graphql_flutter.dart';

class MutationFactory {


  MutationFactory();

  dynamic getDocument(String name) {
    MutationQuery? mutation;
    switch (name) {
      case "Add House":
        mutation = AddHouseMutationQuery();
    }
    if (mutation == null) {
      return gql("");
    }
    return gql(mutation.getQuery());
    
  }
}

abstract class MutationQuery {
  String getQuery();
}

class AddHouseMutationQuery extends MutationQuery {
  @override
  String getQuery() {
    return r"""
  mutation createHouse($houseInput: HouseInput!){
    createHouse(houseInput: $houseInput) {
      id,
      houseKey,
      firebaseId,
      lease{
        landlordInfo{
          fullName
        }
      }
    }
  }
  """;
  }
}
