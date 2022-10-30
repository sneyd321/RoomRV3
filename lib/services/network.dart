import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:notification_app/business_logic/suggested_address.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../business_logic/address.dart';

class Network {
  Future<PredictedAddress> getPredictedAddress(placesId) async {
    final response = await http
        .get(Uri.parse('http://192.168.100.110:8087/place/$placesId'));
    print(response.body);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return PredictedAddress.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<String> downloadFromURL(String url, String fileName) async {
    HttpClient httpClient = HttpClient();
    String? filePath = '';
    try {
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        Uint8List bytes = await consolidateHttpClientResponseBytes(response);
        filePath = await getDownloadsPath(fileName);
        File file = File(filePath!);
        await file.writeAsBytes(bytes);
      } else {
        filePath = 'Error code: ' + response.statusCode.toString();
      }
    } catch (ex) {
      filePath = 'Can not fetch url';
    }
    return filePath;
  }

  Future<String?> getDownloadsPath(String fileName) async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return "${directory?.path}/$fileName";
  }

  

  void openFile(String path) {
    OpenFile.open(path);
  }
}
