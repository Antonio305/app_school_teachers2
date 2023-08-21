import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:preppa_profesores/models/host.dart';
// import 'package:http/http.dart';

// clase para mostar las imagens  y subir las imagents

String baseURL = 'localhost:8080';

class UploadFiles {
  static Future getFiles() async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)'
    };
    // var url = Uri.parse(
    //     'localhost:8080/api/uploadFile/63da40d952024d24cee2bcdf/task');
    // final url =
    //     Uri.http(baseURL, '/api/uploadFile/63da40d952024d24cee2bcdf/task');
    
    final   url = ConectionHost.myUrl('/api/uploadFile/63da40d952024d24cee2bcdf/task',{});

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    // final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      // print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }


  static get3() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://farm2.staticflickr.com/1958/44899852384_cdebe59438_o.jpg'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
