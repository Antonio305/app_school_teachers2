import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/Services.dart';
import 'package:preppa_profesores/models/loginResponseTeacher.dart';
import 'package:preppa_profesores/models/teacherRegister.dart';
import 'package:preppa_profesores/providers/form_teacher.dart';
import 'package:preppa_profesores/providers/menu_option_provider.dart';
import 'package:provider/provider.dart';

import '../../Services/teacher_services.dart';
import '../../widgets/text_fileds.dart';

import 'dart:io';

class ScreenRegisterTeacher extends StatelessWidget {
  const ScreenRegisterTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    TeacherRegister teacherRegister = TeacherRegister(
        name: '',
        lastName: '',
        secondName: '',
        gender: '0',
        collegeDegree: '',
        typeContract: '',
        status: false,
        rol: '',
        tuition: '',
        email: '',
        numberPhone: '000000000',
        uid: '',
        userLogin: '');
    // TeachersR teacher = TeachersR(
    //     name: '',
    //     lastName: '',
    //     secondName: '',
    //     gender: '',
    //     collegeDegree: '',
    //     typeContract: '',
    //     status: true,
    //     rol: '',
    //     numberPhone: '',
    //     email: '',
    //     tuition: '',
    //     uid: '');

    return ChangeNotifierProvider(
        create: (_) => TeacherFormProvider(teacherRegister),
        child: const ScreenRegisterTeacher2());
  }
}

class ScreenRegisterTeacher2 extends StatefulWidget {
  const ScreenRegisterTeacher2({Key? key}) : super(key: key);

  @override
  State<ScreenRegisterTeacher2> createState() => _ScreenRegisterTeacherState();
}

