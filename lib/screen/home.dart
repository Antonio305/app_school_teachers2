import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/Services.dart';
import '../Services/publication_services.dart';
import '../providers/isMobile.dart';
import '../providers/menu_option_provider.dart';
import '../widgets/content.dart';
import '../widgets/menu.dart';

// para verificvar el tipo d plataforma

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _HomePageState();
}

class _HomePageState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
    onLoading();
  }

  @override
  Widget build(BuildContext context) {
    //  studentServices.getStudents();

    final menuProvider = Provider.of<MenuOptionProvider>(context);

    return Scaffold(
      body: IsMobile.isMobile()
          ? const SafeArea(child: Content())
          : const Row(
              children: [
                Menu(),
                Content(),
              ],
            ),

      // creamos los botones de anajo

      bottomNavigationBar:
          IsMobile.isMobile() ? _navitgationButton(menuProvider) : null,
    );
  }

  // fuction que llamara a todos los metodos para inicializar la  aplicacion
  void onLoading() async {
    final menuOptionProvider =
        Provider.of<MenuOptionProvider>(context, listen: false);
    final groupServices = Provider.of<GroupServices>(context, listen: false);
    final generationServices =
        Provider.of<GenerationServices>(context, listen: false);
    final semestreServices =
        Provider.of<SemestreServices>(context, listen: false);
    final publicationServices =
        Provider.of<PublicationServices>(context, listen: false);
    final subjectServices =
        Provider.of<SubjectServices>(context, listen: false);
    await publicationServices.allPublicationByPagination();
    // await subjectServices.getSubjectsForTeacher();
    // print(subject);
    await generationServices.allGeneration();
    await semestreServices.allSemestre();
    await groupServices.allGroups();

    menuOptionProvider.dropdownMenuItemGroup =
        groupServices.group.groups.first.name;
    menuOptionProvider.dropDownMenuItemSubject =
        subjectServices.subjects.first.name;
    // await teachaerServices.getForId();
  }

  BottomNavigationBar _navitgationButton(MenuOptionProvider menuProvider) {
    return BottomNavigationBar(
        // backgroundColor: const Color(0XFF131428),
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
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'CHATS'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded), label: 'TUTOR'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded), label: 'PERFIL'),
        ]);
  }
}
