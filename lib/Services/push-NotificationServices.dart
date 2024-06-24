import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:path/path.dart';
import 'package:preppa_profesores/Services/login_provider.dart';
import 'package:preppa_profesores/models/host.dart';

import '../firebase_options.dart';
import '../models/tokenFCM.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class PushNotificationServices {
  late LoginServices loginServices;
  static String? tokenFCM;

  // Create instance firebase

  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  // controlador para estar transmiento los mensajes la cual estaremos transmitiendo mapas
  static final StreamController<Map<String, dynamic>> _messageStreamController =
      StreamController.broadcast();
  //Fucntino que retorna la instancia de stream
  static Stream<Map<String, dynamic>> get streamMessage {
    return _messageStreamController.stream;
  }

// funcines para cara estado de la aplicaccion
// segundo plano
  static Future _backgroundHandler(RemoteMessage message) async {
    _messageStreamController.add(message.data);
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    _messageStreamController.add(message.data);
  }

  static Future _onOpenMessageHandler(RemoteMessage message) async {
    _messageStreamController.add(message.data);
  }

  static inializedApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

// To create a new Messaging instance call the instance getter on FirebaeMessagineg
    FirebaseMessaging messaging = FirebaseMessaging.instance;

/**
 * get web tokens
 *  use the returned tokenFCM to send messages to users from your custom server
 *  use el tokenFCM devuelto para enviar mensajes a los usuarios desde su servidor personalizado
 */

    tokenFCM = await messaging.getToken();
    TokenFCM.setTokenFcm = tokenFCM!;

    print(tokenFCM);
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpenMessageHandler);
  }


  // funcion para agregar el token de casa profesor
  static Future addTokenTeacher() async {
    String typeUser = 'TEACHER';
    // preguntamos si tenemos token
    String? token = await LoginServices.getToken();
    // SI el token es vacio no hacer nada
    if (token!.isEmpty) {
      return null;
    } else {
      final url = ConectionHost.myUrl('/api/tokenFCM/teacher/addTokenFCM', {});

      final Map<String, String> headers = {
        'content-Type': 'application/json',
        'x-token': token
      };
      Map<String, dynamic> body = {'tokenFCM': TokenFCM.getTokeFcm};

      final resp =
          await http.put(url, headers: headers, body: json.encode(body));

      final respBody = json.decode(resp.body);
      print(respBody);
    }
  }

  // fucion para cerrar el strema, no se llamara solo que no marque error
  void closeStream() {
    _messageStreamController.close();
  }
}
