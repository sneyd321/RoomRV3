class Mutations {
  String getMutation(String name) {
    switch (name) {
      case "createHouse":
        return createHouse();
      case "createLandlord":
        return createLandlord();
      case "loginLandlord":
        return loginLandlord();
    }
    return "";
  }

  String createHouse() {
    return r"""
  mutation createHouse($id: Int!, $leaseInput: LeaseInput!){
    createHouse(id: $id, leaseInput: $LeaseInput) {
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

  String createLandlord() {
    return r"""
mutation createLandlord($landlord: LandlordInput!) {
  createLandlord(landlord: $landlord) {
    firstName,
    lastName,
    email,
    deviceId
  }
}
""";
  }

  String loginLandlord() {
    return r"""
mutation ($login: LoginLandlordInput!){
  loginLandlord(login: $login){
    firstName,
    lastName,
    email, 
    deviceId
  }
}
    """;
  }
}
