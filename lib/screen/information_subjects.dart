import 'package:flutter/material.dart';
import 'package:preppa_profesores/widgets/text_fileds.dart';

class ScreenInformationSubjects extends StatelessWidget {
  const ScreenInformationSubjects({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informacion de la materia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text('NOMBRE DE LA MATERIA '),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  elevation: 3,
                  child: Container(
                      width: size.width * 0.3,
                      height: size.height * 0.73,
                      // color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Column(children: [
                            Form(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text('AGREGAR ARCHIVO')),
                                    const Text(
                                        'Nombre del archivos agregado     '),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                        maxLines: 4,
                                        decoration:
                                            InputDecorations.authDecoration(
                                                labelText:
                                                    'Objectivos de Aprendizaje')),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                            'AGREGAR TEMAS Y SUBTEMAS')),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                            'AGERGAR FECHAS DE EVALUACION')),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                        decoration:
                                            InputDecorations.authDecoration(
                                                labelText:
                                                    'Critoeriso de Evaluacion')),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: TextButton(
                                          onPressed: () {},
                                          child: const Text('GUARDAR DATOS')),
                                    )
                                  ]),
                            ),
                          ]),
                        ),
                      )),
                ),
                Card(
                  elevation: 3,
                  child: Container(
                      width: size.width * 0.6,
                      height: size.height * 0.73,
                      // color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text('Objeetivos de aprendizaje'),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text('Lista de archivos agregado'),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: size.width * 0.5,
                                height: size.height * 0.6,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 0.5,
                                      height: size.height * 0.3,
                                      child: ListView(
                                          children: List.generate(10, (index) {
                                        return const Text(
                                            'Lista de los subtemas ');
                                      })),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
