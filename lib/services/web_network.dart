import 'package:universal_html/html.dart' as html;


import 'package:open_file/open_file.dart';

class WebNetwork {

  WebNetwork();

  String downloadFromURL(String url) {
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
    return url;
  }

  

  void openFile(String path) {
    OpenFile.open(path);
  }
}