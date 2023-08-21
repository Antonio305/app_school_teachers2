import 'package:flutter/material.dart';

class CreateTeacher extends StatefulWidget {
  const CreateTeacher({Key? key}) : super(key: key);

  @override
  State<CreateTeacher> createState() => _CreateTeacherState();
}

class _CreateTeacherState extends State<CreateTeacher> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List bloodGrade = [
      'O+',
      'O-',
      'AB+',
      'A+',
      'B',
    ];

    final List gender = ['MASCULINO', 'FEMENINO'];

    final List typeContract = ['BASE', 'INTERINADO'];

    return Container(
      // width: size.width * 0.7,
      width: size.width * 0.55,

      height: size.height * 0.5,
      child: Form(
          child: Column(
        children: [
          const SizedBox(
            height: 80,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 50,
                width: size.width * 0.2,
                child: TextFormField(
                  autocorrect: true,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
              ),
              SizedBox(
                height: 50,
                width: size.width * 0.15,
                child: TextFormField(
                  autocorrect: true,
                  decoration:
                      const InputDecoration(labelText: 'Apellido Paterno'),
                ),
              ),
              SizedBox(
                height: 50,
                width: size.width * 0.15,
                child: TextFormField(
                  autocorrect: true,
                  decoration:
                      const InputDecoration(labelText: 'Apellido Materno'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('Sexo'),
                  const SizedBox(
                    width: 20,
                  ),
                  DropdownButton<String>(
                      value: gender.first,
                      items: gender
                          .map((e) => DropdownMenuItem<String>(
                              value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {}),
                ],
              ),

              // tipo de sangre
              Row(
                children: [
                  const Text('Tipo dd sangre'),
                  DropdownButton<String>(
                      value: bloodGrade.first,
                      items: bloodGrade
                          .map((e) => DropdownMenuItem<String>(
                              value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {}),
                ],
              ),

              // titulo universitario
              SizedBox(
                height: 45,
                width: 200,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Titulo',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          // tercerap parte
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('Tipo de contrato'),
                  DropdownButton<String>(
                      value: typeContract.first,
                      items: typeContract
                          .map((e) => DropdownMenuItem<String>(
                              value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {}),
                ],
              ),
              Row(
                children: [
                  const Text('Matricula'),
                  SizedBox(
                    height: 35,
                    width: 200,
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Matricula'),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      )),
    );
  }
}
