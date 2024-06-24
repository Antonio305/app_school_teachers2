import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:preppa_profesores/Services/adviseAndTutorServices.dart';
import 'package:preppa_profesores/Services/chat/socket_servives.dart';
import 'package:preppa_profesores/Services/publication_services.dart';
import 'package:preppa_profesores/Services/push-NotificationServices.dart';
import 'package:preppa_profesores/Services/rating_services.dart';
import 'package:preppa_profesores/Services/saveFileServices.dart';
import 'package:preppa_profesores/Services/story_services.dart';
import 'package:preppa_profesores/Services/taskReceived.dart';
import 'package:preppa_profesores/Services/task_services.dart';
import 'package:preppa_profesores/Services/uploadFile.dart';
import 'package:preppa_profesores/models/taskReceived.dart';
import 'package:preppa_profesores/providers/form_provider.dart';
import 'package:preppa_profesores/providers/menu_option_provider.dart';
import 'package:preppa_profesores/providers/response_notifier.dart';
import 'package:preppa_profesores/providers/selectDateTime.dart';
import 'package:preppa_profesores/providers/thme_provider.dart';
import 'package:preppa_profesores/screen/main_screen.dart';
import 'package:preppa_profesores/screen/student/showInfStudentByTeacher.dart';
import 'package:preppa_profesores/screen/task/taskReceived.dart';
import 'package:preppa_profesores/screen/task/alL_taskStatusTrue.dart';
import 'package:preppa_profesores/screen/task/allTask_Qualify.dart';
import 'package:preppa_profesores/screen/publication/all_publications.dart';
import 'package:preppa_profesores/screen/task/all_task.dart';
import 'package:preppa_profesores/screen/task/all_task_subject.dart';
import 'package:preppa_profesores/screen/chat/groupChat.dart';
import 'package:preppa_profesores/screen/chat_page.dart';
import 'package:preppa_profesores/screen/chat_page_body.dart';
import 'package:preppa_profesores/screen/check_auth_screen.dart';
import 'package:preppa_profesores/screen/task/create_taks.dart';
import 'package:preppa_profesores/screen/home.dart';
import 'package:preppa_profesores/screen/information_subjects.dart';
import 'package:preppa_profesores/screen/publication/list_publication.dart';
import 'package:preppa_profesores/screen/student/list_student.dart';
import 'package:preppa_profesores/screen/student/list_studentByGrade.dart';
import 'package:preppa_profesores/screen/login/login.dart';
import 'package:preppa_profesores/screen/student/information_student.dart';
import 'package:preppa_profesores/screen/task/screenEditTask.dart';
import 'package:preppa_profesores/screen/publication/show_publication.dart';
import 'package:preppa_profesores/screen/task/show_task.dart';
import 'package:preppa_profesores/screen/task/studentTaskReceived.dart';
import 'package:preppa_profesores/screen/teacher/create_teacher.dart';
import 'package:preppa_profesores/screen/view_pdf.dart';
import 'package:preppa_profesores/shared_preferences.dart/shared_preferences.dart';
import 'package:provider/provider.dart';
// import 'firebase_options.dart';

// lista de todos los servicios
import 'Services/Services.dart';
import 'Services/chat/chat_services.dart';
import 'Services/studentByAdviser.dart';
import 'providers/form_teacher.dart';

void main() async {
  // aca vamos a inicalizar el shared PREFERENCES

  WidgetsFlutterBinding.ensureInitialized();
  final preferences = Preferences();
  await preferences.initPreferences();

  // solo ejecura la funcion si estoy en Android o en Ios

  if (Platform.isAndroid || Platform.isIOS) {
    // await Firebase.initializeApp();
    PushNotificationServices.inializedApp();
  }

//  await  initializeDateFormatting('es', 'MX').then((_) =>
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuOptionProvider()),
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
        ChangeNotifierProvider(create: (_) => LoginServices()),
        ChangeNotifierProvider(
            create: (_) => ThemeProvier(isDarkMode: preferences.getIsDarkMode)),
        ChangeNotifierProvider(create: (_) => SemestreServices()),
        ChangeNotifierProvider(create: (_) => GroupServices()),
        ChangeNotifierProvider(create: (_) => GenerationServices()),

        // subjects ( materia)
        ChangeNotifierProvider(create: (_) => SubjectServices()),
        // materias
        ChangeNotifierProvider(create: (_) => TeachaerServices()),
        // ChangeNotifierProvider(create: (_) => TeacherFormProvider()),
        ChangeNotifierProvider(create: (_) => StudentServices()),

        // prviderp para la teareas
        ChangeNotifierProvider(create: (_) => TaskServices()),

        //  for teacher

        //  task received
        ChangeNotifierProvider(create: (_) => TaskReceivedServices()),

        // dowoloadimage

        ChangeNotifierProvider(create: (_) => ResponseNotifier()),

        // Notifier para las calificaciones
        ChangeNotifierProvider(create: (_) => RatingServices()),

        //  el turo pude ver los datos de los estudianes
        ChangeNotifierProvider(create: (_) => StudentAdviserServices()),

        // para obtener los datos  de los alumnos que son tutores
        ChangeNotifierProvider(create: (_) => AdviserTutorServices()),

        // TACHER
        ChangeNotifierProvider(create: (_) => TeachaerServices()),

        // para la seleccio de la calificaciones
        ChangeNotifierProvider(create: (_) => SelectDateTime()),
        // adviser turo se4rviees
        ChangeNotifierProvider(create: (_) => AdviserTutorServices()),

        /// provier pa4ra las publicaciones
        ChangeNotifierProvider(create: (_) => PublicationServices()),

        // para las historias
        ChangeNotifierProvider(create: (_) => StoryServices()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => ChatServices()),
        // Class by upload Files
        ChangeNotifierProvider(create: (_) => UploadFileServices()),
        // save file
        ChangeNotifierProvider(create: (_) => SaveFileInLocalProvider())
      ],
      child: const MainScreen(),
    ),
  );
  //  )
}
