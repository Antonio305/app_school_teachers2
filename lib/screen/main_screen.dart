import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:preppa_profesores/screen/publication/all_publications.dart';
import 'package:preppa_profesores/screen/publication/list_publication.dart';
import 'package:preppa_profesores/screen/publication/show_publication.dart';
import 'package:preppa_profesores/screen/student/information_student.dart';
import 'package:preppa_profesores/screen/student/list_student.dart';
import 'package:preppa_profesores/screen/student/list_studentByGrade.dart';
import 'package:preppa_profesores/screen/student/showInfStudentByTeacher.dart';
import 'package:preppa_profesores/screen/task/alL_taskStatusTrue.dart';
import 'package:preppa_profesores/screen/task/allTask_Qualify.dart';
import 'package:preppa_profesores/screen/task/all_task.dart';
import 'package:preppa_profesores/screen/task/all_task_subject.dart';
import 'package:preppa_profesores/screen/task/create_taks.dart';
import 'package:preppa_profesores/screen/task/studentTaskReceived.dart';
import 'package:preppa_profesores/screen/task/taskReceived.dart';
import 'package:preppa_profesores/screen/teacher/create_teacher.dart';
import 'package:preppa_profesores/screen/view_pdf.dart';
import 'package:provider/provider.dart';

import '../Services/Services.dart';
import '../Services/push-NotificationServices.dart';
import '../Services/taskReceived.dart';
import '../models/taskReceived.dart';
import '../providers/thme_provider.dart';
import 'chat/groupChat.dart';
import 'chat_page.dart';
import 'chat_page_body.dart';
import 'check_auth_screen.dart';
import 'information_subjects.dart';
import 'login/login.dart';
import 'screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MyAppState();
}

class _MyAppState extends State<MainScreen> {
  ///  controldor para un scaffold y para las ruta
  ///  en la cual dependiendo del parametro que recive es la que se mostrara la vista
  /// recivimos um para en la clase PushNotificacion en la ucal contiene los datos de la tarea , y la ruta en la cual se mostrar la tarea recivida

  // controller sccaffol message
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerState =
      GlobalKey<ScaffoldMessengerState>();
  // ccontroller router
  final GlobalKey<NavigatorState> navigateKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    notification();
  }

  /// Funcion que se ejecuata cuando inicia la aplicacion

  void notification() {
    // la funcion siemrpe recive un mapa, la cual es la que se transmite en el Stream
    PushNotificationServices.streamMessage.listen((message) async {
      final taskReceivedServices =
          Provider.of<TaskReceivedServices>(context, listen: false);
      final loginS = Provider.of<LoginServices>(context, listen: false);

      // print('Datos de la notificacion en el stream');
      // print(message);

      Map<String, dynamic> taskReceived = json.decode(message['taskReceived']);

      taskReceivedServices.taskReceivedSelected =
          TaskReceived.fromJson(taskReceived);

      // antes de ir a una vista verificar si tenemos  token y si aun es valido , caso contrario ir ala vista del login
      // bool isValidToken = await loginS.isValidToekn();
      bool isValidToken = await loginS.isValidToekn();

      if (isValidToken == true) {
        navigateKey.currentState?.pushNamed(message['route']);
        return;
      } else {
        navigateKey.currentState?.pushNamed(message['login']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Codigo para el tema anterior
      // theme: themeProvider.currentTheme,
      theme: Provider.of<ThemeProvier>(context).currentTheme == ThemeData.dark()
          ? ThemeData.dark(
              useMaterial3: true,
            )
          : ThemeData.light(
              useMaterial3: true,
            ),
      navigatorKey: navigateKey,
      //  scaffoldMessengerKey: sca,
      initialRoute: 'check_auth_screen',
      // initialRoute: 'home',

      routes: {
        'home': (_) => const DashBoard(),
        'check_auth_screen': (_) => const CheckAuthScreen(),
        'login': (_) => const LoginScreen(),

        // VISTAS para todas las tareas por todas las materiad
        'allTask': (_) => const ScreenAllTask(),
        'allTaskStatusTrue': (_) => const ScreenAllTaskStatusTrue(),
        'allTaskSubject': (_) => const ScreenAllTaskSubject(),
        // vista para la lista de estudiantes que entregaron tareas para calificar

        'studentTasktReceived': (_) => const StudentTasktReceived(),
        // by mobile
        // para calificar tarea o la tarea recivida solo pur un estudiante

        'taskReceived': (_) => const ScreenGradeAssignments(),
        'allTask_qualify': (_) => const ScreenAllTaskTeceived(),
        'create_task': (_) => const ScreenCreateTask(),

        /**
   * students
  */
        'detail_student': (_) => const DetailStudent(),
        // student for tutor
        'list_student': (_) => const ScreenListStudent(),
        'list_studentByGrades': (_) => const ScreenListStudentByGrades(),
        // para mostar la lsita de las publicaciones
        'list_publication': (_) => const ListPublicationScreen(),
        'show_studentByTeacher': (_) => const ShowStudentByTeacher(),

        // paRA LA INFORMACION DE LA MATERA
        'information_subject': (_) => const ScreenInformationSubjects(),
        // chats
        // CHATS CON TODO EL GRUPO
        'groupChat': (_) => const ScreenGroupChat(),
        // chats entre el profesor y el alumno
        'chats_movil': (_) => const ChatPageBodyMovil(),
        //ruta para editar las tareas

        'chats': (_) => const ChatPage(),

        /**
         * routrs publications 
         */
        'list_publications': (_) => const ScreenListPublications(),
        'show_publications': (_) => const ShowPublication(),

        /**
         * tezchcers
         */
        'create_teacher': (_) => const ScreenRegisterTeacher(),
        'view_pdf': (_) => const ScreenViewPdf()
      },
    );
  }
}
