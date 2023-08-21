import 'dart:convert';

import 'package:http/http.dart' as http;

class GetUriList {
  /// function para recivbir la lita de la url

  static List<String> picsum() {
    List<String> urlList = [];

    for (var i = 100; i < 105; i++) {
      urlList.add('https://picsum.photos/seed/$i/800/400');
    }

    return urlList;
  }

  static Future<List<String>> theta() async {
    List<String> urlList = [];
    print('getting url from theta');

    // first get list offile with imformation
    // Primero obtenga una lista de archivos con información sobre cada archivo
    Uri uri = Uri.http('192.168.1.69', '/osc/commands/execute');

    var body = {
      'fileType': 'camera.listFIles',
      'parameters': {
        'entryCount': 5,
        'maxThumbSize': 0,
      }
    };

    var headers = {'Content-Type': 'application/json;charset=utf-8'};
    var response =
        await http.post(uri, headers: headers, body: jsonEncode(body));

     var fileMap  = jsonDecode(response.body);
     var entriesList = fileMap['results']['entries'];   
     
      for (var entry in entriesList) {
          urlList.add(entry['fileUrl']);
      }
      return urlList;

     }   

}
