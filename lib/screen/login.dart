import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/Services.dart';
import 'package:provider/provider.dart';

import '../Services/group_services.dart';
import '../Services/login_provider.dart';
import '../models/login.dart';
import '../providers/form_provider.dart';

// para la definir que platafofmr se le esta haciendo el uso
import 'dart:io';

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

  @override
  Widget build(BuildContext context) {
    // instancia de la clasep para la validacio de los datos.

    final loginFormProvider = Provider.of<LoginFormProvider>(context);
    final loginServices = Provider.of<LoginServices>(context);
    final teachaerServices =
        Provider.of<TeachaerServices>(context, listen: false);

    // controlador para los texto

    return Container(
      //  width: widget.size.width,
      //   height: widget.size.height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white10,
      ),
      width:
       Platform.isWindows || Platform.isMacOS
          ? widget.size.width * 0.4
          : widget.size.width * 0.8,
      // height: widget.size.height * 0.8,
      child: Form(
          key: loginFormProvider.formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // image

                  SizedBox(
                    width: widget.size.width * 0.25,
                    height: widget.size.height * 0.25,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset('assets/control.gif')),
                  ),
                  //  user
                  // password

                  SizedBox(
                    height: widget.size.height * 0.1,
                  ),
                  TextFormField(
                    controller: userController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'INGRESA EL USUARIO';
                          }
                        },
                    onChanged: (String value) {
                      user = value;
                    },
                    decoration: InputDecoration(
                        // border: BorderRadius.circular(5),
                        // hintText: 'Hola',  se  queda dentro del caja de texto
                        labelText: 'Usuario',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
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
                        },
                    onChanged: (String value) {
                      password = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        // border: BorderRadius.circular(5),
                        // hintText: 'Hola',  se  queda dentro del caja de texto
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  ElevatedButton(
                      onPressed: () async {
                        // validacio ndel formulario
                        if (!loginFormProvider.isValidate()) return;

                        // final loginServices = LoginServices();

                        final login = LoginUser(user: user, password: password);

                        String? loginError =
                            await loginServices.loginUser(login);
                        // loginFormProvider.isLoading = false;

                        if (loginError == null) {
                          // Navigator.pushNamed(context, 'home');
                          // await teachaerServices.getForId();

                          Navigator.pushReplacementNamed(
                              context, 'check_auth_screen');
                        } else {
                          // cason contrario mostramos el error
                          print(loginError);
                        }
                      },
                      child: const Text('INICIAR SESION'))
                ],
              ),
            ),
          )),
    );
  }
}
