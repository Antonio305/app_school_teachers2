import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:preppa_profesores/Services/secure_storage.dart';
import 'package:preppa_profesores/models/host.dart';

import '../models/story.dart';

/// clase para envair o regiar las historia
///

class StoryServices extends ChangeNotifier {
  // para saber el estado de lepeiricion

  List<Storys> storys = [];
  List<Storys> storysByStatusTrue = [];

  final storage = SecureStorage.storage();

  bool status = false;

  // intancia del LOCALHOST
  String baserUrl = ConectionHost.baseUrl;

  // function by create stry

  Future<Response> myUrl(String path) async {
    /// create list type Story

    // Future createStory() async {
    String? token = await storage.read(key: 'token');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };

    // Uri urls = Uri.http(baserUrl, path);
    final urls = ConectionHost.myUrl(path, {});

    final resp = await http.get(urls);
    return resp;
  }

// for desktop
  Future<Map<String, dynamic>> createStory(
      String? contnet, DateTime expiredAt) async {
    // Future createStory() async {
    String? token = await storage.read(key: 'token');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };

    status = true;
    notifyListeners();

    final Map<String, dynamic> data = {
      "content": contnet,
      "expiredAt": expiredAt.toString()
    };
    // Uri url = Uri.http(baserUrl, '/api/story');
    final url = ConectionHost.myUrl('/api/story', {});
    print(url);
    final resp =
        await http.post(url, headers: headers, body: json.encode(data));

    Map<String, dynamic> respBody = json.decode(resp.body);
    print(respBody);
    status = false;
    notifyListeners();

    return respBody;
  }

  // get alll sory
  Future getAllStory() async {
    Response resp = await myUrl('/api/story');

    // final respBody = json.decode(resp.body)
    List<dynamic> respBody = json.decode(resp.body);

    final story = respBody.map((e) => Storys.fromJson(e)).toList();

    storys = [...story];
    notifyListeners();
    print(respBody);
  }

  // get all story by status true

  Future getAllStoryByStatusTrue() async {
    Response resp = await myUrl('/api/story/statusTrue');

    final respBody = json.decode(resp.body);
    final List<dynamic> stories = respBody['stories'];

    final story = stories.map((e) => Storys.fromJson(e)).toList();

    storysByStatusTrue = [...story];
    notifyListeners();
    print(respBody);
  }

  Future deleteStoryBySId(String id) async {
    // Response resp = await myUrl('/api/story/$id');
    String? token = await storage.read(key: 'token');

    // Uri url = Uri.http(baserUrl, '/api/story/$id');

    final url = ConectionHost.myUrl('/api/story/$id', {});

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };
    final resp = await http.delete(url, headers: headers);

    print(resp.body);
  }
}
