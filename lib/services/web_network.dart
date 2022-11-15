import 'dart:convert';

import 'package:universal_html/html.dart' as html;
import 'package:http/http.dart' as http;


import 'package:open_file/open_file.dart';

import '../business_logic/address.dart';

class WebNetwork {

  WebNetwork();
  


  String downloadFromURL(String url) {
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
    return url;
  }

  Future<PredictedAddress> getPredictedAddress(placesId) async {
    final response = await http.get(Uri.parse('https://address-service-s5xgw6tidq-uc.a.run.app/place/$placesId'));
    print(response.body);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return PredictedAddress.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  

  void openFile(String path) {
    OpenFile.open(path);
  }
}