import 'package:flutter/material.dart';
import 'package:preppa_profesores/widgets/gradableButon.dart';
import 'package:provider/provider.dart';

import '../Services/Services.dart';
import '../providers/menu_option_provider.dart';
import '../widgets/content.dart';
import '../widgets/menu.dart';

// para verificvar el tipo d plataforma
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    onLoading();
  }

  @override
  Widget build(BuildContext context) {
    //  studentServices.getStudents();

    final menuProvider = Provider.of<MenuOptionProvider>(context);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //  NO mostar si es con windows
      // drawer: const Menu(),

      // backgroundColor: Color(0xFF0F1123),

      // appBar: AppBar(
      //   // backgroundColor: Colors.transparent,
      //   title: const Center(
      //     child: Text('Para los profesores'),
      //   ),
      // ),

      body:
          //  Container(j
          //   color: Colors.red,
          //   width: 300,
          //   height: 300,
          // ),
          Platform.isMacOS || Platform.isWindows
              ? Row(
                  // mainAxisSize: MainAxisSize.min,
                  // botones de lavegacio del  lado izquirdo
                  children: [
                    const Menu(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Content(size: size),
                    ),
                  ],
                )
              : Content(size: size),

      // creamos los botones de anajo

      bottomNavigationBar: Platform.isMacOS || Platform.isWindows
          ? const SizedBox(width: 0, height: 0,)
          : _navitgationButton(menuProvider),

      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
// sol oesta linea funciona

      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // floatingActionButton: DraggableButton(),

      // // floatingActionButton:
      // FloatingActionButton.extended(
      //   onPressed: () {},
      //   label: const Text('CHATS'),Y
    );
  }

  // fuction que llamara a todos los metodos para inicializar la  aplicacion
  void onLoading() async {
    final groupServices = Provider.of<GroupServices>(context, listen: false);
    final generationServices =
        Provider.of<GenerationServices>(context, listen: false);

    // lista de materias
    final subjectServices =
        Provider.of<SubjectServices>(context, listen: false);

    // FIRST GET INFIRMATION TEACHER
    final teachaerServices =
        Provider.of<TeachaerServices>(context, listen: false);

    final semestreServices =
        Provider.of<SemestreServices>(context, listen: false);

    await subjectServices.getSubjectsForTeacher();

    // print(subject);
    await generationServices.allGeneration();

    await semestreServices.allSemestre();

    await groupServices.getGroupForId();

    await teachaerServices.getForId();
  }

  BottomNavigationBar _navitgationButton(MenuOptionProvider menuProvider) {
    return BottomNavigationBar(
        backgroundColor: const Color(0XFF131428),
        currentIndex: menuProvider.itemMenuGet,
        elevation: 0,
        enableFeedback: true,
        iconSize: 20,
        type: BottomNavigationBarType.fixed,
        //  landscapeLayout: ,
        showSelectedLabels: true,
        // showUnselectedLabels: false,
        onTap: (int index) {
          menuProvider.itemMenu = index;
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'INICIO'),
          BottomNavigationBarItem(
              icon: Icon(Icons.system_security_update_warning_outlined),
              label: 'ALUMNO'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'TAREA'),
          // BottomNavigationBarItem(
          // icon: Icon(Icons.schedule), label: 'HORARIOS'),
          // BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'CAHTS'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded), label: 'TUTOR'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded), label: 'PERFIL'),
        ]);
  }
}
