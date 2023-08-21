import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/adviseAndTutor.dart';
import 'package:preppa_profesores/Services/chat/socket_servives.dart';
import 'package:preppa_profesores/Services/publication_services.dart';
import 'package:preppa_profesores/Services/rating_services.dart';
import 'package:preppa_profesores/Services/story_services.dart';
import 'package:preppa_profesores/Services/taskReceived.dart';
import 'package:preppa_profesores/Services/task_services.dart';
import 'package:preppa_profesores/models/providers.dart';
import 'package:preppa_profesores/providers/form_provider.dart';
import 'package:preppa_profesores/providers/menu_option_provider.dart';
import 'package:preppa_profesores/providers/response_notifier.dart';
import 'package:preppa_profesores/providers/selectDateTime.dart';
import 'package:preppa_profesores/providers/thme_provider.dart';
import 'package:preppa_profesores/screen/alL_taskStatusTrue.dart';
import 'package:preppa_profesores/screen/allTask_Qualify.dart';
import 'package:preppa_profesores/screen/all_task.dart';
import 'package:preppa_profesores/screen/all_task_subject.dart';
import 'package:preppa_profesores/screen/chat/groupChat.dart';
import 'package:preppa_profesores/screen/chat_page.dart';
import 'package:preppa_profesores/screen/check_auth_screen.dart';
import 'package:preppa_profesores/screen/create_taks.dart';
import 'package:preppa_profesores/screen/group.dart';
import 'package:preppa_profesores/screen/home.dart';
import 'package:preppa_profesores/screen/information_subjects.dart';
import 'package:preppa_profesores/screen/list_publication.dart';
import 'package:preppa_profesores/screen/list_student.dart';
import 'package:preppa_profesores/screen/list_studentByGrade.dart';
import 'package:preppa_profesores/screen/login.dart';
import 'package:preppa_profesores/screen/information_student.dart';
import 'package:preppa_profesores/screen/studentTaskReceived.dart';
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

  runApp(MultiProvider(providers: [
    //  MyChangeNotifierProvider.getProvider(preferences),
    //  ChangeNotifierProvider(   create: (_) => ThemeProvier(isDarkMode: preferences.getIsDarkMode)),

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
    ChangeNotifierProvider(create: (_) => TeacherFormProvider()),
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
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final mycolor = const MaterialColor(
    0xFF0F1123,
    <int, Color>{
      50: Color(0xFF0F1123),
      100: Color(0xFF0F1123),
      200: Color(0xFF0F1123),
      300: Color(0xFF0F1123),
      400: Color(0xFF0F1123),
      500: Color(0xFF0F1123),
      600: Color(0xFF0F1123),
      700: Color(0xFF0F1123),
      800: Color(0xFF0F1123),
      900: Color(0xFF0F1123),
    },
  );
  @override
  Widget build(BuildContext context) {
//  final themeProvier = Provider.of<ThemeProvier>(context);
    final themeProvider = Provider.of<ThemeProvier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.currentTheme == ThemeData.light()
          ? ThemeData.light()
          : ThemeData(
              // platform: TargetPlatform.windows,
              useMaterial3: true,
              primaryColorDark: mycolor,
              primarySwatch: mycolor,
              colorScheme: const ColorScheme.dark(),
              scaffoldBackgroundColor: mycolor,
              dialogBackgroundColor: const Color(0xFF0F1123)),

      // theme: Provider.of<ThemeProvier>(context).currentTheme,
      // theme: ThemeData(
      //   // platform: TargetPlatform.windows,
      //   useMaterial3: true,
      //   primaryColorDark: mycolor,
      //   primarySwatch: mycolor,
      //   scaffoldBackgroundColor: mycolor,
      //   dialogBackgroundColor: Color(0xFF0F1123)

      //   ),

      // initialRoute: AppRoute.initialRoute,
      // routesmain: AppRoute.routes,

      initialRoute: 'check_auth_screen',
      // initialRoute: 'home',

      routes: {
        'home': (_) => const HomePage(),
        'check_auth_screen': (_) => const CheckAuthScreen(),
        'login': (_) => const LoginScreen(),
        'allTask': (_) => const ScreenAllTask(),
        'allTaskStatusTrue': (_) => const ScreenAllTaskStatusTrue(),
        'allTaskSubject': (_) => const ScreenAllTaskSubject(),
        'studentTasktReceived': (_) => const StudentTasktReceived(),
        'allTask_qualify': (_) => const ScreenAllTaskTeceived(),
        'create_task': (_) => const ScreenCreateTask(),
        'content_data_student': (_) => const ContentDataStudent(),
        // student for tutor
        'list_student': (_) => const ScreenListStudent(),
        'list_studentByGrades': (_) => const ScreenListStudentByGrades(),
        // para mostar la lsita de las publicaciones
        'list_publication': (_) => const ListPublicationScreen(),

        // paRA LA INFORMACION DE LA MATERA
        'information_subject': (_) => const ScreenInformationSubjects(),
        // chats
        // CHATS CON TODO EL GRUPO
        'groupChat': (_) => ScreenGroupChat(),
        // chats entre el profesor y el alumno

        'chats': (_) => const ChatPage(),
      },
    );
  }
}
