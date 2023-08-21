import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:preppa_profesores/Services/login_provider.dart';
import 'package:preppa_profesores/providers/menu_option_provider.dart';
import 'package:preppa_profesores/providers/thme_provider.dart';
import 'package:preppa_profesores/routes/app_route.dart';

import '../shared_preferences.dart/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int itemSelected = 0;
  final preferences = Preferences();
  bool isDarkMode = false;
  @override
  void initState() {
    super.initState();
    isDarkMode = preferences.getIsDarkMode;
  }

  // hacemos la intancia de la clase
  @override
  Widget build(BuildContext context) {
    // final teacher = Provider.of<TeachaerServices>(context);
    // teacher.getTeachers();

    final size = MediaQuery.of(context).size;

    // hamoes la instancia del as opcioens
    final menus = AppRoute.routes;

    // instancia del provider
    final menuProvider = Provider.of<MenuOptionProvider>(context);

    // create styl text
    const styleTitle =
        TextStyle(color: Color(0xffF9F9FF), fontSize: 24); // title
    const styleTextButton = TextStyle(color: Color(0xffF9F9FF), fontSize: 14);

    return Container(
      width: Platform.isMacOS || Platform.isWindows
          ? size.width * 0.18
          : size.width * 0.7,

      // height: size.height * 0.5,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // color: const Color(0xff6138FF),
        // color: Color(0xff12152A),   // definirivo
        color: Color(0xff13162C),

        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text('Control Esoclar', style: styleTitle),

            const SizedBox(
              height: 30,
            ),
            const Text('Preparatoria'),
            const Text('Rafael Pascacio Gamboa'),

            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: Image.asset('assets/prepa_logo.png'),
            ),

            const SizedBox(
              height: 10,
            ),
            Divider(),

            const SizedBox(
              height: 10,
            ),

            // mostrmos la lsita de las opciones
            SizedBox(
              height: 300,
              width: Platform.isMacOS || Platform.isWindows
                  ? size.width * 0.2
                  : size.width,
              child: ListView.builder(
                itemCount: menus.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      menuProvider.itemMenu = index;
                    },
                    child: Container(
                      // decoration de container
                      decoration: BoxDecoration(
                        color: menuProvider.itemMenuGet == index
                            ? Colors.black12
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),

                      height: 50,
                      width: size.width * 0.2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              menus[index].icon,
                              size: menuProvider.itemMenuGet == index
                                  ? 21.0
                                  : 20.0,
                              color: const Color(0xfff2F2FF),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              menus[index].name.toString(),
                              style: menuProvider.itemMenuGet == index
                                  ? const TextStyle(fontSize: 16)
                                  : styleTextButton,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // boton apra cambiar el tema de oscuro a blanco
//TODO: VERIFICAR LO LE SWITVH PARA EL CAMBIO DEL

            // SwitchListTile.adaptive(
            //     title: const Text('Tema'),
            //     value: preferences.getIsDarkMode,
            //     // value: isDarkMode,
            //     onChanged: (bool? value) {
            //       final themeProvider =
            //           Provider.of<ThemeProvier>(context, listen: false);

            //       preferences.setIsDarkMode = value!;
            //       // isDarkMode = value;
            //       value
            //           ? themeProvider.setDarkMode()
            //           : themeProvider.setLightMode();

            //       themeProvider.isDarkTheme = value;
            //       setState(() {});
            //     }),

            const SizedBox(
              height: 10,
            ),

            // botor para salir del programa
            Divider(),

            const SizedBox(
              height: 50,
            ),

            MaterialButton(
              onPressed: () async {
                final loginServices =
                    Provider.of<LoginServices>(context, listen: false);
                loginServices.logout();
                // despues iremos  al login para el nuevo inicio de sesion

                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, 'login');
              },
              color: Colors.blueAccent,
              child: const Text('Cerrar Sesion'),
            )
          ],
        ),
      ),
    );
  }
}

// CRMEOS UNA LISTA DE TIPO  WIDGET
