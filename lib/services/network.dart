import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:notification_app/business_logic/suggested_address.dart';
import '../business_logic/address.dart';

class Network {

  Future<LandlordAddress> getLandlordAddress(placesId) async {
    final response = await http
        .get(Uri.parse('http://192.168.100.110:8087/place/$placesId'));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return LandlordAddress.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<RentalAddress> getRentalAddress(placesId) async {
    final response = await http
        .get(Uri.parse('http://192.168.100.110:8087/place/$placesId'));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return RentalAddress.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

}
