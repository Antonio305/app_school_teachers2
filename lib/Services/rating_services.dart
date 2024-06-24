// para ingresar las tareas jejeje
//  vamos ha extender del change notifier
// es parte de material de flutter

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:preppa_profesores/Services/secure_storage.dart';
import 'package:preppa_profesores/models/host.dart';
import 'package:preppa_profesores/models/rating.dart';

import '../models/student_byGrades.dart';

class RatingServices extends ChangeNotifier {
  // creaer un varialba de tipo bool para verficar el estaso de la consulta
  bool status = false;

// intancia de la url
  String baseUrl = ConectionHost.baseUrl;

//  para obtener todas las califcaciones
  List<Ratings> ratings = [];

  List<StudentByGrades> studentByRating = [];

// instancia de la clase
  Ratings rating = Ratings(
      id: '',
      group: '',
      student: '',
      semestre: '',
      subject: '',
      parcial1: 0.0,
      parcial2: 0.0,
      parcial3: 0.0,
      semesterGrade: 0.0,
      v: 0,
      generation: '');
// CRUD

  // INSTANCIA DEL STORAGE PARA OBBTENER ELE TOKEN GUARDADO EN LA BASE DE DATOS
  final storage = SecureStorage.storage();

//Todas las calificaciones
  Future getRatings() async {
    // create url

    final url = Uri.http(baseUrl, '/api/rating');
    final resp = await http.get(url);

    // dcodificacion del string
    final List<dynamic> respBody = json.decode(resp.body);

    // studentByRating = respBody.map((e) => StudentByGrades.fromJson(e)).toList();
    // print(respBody);
  }

  late RatingResponse ratingResponse;
  int statusCodes = 0;
// calificacion por materia
  Future getRatingsForSubject(String idStudent, String idSubject) async {
    String? token = await storage.read(key: 'token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };
/**
 * paramtros : ID STUDENT- ID SUBJECT
 */

    // final url = Uri.http(baseUrl, '/api/rating/$idStudent/$idSubject/rating');
    final url = ConectionHost.myUrl(
        '/api/rating/teacher/$idStudent/$idSubject/rating', {});

    status = true;
    notifyListeners();
    // print(url);
    final resp = await http.get(url, headers: headers);

    // dcodificacion del string
    final Map<String, dynamic> respBody = json.decode(resp.body);
    if (resp.statusCode == 401) {
      // ratingResponse.rating = ;
      status = false;

      statusCodes = 401;
      notifyListeners();
    }
    if (resp.statusCode == 404) {
      status = false;
      statusCodes = 404;
      notifyListeners();
    }
    if (resp.statusCode == 200) {
      ratingResponse = RatingResponse.toJson(resp.body);
      statusCodes = 200;
      status = false;
      notifyListeners();
    }
  }

  // metodo para ingredaingres5ar las calificaciones
  Future postRating(Ratings rating) async {
    // paramtros
    // group,
    // subject,
    // student,
    // calificacio puede ser opcionales
    // calificaciones - parcial1, parcial2, parcial3
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    // final url = Uri.http(baseUrl, '/api/rating');
    final url = ConectionHost.myUrl('/api/rating', {});

    final resp = await http.post(url,
        headers: headers, body: json.encode(rating.toMap()));

    final respBOdy = json.decode(resp.body);
    print(respBOdy);
  }

// upadate rating
  Future updateRating(String idRating, double partial1, double partial2,
      double partial3, double semesterGrade) async {
    String? token = await storage.read(key: 'token');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };
    // final url = Uri.http(baseUrl, '/api/rating/teacher/idRating/rating');

    final url = ConectionHost.myUrl('/api/rating/teacher/$idRating/rating', {});

    Map<String, dynamic> data = {
      'parcial1': partial1,
      'parcial2': partial2,
      'parcial3': partial3,
      'semesterGrade': semesterGrade
    };
// esto es lo mas loco que he hechio en mi viada
    final resp = await http.put(url, headers: headers, body: json.encode(data));

    print(resp.body);
  }

  // CREATET FUNCTION FOR GET STUDENT BY RATINGS
  // GET STUDENT BY RATINGS

// MEJROES CALIFICACIONES
  void getStudentByBetterGrades(String idGroup, String idSubject,
      String partial, String generation) async {
    String? token = await storage.read(key: 'token');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      "x-token": token!
    };

    /// add status
    status = true;
    notifyListeners();

    // final url = Uri.http(baseUrl,
    //     '/api/rating/teacher/$idGroup/$idSubject/$partial/betterGrades');

    final url = ConectionHost.myUrl(
        '/api/rating/teacher/$idGroup/$idSubject/$partial/$generation/betterGrades',
        {});

    final resp = await http.get(url, headers: headers);

    Map<String, dynamic> respBody = json.decode(resp.body);
    print(respBody);

    if (resp.statusCode == 404) {
      studentByRating = [];
      status = false;
      notifyListeners();
    }
    if (resp.statusCode == 200) {
      List<dynamic> studentRatings = respBody['ratings'];
      final studentRating =
          studentRatings.map((e) => StudentByGrades.fromJson(e)).toList();
      studentByRating = [...studentRating];

      status = false;
      notifyListeners();
    }
  }

// CALIFICACIONES  REGULARES
  void getStudentByAverageGrades(
      String idGroup, String idSubject, String partial) async {
    String? token = await storage.read(key: 'token');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      "x-token": token!
    };

    // final url = Uri.http(baseUrl,
    //     '/api/rating/teacher/$idGroup/$idSubject/$partial/averageGrades');
    final url = ConectionHost.myUrl(
        '/api/rating/teacher/$idGroup/$idSubject/$partial/averageGrades', {});

    final resp = await http.get(url, headers: headers);
    // creamos un lista para mostar los datos
    // la cuales es una lsita de los alumnos

    // final respBody = json.decode(resp.body);
    final List<dynamic> respBody = json.decode(resp.body);
    final studentRating =
        respBody.map((e) => StudentByGrades.fromJson(e)).toList();

    studentByRating = [...studentRating];
    notifyListeners();
    print(respBody);
  }

  //V CALIFICACIONES REPROBATORIOS
  void getStudentByFailingGrades(
      String idGroup, String idSubject, String partial) async {
    String? token = await storage.read(key: 'token');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      "x-token": token!
    };

    // final url = Uri.http(baseUrl,
    //     '/api/rating/teacher/$idGroup/$idSubject/$partial/failingGrades');
    final url = ConectionHost.myUrl(
        '/api/rating/teacher/$idGroup/$idSubject/$partial/failingGrades', {});

    final resp = await http.get(url, headers: headers);

    final List<dynamic> respBody = json.decode(resp.body);
    final studentRating =
        respBody.map((e) => StudentByGrades.fromJson(e)).toList();

    studentByRating = [...studentRating];
    notifyListeners();
    print(respBody);
  }
}