class _ScreenRegisterTeacherState extends State<ScreenRegisterTeacher2> {
  bool isDesktop() {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      return true;
    } else {
      return false;
    }
  }

  final List<String> rol = [
    'DIRECTOR',
    'PROFESOR',
    'CONTROL ESCOLAR',
    'SUB DIRECTOR',
    'STUDENT'
  ];
  final List<String> gender = ['MASCULINO', 'FEMENINO'];

  final List<String> typeContract = ['BASE', 'INTERINADO'];

  @override
  Widget build(BuildContext context) {
    final teacherServices = Provider.of<TeachaerServices>(context);
    final teacherServicesStatus = Provider.of<TeachaerServices>(context);

    final teacherFormProvider = Provider.of<TeacherFormProvider>(context);

    final menuOptionProvider = Provider.of<MenuOptionProvider>(context);
    final loginServices = Provider.of<LoginServices>(context);
    teacherFormProvider.teacher.tuition =
        loginServices.loginResponseTeacher.loginData.user;

    teacherFormProvider.teacher.userLogin =
        loginServices.loginResponseTeacher.loginData.id;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Datos')),
      body: Padding(
        padding: Platform.isAndroid || Platform.isIOS
            ? const EdgeInsets.symmetric(horizontal: 15)
            : const EdgeInsets.all(50.0),
        child: SingleChildScrollView(
          child: Form(
            key: teacherFormProvider.formKey,
            // funcion para la validacion de los  datos
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Platform.isWindows || Platform.isMacOS
                ?

// for desktop

                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            // height: 50,
                            width: isDesktop() ? 250 : size.width * 0.95,

                            child: TextFormField(
                              onChanged: (value) {
                                teacherFormProvider.teacher.name = value;
                              },
                              validator: (value) {
                                if (value == null || value.length <= 1) {
                                  return 'INGRESA EL NOMBRE';
                                }
                                return null;
                              },
                              // autocorrect: true,
                              decoration:
                                  const InputDecoration(labelText: 'Nombre'),
                            ),
                          ),
                          SizedBox(
                            // height: 50,
                            width: isDesktop() ? 250 : size.width * 0.95,

                            child: TextFormField(
                              onChanged: (value) {
                                teacherFormProvider.teacher.lastName = value;
                              },
                              validator: (value) {
                                if (value == null || value.length <= 1) {
                                  return 'INGRESA EL   APELLIDO PATERNO';
                                }
                                return null;
                              },
                              autocorrect: true,
                              decoration: const InputDecoration(
                                  labelText: 'Apellido Paterno'),
                            ),
                          ),
                          SizedBox(
                            // height: 50,
                            width: isDesktop() ? 250 : size.width * 0.95,

                            // width: size.width * 0.15,
                            child: TextFormField(
                              onChanged: (value) {
                                teacherFormProvider.teacher.secondName = value;
                              },
                              validator: (value) {
                                if (value == null || value.length <= 1) {
                                  return 'INGRESA EL  APELLIDO MATERNO';
                                }
                                return null;
                              },
                              autocorrect: true,
                              decoration: const InputDecoration(
                                  labelText: 'Apellido Materno'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),

                      SizedBox(
                        width: isDesktop() ? 250 : size.width * 0.95,
                        child: Row(
                          children: [
                            const Text('Sexo'),
                            const SizedBox(
                              width: 20,
                            ),
                            DropdownButton<String>(
                                value: menuOptionProvider.genderTeacher,
                                items: gender
                                    .map((e) => DropdownMenuItem<String>(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (value) {
                                  menuOptionProvider.genderTeacher = value!;

                                  teacherFormProvider.teacher.gender = value;
                                }),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: isDesktop() ? 250 : size.width * 0.95,
                        child: Row(
                          children: [
                            const Text('Rol'),
                            const SizedBox(
                              width: 15,
                            ),
                            DropdownButton<String>(
                                value: menuOptionProvider.rolTeacher,
                                items: rol
                                    .map((e) => DropdownMenuItem<String>(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (value) {
                                  menuOptionProvider.rolTeacher = value!;

                                  teacherFormProvider.teacher.rol = value;
                                }),
                          ],
                        ),
                      ),

                      // titulo universitario
                      SizedBox(
                        height: 45,
                        width: isDesktop() ? 250 : size.width * 0.95,
                        child: TextFormField(
                          onChanged: (value) {
                            teacherFormProvider.teacher.collegeDegree = value;
                          },
                          validator: (value) {
                            if (value == null || value.length <= 1) {
                              return 'INGRESA EL TITULO';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Titulo',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      // tercerap parte
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tipo de contrato'),
                          const SizedBox(
                            width: 20,
                          ),
                          DropdownButton<String>(
                              value: menuOptionProvider.typeContracTeacher,
                              items: typeContract
                                  .map((e) => DropdownMenuItem<String>(
                                      value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (value) {
                                menuOptionProvider.typeContracTeacher = value!;
                                teacherFormProvider.teacher.typeContract =
                                    value;
                              }),
                        ],
                      ),
                      SizedBox(
                        width: 200,
                        // height: 40,
                        child: TextFormField(
                          // controller: numberPhoneStudent,
                          keyboardType: TextInputType.number,

                          validator: (value) {
                            // if (value!.isEmpty) {
                            //   return 'Por favor ingrese un número';
                            // }
                            // if (int.tryParse(value) == null) {
                            //   return 'Por favor ingrese solo números';
                            // }
                            // return null;

                            // // Expresión regular para verificar si la entrada es numérica
                            final isDigitsOnly =
                                RegExp(r'^\d+$').hasMatch(value ?? '');
                            if (!isDigitsOnly) {
                              return 'Por favor ingrese solo números';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            // student.numberPhone = int.parse(value);
                            // phoneStudent = value;
                            teacherFormProvider.teacher.numberPhone = value;
                          },
                          initialValue: '',
                          decoration:
                              const InputDecoration(labelText: 'Telefono'),

                          // decoration: InputDecorations.authDecoration(
                          //   hintText: '',
                          //   labelText: 'Telefono',
                          //   // prefixIcon: Icons.document_scanner_sharp
                          // ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        // height: 40,
                        child: TextFormField(
                          // controller: numberPhoneStudent,
                          keyboardType: TextInputType.emailAddress,

                          validator: (value) {
                            String pattern =
                                r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z]{2,})$';
                            RegExp regex = RegExp(pattern);

                            if (!regex.hasMatch(value!)) {
                              return 'Ingresa un correo electronico valido';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            // student.numberPhone = int.parse(value);

                            teacherFormProvider.teacher.email = value;
                          },
                          initialValue: '',
                          decoration:
                              const InputDecoration(labelText: 'Correo'),

                          // decoration: InputDecorations.authDecoration(
                          //   hintText: '',
                          //   labelText: 'Correo',
                          //   // prefixIcon: Icons.document_scanner_sharp
                          // ),
                        ),
                      ),

                      SizedBox(
                        // height: 35,
                        width: isDesktop() ? 250 : size.width * 0.95,

                        child: TextFormField(
                          initialValue: teacherFormProvider.teacher.tuition,
                          onChanged: (value) {
                            teacherFormProvider.teacher.tuition = value;
                          },
                          validator: (value) {
                            if (value == null || value.length <= 1) {
                              return 'INGRESA SU MATRICULA';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(labelText: 'Matricula'),
                        ),
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              MaterialButton(
                                color: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text('REGISTRAR'),
                                onPressed: () {
                                  // las
                                  if (teacherFormProvider.isValidForm()) {
                                    final teacherServices =
                                        Provider.of<TeachaerServices>(context,
                                            listen: false);
                                    //  final teacher = Teachers(ScreenRegisterTeacher2: ScreenRegisterTeacher2,
                                    //lastName: lastName, secondName: secondName, gender: gender, collegeDegree: collegeDegree,
                                    //typeContract: typeContract, status: status, rol: rol, tuition: tuition, password: password,
                                    //uid: uid)
                                    teacherServices.createTeacher(
                                        teacherFormProvider.teacher);

                                    // con esti limpiamos el campo de texto.
                                  }
                                  // Navigator.of(context).pop(controller.text);
                                },
                              ),
                              // MaterialButton(
                              //   color: Colors.lightBlue,
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(5),
                              //   ),
                              //   child: const Text('CANCELAR'),
                              //   onPressed: () {
                              //     Navigator.of(context).pop();
                              //     // Navigator.of(context).pop(controller.text);
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Wrap(
                        runSpacing: 20,
                        spacing: 10,
                        children: [
                          SizedBox(
                            // height: 50,
                            width: isDesktop() ? 250 : size.width * 0.95,

                            child: TextFormField(
                              onChanged: (value) {
                                teacherFormProvider.teacher.name = value;
                              },
                              validator: (value) {
                                if (value == null || value.length <= 1) {
                                  return 'INGRESA EL NOMBRE';
                                }
                                return null;
                              },
                              autocorrect: true,
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Nombre',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                            ),
                          ),
                          SizedBox(
                            // height: 50,
                            width: isDesktop() ? 250 : size.width * 0.95,

                            child: TextFormField(
                              onChanged: (value) {
                                teacherFormProvider.teacher.lastName = value;
                              },
                              validator: (value) {
                                if (value == null || value.length <= 1) {
                                  return 'INGRESA EL   APELLIDO PATERNO';
                                }
                                return null;
                              },
                              autocorrect: true,
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Apellido Paterno',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                            ),
                          ),
                          SizedBox(
                            // height: 50,
                            width: isDesktop() ? 250 : size.width * 0.95,

                            // width: size.width * 0.15,
                            child: TextFormField(
                              onChanged: (value) {
                                teacherFormProvider.teacher.secondName = value;
                              },
                              validator: (value) {
                                if (value == null || value.length <= 1) {
                                  return 'INGRESA EL  APELLIDO MATERNO';
                                }
                                return null;
                              },
                              autocorrect: true,
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Apellido Materno',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                            ),
                          ),
                          SizedBox(
                            width: isDesktop() ? 250 : size.width * 0.95,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Sexo'),
                                const SizedBox(
                                  width: 20,
                                ),
                                DropdownButton<String>(
                                    value: menuOptionProvider.genderTeacher,
                                    items: gender
                                        .map((e) => DropdownMenuItem<String>(
                                            value: e, child: Text(e)))
                                        .toList(),
                                    onChanged: (value) {
                                      menuOptionProvider.genderTeacher = value!;

                                      teacherFormProvider.teacher.gender =
                                          value;
                                    }),
                              ],
                            ),
                          ),

                          // tipo de sangre
                          SizedBox(
                            width: isDesktop() ? 250 : size.width * 0.95,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Rol'),
                                const SizedBox(
                                  width: 15,
                                ),
                                DropdownButton<String>(
                                    value: menuOptionProvider.rolTeacher,
                                    items: rol
                                        .map((e) => DropdownMenuItem<String>(
                                            value: e, child: Text(e)))
                                        .toList(),
                                    onChanged: (value) {
                                      menuOptionProvider.rolTeacher = value!;

                                      teacherFormProvider.teacher.rol = value;
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(
                            // height: 45,
                            width: isDesktop() ? 250 : size.width * 0.95,

                            child: TextFormField(
                              onChanged: (value) {
                                teacherFormProvider.teacher.collegeDegree =
                                    value;
                              },
                              validator: (value) {
                                if (value == null || value.length <= 1) {
                                  return 'INGRESA EL TITULO';
                                }
                                return null;
                              },
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Titulo',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Tipo de contrato'),
                              const SizedBox(
                                width: 20,
                              ),
                              DropdownButton<String>(
                                  value: menuOptionProvider.typeContracTeacher,
                                  items: typeContract
                                      .map((e) => DropdownMenuItem<String>(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (value) {
                                    menuOptionProvider.typeContracTeacher =
                                        value!;
                                    teacherFormProvider.teacher.typeContract =
                                        value;
                                  }),
                            ],
                          ),

// phone email
                          SizedBox(
                            width: isDesktop() ? 250 : size.width * 0.95,

                            // height: 40,
                            child: TextFormField(
                              // controller: numberPhoneStudent,
                              keyboardType: TextInputType.number,

                              validator: (value) {
                                // if (value!.isEmpty) {
                                //   return 'Por favor ingrese un número';
                                // }
                                // if (int.tryParse(value) == null) {
                                //   return 'Por favor ingrese solo números';
                                // }
                                // return null;

                                // // Expresión regular para verificar si la entrada es numérica
                                final isDigitsOnly =
                                    RegExp(r'^\d+$').hasMatch(value ?? '');
                                if (!isDigitsOnly) {
                                  return 'Por favor ingrese solo números';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                // student.numberPhone = int.parse(value);
                                // phoneStudent = value;
                                teacherFormProvider.teacher.numberPhone =
                                    value.toString();
                              },
                              initialValue: '',
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Telefono',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                            ),
                          ),

                          SizedBox(
                            width: isDesktop() ? 250 : size.width * 0.95,

                            // height: 40,
                            child: TextFormField(
                              // controller: numberPhoneStudent,
                              keyboardType: TextInputType.emailAddress,

                              validator: (value) {
                                return null;

                                // if (value!.isEmpty) {
                                //   return 'Por favor ingrese un número';
                                // }
                                // if (int.tryParse(value) == null) {
                                //   return 'Por favor ingrese solo números';
                                // }
                                // return null;

                                // // Expresión regular para verificar si la entrada es numérica
                                // final isDigitsOnly =
                                //     RegExp(r'^\d+$').hasMatch(value ?? '');
                                // if (!isDigitsOnly) {
                                //   return 'Por favor ingrese solo números';
                                // }
                                // return null;
                              },
                              onChanged: (value) {
                                // student.numberPhone = int.parse(value);
                                // phoneStudent = value;
                                teacherFormProvider.teacher.email = value;
                              },
                              initialValue: '',
                              decoration: InputDecorations.authDecoration(
                                hintText: '',
                                labelText: 'Correo Electronico',
                                // prefixIcon: Icons.document_scanner_sharp
                              ),
                            ),
                          ),

                          Column(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                // height: 35,
                                width: isDesktop() ? 250 : size.width * 0.95,

                                child: TextFormField(
                                  initialValue:
                                      teacherFormProvider.teacher.tuition,
                                  onChanged: (value) {
                                    teacherFormProvider.teacher.tuition = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.length <= 1) {
                                      return 'INGRESA SU MATRICULA';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecorations.authDecoration(
                                    hintText: '',
                                    labelText: 'Matricula',
                                    // prefixIcon: Icons.document_scanner_sharp
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        child: teacherServicesStatus.requestStatus == false
                            ? const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Text('REGISTRARES'),
                              )
                            : const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Row(
                                  children: [
                                    Text('Procesnad...'),
                                    SizedBox(width: 5),
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              ),
                        onPressed: () async {
                          if (teacherFormProvider.isValidForm()) {
                            final teacherServices =
                                Provider.of<TeachaerServices>(context,
                                    listen: false);
                            //  final teacher = Teachers(ScreenRegisterTeacher2: ScreenRegisterTeacher2, lastName: lastName, secondName: secondName, gender: gender, collegeDegree: collegeDegree, typeContract: typeContract, status: status, rol: rol, tuition: tuition, password: password, uid: uid)
                            String? message = await teacherServices
                                .createTeacher(teacherFormProvider.teacher);

                            if (message!.isNotEmpty) {
                              // ignore: use_build_context_synchronously
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Mensaje'),
                                      content: Text(message),
                                      actions: [
                                        teacherServices.statusCodes == 200 ||
                                                teacherServices.statusCodes ==
                                                    201
                                            ? Row(
                                                children: [
                                                  const Spacer(),
                                                  TextButton(
                                                      onPressed: () {},
                                                      child: const Text(
                                                          'Cancelar')),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                            context, 'login');
                                                      },
                                                      child: const Text(
                                                          'Inicar sesion'))
                                                ],
                                              )
                                            : TextButton(
                                                onPressed: () {},
                                                child: const Text('Aceptar'))
                                      ],
                                    );
                                  });
                            }
                            // await teacherServices.getTeachers();

                            // con esti limpiamos el campo de texto.
                          }
                          // Navigator.of(context).pop(controller.text);
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
