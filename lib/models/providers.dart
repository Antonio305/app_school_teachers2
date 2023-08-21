import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../Services/generation_services.dart';
import '../Services/group_services.dart';
import '../Services/login_provider.dart';
import '../Services/semestre.dart';
import '../Services/student_services.dart';
import '../Services/subject_services.dart';
import '../Services/task_services.dart';
import '../Services/teacher_services.dart';
import '../providers/form_provider.dart';
import '../providers/form_teacher.dart';
import '../providers/menu_option_provider.dart';
import '../providers/thme_provider.dart';
import '../shared_preferences.dart/shared_preferences.dart';

class MyChangeNotifierProvider {

  static List<ChangeNotifierProvider> getProvider( BuildContext context,  Preferences  preferences) {
    List<ChangeNotifierProvider> providers = [
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

      
    ];

    return providers;
  }
}
