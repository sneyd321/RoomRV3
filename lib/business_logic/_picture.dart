import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Picture {
  File? _file;
  String? _imageUrl;

  Picture.fromFile(String filePath) {
    _file = File(filePath);
    _imageUrl = "";
  }

  Picture.fromUrl(String url) {
    _file = File("/");
    _imageUrl = url;
  }

  bool save() {
    return false;
  }

  String getPath() {
    return _file!.path;
  }

  String? getUrl() {
    return _imageUrl;
  }

  String encode() {
    return base64Encode(_file!.readAsBytesSync());
  }

  Future<String> encodeURL() async{
    http.Response response = await http.get(Uri.parse(_imageUrl!));
    final bytes = response.bodyBytes;
    if (bytes.isEmpty) {
      return Future.error("Image is empty");
    }
    return base64Encode(bytes);
   
  }

  String getBytes() {
    
    return _file!.readAsStringSync();
  }

  void load(String path) {
  
  }


}
