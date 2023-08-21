// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;


// class UserServices {
//   // creaermos ua funcion normal, sin usar ChangeNotifer y

//   Future<List<User>> getUser() async {
//     // String? token = await LoginServices.getToken();
//     String? token = await loginServices. 

//     Map<String, String> headers = {
//       'Content-Type': 'application/json',
//       'x-token': token!
//     };
//     //
//     try {
//       String baseUrl = '192.168.1.73:3000';
//       final url = Uri.http(baseUrl, '/api/users');

//       final resp = await http.get(url, headers: headers);
//       Map<String, dynamic> respBody = json.decode(resp.body);
//       print(resp.body);

//       final users = UsersResponse.fromJson(respBody);
//       return users.user;
//     } catch (e) {
//       // si todo  sale mal hacemos un retorno de una lista vacia
//       return [];
//     }
//   }
// }
