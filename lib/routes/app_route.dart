import 'package:flutter/material.dart';
import 'package:preppa_profesores/models/menu_option.dart';
import 'package:preppa_profesores/screen/group.dart';
import 'package:preppa_profesores/screen/student.dart';
import '../models/subjects.dart';
import '../screen/chat_page.dart';
import '../screen/screen.dart';
import '../screen/task.dart';
import '../screen/tutor.dart';

class AppRoute {
  // haremos una modiificacion ala rutas en la cual la definoremos como una lista de
  // toos los mewnu de opciones
  static final routes = <OptionMenu>[
    OptionMenu(
        route: 'home',
        icon: Icons.home,
        name: 'Home Page',
        screen: const HomePage()),
    OptionMenu(
        route: 'Students',
        icon: Icons.security_update_warning_sharp,
        name: 'Alumnos',
        screen: const ScreenStudent()),
    // OptionMenu(
    //     route: '',
    //     icon: Icons.theater_comedy_sharp,
    //     name: 'Profresores',
    //     screen: const Profile()),

    OptionMenu(
        route: 'task',
        icon: Icons.task,
        name: 'Tareas',
        screen: const ScreenTask()),
    // OptionMenu(
    //     route: 'Horarios',
    //     icon: Icons.horizontal_distribute_outlined,
    //     name: 'Horarios',
    //     screen: Horarios()),

    // Button para la opcion del os grupos
    OptionMenu(
        route: 'chats',
        icon: Icons.group,
        name: 'Chats',
        screen: const ScreenChat()),
    OptionMenu(
        route: 'tutor',
        icon: Icons.add,
        name: "Tutor",
        screen: const TutorScreen()),
      
        // OptionMenu(
        // route: 'cha',
        // icon: Icons.add,
        // name: "Chats",
        // screen: ChatPage()),
    OptionMenu(
        route: 'profile',
        icon: Icons.person_outline_rounded,
        name: 'PERFIL',
        screen: const ProfileTeacher())
  ];

  static const initialRoute = 'home';

  static Map<String, Widget Function(BuildContext)> routes2 = {
    'login': (context) => const HomePage(),
  };
}
