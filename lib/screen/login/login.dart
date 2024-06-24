import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/Services.dart';
import 'package:preppa_profesores/Services/push-NotificationServices.dart';
import 'package:preppa_profesores/providers/isMobile.dart';
import 'package:preppa_profesores/utils/shapeBorderDialog.dart';
import 'package:preppa_profesores/widgets/utils/style_ElevatedButton.dart';
import 'package:provider/provider.dart';

import '../../models/login.dart';
import '../../providers/form_provider.dart';

// para la definir que platafofmr se le esta haciendo el uso
import 'dart:io';

import '../../widgets/showDialogs/showDialog_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: _Form(size: size),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  final Size size;

  const _Form({Key? key, required this.size}) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();

  String user = '';
  String password = '';

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userController.text = user;
    passwordController.text = password;
  }

  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // instancia de la clasep para la validacio de los datos.

    final loginFormProvider = Provider.of<LoginFormProvider>(context);
    final loginServices = Provider.of<LoginServices>(context);
    final teachaerServices =
        Provider.of<TeachaerServices>(context, listen: false);

    // controlador para los texto
    final size = MediaQuery.of(context).size;

    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.white10, width: 0.3)),
      width: IsMobile.isMobile()
          ? widget.size.width * 0.99
          : widget.size.width / 3.2,
      height: widget.size.height,
      child: Form(
          key: loginFormProvider.formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),

                  // image
                  const Text('Preparatoria',
                      style: TextStyle(
                          // fontSize: MediaQuery.of(context).size.height * 0.03,
                          )),

                  const Text('Rafael Pascacio Gamboa',
                      style: TextStyle(fontSize: 16)),
                  const Text('Profesores'),

                  SizedBox(
                    width: widget.size.width * 0.25,
                    height: widget.size.height * 0.25,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/prepa_logo.png')),
                  ),
                  //  user
                  // password

                  SizedBox(
                    height: widget.size.height * 0.05,
                  ),

                  const Text('Login'),
                  SizedBox(
                    height: widget.size.height * 0.02,
                  ),
                  TextFormField(
                    controller: userController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'INGRESA EL USUARIO';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      user = value;
                    },
                    decoration: InputDecoration(
                        // border: BorderRadius.circular(20),
                        // hintText: 'Hola',  se  queda dentro del caja de texto
                        labelText: 'Usuario',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'INGRESA LA CONTRASEÑA';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      password = value;
                    },
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Ingrese contraseña',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                      // border: BorderRadius.circular(20),
                      // hintText: 'Hola',  se  queda dentro del caja de texto
                      labelText: 'Contraseña',
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),

                  buttonLoding(context, loginFormProvider, loginServices)
                ],
              ),
            ),
          )),
    );
  }

  ElevatedButton buttonLoding(BuildContext context,
      LoginFormProvider loginFormProvider, LoginServices loginServices) {
    return ElevatedButton(
        onPressed: () async {
          final loginServices =
              Provider.of<LoginServices>(context, listen: false);
          final teacherServices =
              Provider.of<TeachaerServices>(context, listen: false);

          // validacio ndel formulario --
          if (!loginFormProvider.isValidate()) return;

          final login = LoginUser(user: user, password: password);

          String? loginError = await loginServices.loginUser2(login);
          // se ejecuta cueando el usuario no existe --  Runs when the user does not exist , status 401

          if (loginServices.statusCde == 401) {
            // ignore: use_build_context_synchronously
            ShowDialogLogin.showDialogNotExistUser(context, loginError!);
            return;
          }

          if (loginServices.statusCde == 403) {

            _mostrarMensajeError(loginError!);
          } else {
            if (loginServices.statusCde == 404 &&
                loginServices.teachers == null) {
              // ignore: use_build_context_synchronously
              showMessageLogin(context, loginServices);
              
            } else if (loginServices.statusCde == 200) {
              // final student = loginServices.teacher;

              // podemos cargar algunos datos pero se hace en el socker

              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, 'check_auth_screen');
            } else {
              _mostrarMensajeError(loginError!);
            }
          }
        },
        child: loginServices.status == true
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Verificando datos...'),
                    SizedBox(
                      width: 20,
                    ),
                    CircularProgressIndicator()
                  ],
                ),
              )
            : const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text('INICIAR SESION'),
              ));
  }

  Future<dynamic> showMessageLogin(
      BuildContext context, LoginServices loginServices) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: const Icon(Icons.login),
            title: const Text('Inicio de sesion'),
            content: Text(loginServices.loginResponseTeacher.msg),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Salir')),
              TextButton(
                  onPressed: () async {
                    // await onLoading();
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, 'create_count');
                  },
                  child: const Text('Agregar Datos'))
            ],
          );
        });
  }

  void _mostrarMensajeError(String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.login),
          title: const Text('Inicio de sesion'),
          actionsAlignment: MainAxisAlignment.center,
          // title: const Text('Error de inicio de sesion'),
          content: Text(mensaje),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> showLoginError(
      BuildContext context, String loginError, LoginServices loginServices) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          // backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: !IsMobile.isMobile() ? 550 : null,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.login_outlined,
                    // color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Error',
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    loginError,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      loginServices.statusCde == 404
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: StyleElevatedButton.styleButton,
                                  onPressed: () {
                                    // Cerrar el diálogo
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                ElevatedButton(
                                  style: StyleElevatedButton.styleButton,
                                  onPressed: () {
                                    // Cerrar el diálogo
                                    // Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, 'create_teacher');
                                  },
                                  child: const Text('Agregar Datos'),
                                ),
                              ],
                            )
                          : ElevatedButton(
                              onPressed: () {
                                // Cerrar el diálogo
                                Navigator.pop(context);
                              },
                              child: const Text('Aceptar'),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
