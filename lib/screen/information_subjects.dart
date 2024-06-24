import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:preppa_profesores/models/subjects.dart';
import 'package:preppa_profesores/providers/formSubject.dart';
import 'package:preppa_profesores/providers/isMobile.dart';
import 'package:preppa_profesores/utils/padding.dart';
import 'package:preppa_profesores/utils/textStyleOptions.dart';
import 'package:preppa_profesores/widgets/myScrollConfigure.dart';
import 'package:preppa_profesores/widgets/showDialogs/showDialogError.dart';
import 'package:preppa_profesores/widgets/text_fileds.dart';
import 'package:provider/provider.dart';

import '../Services/subject_services.dart';
import '../providers/thme_provider.dart';

class ScreenInformationSubjects extends StatefulWidget {
  const ScreenInformationSubjects({super.key});

  @override
  State<ScreenInformationSubjects> createState() =>
      _ScreenInformationSubjectsState();
}

class _ScreenInformationSubjectsState extends State<ScreenInformationSubjects>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int indexSelected = 0;
  bool isSelected = false;

  int selectedUnit = 0;
  int selectedTopics = 0;
  int selectedSubTopics = 0;

  bool addSubjectDada = false;

  Future<void> onRefreshs(String subjectId) async {
    final subjectServices =
        Provider.of<SubjectServices>(context, listen: false);

    await subjectServices.getSubjectById(subjectId);
  }

  late Subjects subject;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final subjectServices = Provider.of<SubjectServices>(context);

    subject = subjectServices.subjectSelected;

    bool thenmeIsDark =
        Provider.of<ThemeProvier>(context).currentTheme == ThemeData.dark();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await onRefreshs(subject.uid);
              },
              icon: const Icon(Icons.refresh)),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              subjectServices.syllaba = null;
            },
            icon: const Icon(Icons.arrow_circle_left_sharp)),
        title: Text(subject.name),
        centerTitle: true,
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          await onRefreshs(subject.uid);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: IsMobile.isMobile()
                ? const EdgeInsets.symmetric(horizontal: 8)
                : const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // informacion de la materia
                // nombre del profesot etc.
                informationTeacher(size, thenmeIsDark, subject),
                const Center(
                  child: Text(
                    'INFORMACION DE LA MATERIA',
                    style: TextStyle(
                        letterSpacing: 4,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    softWrap: true,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        if (IsMobile.isMobile()) {
                          ShowDialogError.showDialogError(
                              context,
                              const Icon(Icons.error),
                              'Agregar temas',
                              'Solo se permite agregar temas y subtemas con la aplicacin de escritorio');
                          return;
                        }

                        setState(() {
                          addSubjectDada = true;
                        });
                      },
                      child: SizedBox(
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/addData.png',
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: IsMobile.isMobile() ? 200 : null,
                                child: Text(
                                  'Agregar o Editar datos de la materia',
                                  style: TextStyleOptionsHome.styleText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),

                const SizedBox(
                  height: 20,
                ),
                addSubjectDada ? const FormSubject() : Container(),

                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  // height: 200,
                  width: size.width * 0.99,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detalles de la materia',
                          style: TextStyleOptionsHome.styleText,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              cardSubjectData(
                                  size, 'Descripcion:', subject.description),
                              cardSubjectData(size, 'Ojectivos de aprendizaje',
                                  subject.learningObjetive),
                              cardSubjectData(size, 'Criteriso de evaluacion:',
                                  subject.evaluationCriteria),
                              if (subject.examDate.isNotEmpty)
                                Card(
                                  // color: Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                         Text('Fechas de evaluacion:', style: TextStyleOptionsHome.styleText,),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          height: 90,
                                          width: 300,
                                          child: Wrap(
                                            spacing: 5,
                                            runSpacing: 5,
                                            // scrollDirection: Axis.horizontal,
                                            children: List.generate(
                                              subject.examDate.length,
                                              (index) => Text(
                                                  "$index.- ${subject.examDate[index].partial}  ${subject.examDate[index].date.toString().substring(0, 10)}"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                            ]),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child:
                      SizedBox(width: size.width * 0.8, child: const Divider()),
                ),
                const SizedBox(height: 50),

                const Center(
                  child: Text(
                    'TEMAS Y SUBTEMAS',
                    style: TextStyle(
                        letterSpacing: 4,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    softWrap: true,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 1500,
                  child: Padding(
                    padding: IsMobile.isMobile()
                        ? const EdgeInsets.all(0)
                        : MyPadding.paddingInsideCard(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lista de parciales',
                            style: TextStyleOptionsHome.styleText,
                          ),
                          const SizedBox(height: 10),
                          listPartial(subject, subjectServices),
                          const SizedBox(height: 50),
                          subjectServices.syllaba == null
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: Image.asset(
                                              'assets/search2.png')),
                                      Text(
                                        'Seleciona un partial, para ver los temas y subtemas',
                                        style: TextStyleOptionsHome.styleText,
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  width: size.width,
                                  // height: 600,
                                  // color: Colors.red,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Tema parcial: ${subjectServices.syllaba!.topicsOfPartialSubject}',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 20),
                                        // lista del as unidades
                                        Center(
                                          child: Wrap(
                                            runSpacing: 7,
                                            spacing: 5,
                                            // alignment: WrapAlignment.center,
                                            children: List.generate(
                                                subjectServices
                                                    .syllaba!.listUnits.length,
                                                (index) => GestureDetector(
                                                    onTap: () {
                                                      // isSelected = true;
                                                      setState(() {
                                                        selectedUnit = index;
                                                        print(index);
                                                      });
                                                    },
                                                    child: cardUnits(
                                                        index,
                                                        size,
                                                        subjectServices))),
                                          ),
                                        )
                                      ]),
                                ),
                        ]),
                  ),
                ),
                // detailSubjects(size, subject, thenmeIsDark),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardSubjectData(Size size, String title, String text) {
    return SizedBox(
      // width: size.width * 0.31,
      width: IsMobile.isMobile() ? size.width : size.width * 0.31,

      child: Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          )),
    );
  }

  Widget listPartial(Subjects subject, SubjectServices subjectServices) {
    return SizedBox(
      height: 60,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
              subject.syllabas.length,
              (index) => TextButton(
                  onPressed: () {
                    setState(() {
                      subjectServices.syllaba = subject.syllabas[index];
                    });
                  },
                  child: SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Text(index.toString()),
                            ),
                            // Icon(Icons.Init)
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              subject.syllabas[index].partial,
                              style: TextStyleOptionsHome.styleText,
                            ),
                          ],
                        ),
                      ))))),
    );
  }

  Widget cardUnits(int index, Size size, SubjectServices subjectServices) {
    return SizedBox(
      width: selectedUnit == index
          ? IsMobile.isMobile()
              ? size.width
              : size.width * 0.6
          : IsMobile.isMobile()
              ? size.width
              : size.width * 0.23,
      // height: selectedUnit == index ? size.width * 0.2 : null,
      child: Card(
        // color: Colors.blue,
        margin: const EdgeInsets.all(4),
        child: Padding(
          padding: MyPadding.paddingInsideCard(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Unidad $index'),
            const SizedBox(height: 10),
            const Text('Temas: '),
            selectedUnit == index
                ? listTopics(size, subjectServices)
                : Container(),
          ]),
        ),
      ),
    );
  }

  Wrap listTopics(Size size, SubjectServices subjectServices) {
    return Wrap(
      children: List.generate(
          subjectServices.syllaba!.listUnits[selectedUnit].unitThemes.length,
          (index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedTopics = index;
                });
              },
              child: cardTopics(size, index, subjectServices))),
    );
  }

  Widget cardTopics(Size size, int index, SubjectServices subjectServices) {
    return SizedBox(
      width: selectedTopics == index
          ? IsMobile.isMobile()
              ? size.width
              : size.width * 0.57
          : size.width * 0.3,
      // height: size.height * 0.3,
      // height: 50,
      child: Card(
        elevation: 1,
        // color: Colors.red,
        child: Padding(
          padding: IsMobile.isMobile()
              ? const EdgeInsets.all(5)
              : MyPadding.paddingInsideCard(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(width: 10),
              Text(
                'Tema $index :   ${subjectServices.syllaba!.listUnits[selectedUnit].unitThemes[index].topics.themeName}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              selectedTopics == index
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        const Text('Subetemas:'),
                        const SizedBox(height: 10),
                        Wrap(
                          children: List.generate(
                              subjectServices
                                  .syllaba!
                                  .listUnits[selectedUnit]
                                  .unitThemes[selectedTopics]
                                  .topics
                                  .subtopics
                                  .length,
                              (index) => Card(
                                    elevation: 1,
                                    child: Padding(
                                      padding: MyPadding.paddingInsideCard(),
                                      child: Text(
                                          "$index.-  ${subjectServices.syllaba!.listUnits[selectedUnit].unitThemes[selectedTopics].topics.subtopics[index]}"),
                                    ),
                                  )),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget informationTeacher(Size size, bool thenmeIsDark, Subjects subject) {
    return SizedBox(
      // color: Colors.red,
      height: size.height * 0.8,
      child: Column(children: [
        // const Text('Informacion de la materias'),
        const SizedBox(
          height: 150,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image(size, thenmeIsDark),
            detailTeacher(size, subject),
          ],
        ),

        const SizedBox(
          height: 50,
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 100),
          child: Divider(),
        ),
      ]),
    );
  }



  AnimatedBuilder detailTeacher(Size size, Subjects subject) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
            width: size.width * 0.4,
            height: size.height * 0.4,
            transform: Matrix4.translationValues(
                _controller.value * size.width * -0.1, 0, 0),
            // Matrix4.translationValues(
            //     _controller.value * size.width * -0.01, 0, 0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject.name, // import 'package:intl/intl.dart';
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: 50,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: const Offset(1, 1),
                          blurRadius: 4,
                        ),
                      ],
                    )),
                Text(
                    "${subject.teachers.name}   ${subject.teachers.secondName}  ${subject.teachers.lastName}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: const Offset(1, 1),
                          blurRadius: 4,
                        ),
                      ],
                    )),
                Text(subject.teachers.collegeDegree,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: const Offset(1, 1),
                          blurRadius: 4,
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  subject.semestre.name,
                  style: TextStyleOptionsHome.styleText,
                ),
              ],
            ));
      },
    );
  }

  AnimatedBuilder image(Size size, bool isDark) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
            transform:
                //  IsMobile.isMobile()
                //     ? Matrix4.translationValues(
                //         _controller.value * size.width, 0, 0)
                //     :
                Matrix4.translationValues(
                    _controller.value * size.width * 0.1, 0, 0),
            // transform: Matrix4.translationValues(
            //     _controller.value * MediaQuery.of(context).size.width, 0, 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(250),
                border: Border.all(
                    color: isDark ? Colors.white60 : Colors.black38)),
            width: size.width * 0.23,
            // width: 350,
            height: size.height * 0.4,
            // height: 350,
            child: Center(
                child: Image.asset(
              'assets/subject.png',
              fit: BoxFit.fill,
            )));
      },
    );
  }
}

class FormSubject extends StatelessWidget {
  const FormSubject({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectServices = Provider.of<SubjectServices>(context);
    Subjects subject = subjectServices.subjectSelected;

    return ChangeNotifierProvider(
      create: (_) => FormSubjectProvider(subject),
      child: const FormSubject2(),
    );
  }
}

class FormSubject2 extends StatefulWidget {
  const FormSubject2({
    super.key,
  });

  @override
  State<FormSubject2> createState() => _FormSubject2State();
}

class _FormSubject2State extends State<FormSubject2> {
  // varibles para los archivos
  List<File> files = [];
  List<String> nameFiles = [];

  // fecha por defecto
  DateTime fecha = DateTime.now();
  DateTime fechaOnly = DateTime.now();

// for fecha de exporacio de la tarea
  DateTime? expiredAt;

  late Subjects subject;

  List<ExamDate> listDate =
      List.filled(3, ExamDate(partial: '', date: DateTime.now()));
  int option = 0;
  @override
  Widget build(BuildContext context) {
    // podemos acceder al FormSubjectProvider

    final formSubject = Provider.of<FormSubjectProvider>(context);
    final subjectServices = Provider.of<SubjectServices>(context);

    subject = formSubject.subject;

    final size = MediaQuery.of(context).size;
    return Card(
      elevation: 0.75,
      child: SizedBox(
          width: IsMobile.isMobile() ? size.width : size.width,
          // height: size.height * 0.99,
          // color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Form(
                  child: Wrap(
                      runSpacing: 10,
                      spacing: 20,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        learningObjetive(subject),

                        description(subject),
                        evaluationCriteria(subject, formSubject),
                        buttonAddDateEvaluation(subjectServices),

                        buttonAddSylaba(context, formSubject),

                        selectedFiles(),
                        // button save
                      ]),
                ),
                const SizedBox(
                  height: 30,
                ),
                buttonSaveSyllaba(context, formSubject),
              ],
            ),
          )),
    );
  }

  Widget evaluationCriteria(Subjects subject, FormSubjectProvider formSubject) {
    return contenField(
      TextFormField(
          initialValue: subject.evaluationCriteria,
          onChanged: (value) {
            formSubject.subject.evaluationCriteria = value;
          },
          decoration: InputDecorations.authDecoration(
              labelText: 'Criterios de Evaluacion')),
    );
  }

  Widget contenField(Widget child) {
    return SizedBox(
      width: IsMobile.isMobile() ? double.infinity : 450,
      child: child,
    );
  }

  Center buttonSaveSyllaba(
      BuildContext context, FormSubjectProvider formSubject) {
    return Center(
      child: TextButton(
          onPressed: () {
            final subjectServices =
                Provider.of<SubjectServices>(context, listen: false);
            // Cierra el showDialog

            subjectServices.updateSubject(formSubject.subject);
          },
          child: const Text('GUARDAR DATOS')),
    );
  }

// / funciuon para las fechas
  _selectDate(
      BuildContext context, int option, SubjectServices subjectServices) async {
    // DateTime selectedDate = DateTime.now();

    // varaible que guarda la fecha seleccionada
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: fecha,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
      // cambaira el texto de los botones
      helpText: 'Seleccionar Fecha ',
      cancelText: 'Cancelar',
      confirmText: 'Guardar',
      // locale: const Locale('es', 'MX'),
    );

    late ExamDate examenDate;
    // si para una de stas condiciones actualizamos el  datos
    if (selected != null && selected != fecha) {
      switch (option) {
        case 0:
          setState(() {
            listDate[0] = ExamDate(partial: 'Primer parcial', date: selected);
          });

          break;
        case 1:
          listDate[1] = ExamDate(partial: 'Segundo parcial', date: selected);

          break;
        case 2:
          listDate[2] = ExamDate(partial: 'Tercer parcial', date: selected);
          // subject.examDate.add(selected);

          break;
        default:
          listDate[0] = ExamDate(partial: 'Primer parcial', date: selected);
      }

      setState(() {
        subject.examDate = listDate;
      });
    }
    subjectServices.subjectSelected.examDate = listDate;
  }

  TextButton buttonAddDateEvaluation(SubjectServices subjectServices) {
    return TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Fecha de examen'),
                content: contentAddDate(context, subjectServices),
                actions: [
                  TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          subject.examDate = listDate;
                          subjectServices.subjectSelected.examDate = listDate;
                        });
                      },
                      icon: const Icon(Icons.save_sharp),
                      label: const Text('Guardar fechas de evaluacion')),
                  TextButton.icon(
                      onPressed: () {
                        // print(subject.examDate);
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                      label: const Text('Salir')),
                ],
              );
            },
          );
        },
        child: SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.date_range_outlined,
                  size: 30,
                ),
                Text(
                  'Fecha de evaluacion',
                  style: TextStyleOptionsHome.styleText,
                ),
              ],
            ),
          ),
        ));
  }

  SizedBox contentAddDate(
      BuildContext context, SubjectServices subjectServices) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Puede agregar solo uno', style: TextStyleOptionsHome.styleText),
          const SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              addDate('Primer parcial', () {
                _selectDate(context, 0, subjectServices);
                setState(() {
                  option = 0;
                });
              }),
              addDate('Segundo parcial', () {
                _selectDate(context, 1, subjectServices);
                setState(() {
                  option = 1;
                });
              }),
              addDate('Tercer parcial', () {
                _selectDate(context, 2, subjectServices);

                setState(() {
                  option = 2;
                });
              }),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          // subject.examDate.isNotEmpty
          //     ? Text('Fechas de evaluacion : ${subject.examDate[option]}',
          //         style: TextStyleOptionsHome.styleText)
          //     : Container(),
        ],
      ),
    );
  }

  Column addDate(String label, Function onPressed) {
    return Column(children: [
      // const Text('Primer parcial'),
      TextButton.icon(
          onPressed: () {
            onPressed();
          },
          icon: const Icon(Icons.add_circle_rounded),
          label: Text(label))
    ]);
  }

  TextButton buttonAddSylaba(
      BuildContext context, FormSubjectProvider formSubject) {
    return TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return MyDialogSubject(
                formSubject: formSubject,
              );
            },
          );
        },
        child: SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.add_circle_outline_rounded,
                  size: 30,
                ),
                Text(
                  'Agregar temas y subtemas',
                  style: TextStyleOptionsHome.styleText,
                ),
              ],
            ),
          ),
        ));
  }

  Widget description(Subjects subject) {
    return contenField(
      TextFormField(
          initialValue: subject.description,
          onChanged: (value) {
            subject.description = value;
          },
          maxLines: 5,
          minLines: 1,
          decoration: InputDecorations.authDecoration(
              labelText: 'Descripcion de la materia')),
    );
  }

  Widget learningObjetive(Subjects subject) {
    return contenField(
      TextFormField(
          initialValue: subject.learningObjetive,
          onChanged: (value) {
            subject.learningObjetive = value;
          },
          // expands: true,
          // maxLines: 5,
          // minLines: 0,
          decoration: InputDecorations.authDecoration(
              labelText: 'Objectivos de Aprendizaje')),
    );
  }

  SizedBox selectedFiles() {
    return SizedBox(
      width: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(allowMultiple: true);

                // Si es diferente a null

                if (result != null) {
                  // addl ist files
                  setState(() {
                    files = result.paths.map((path) => File(path!)).toList();
                    // add list name Files
                    nameFiles = result.names.map((e) => e!).toList();
                  });
                } else {
                  // User canceled the picker - el usuario cancelo el selector
                  print('No se seleciono nada');
                }

                // FilePickerResult? result =
                //     await FilePicker.platform
                //         .pickFiles();

                // if (result == null) {
                //   // ignore: use_build_context_synchronously
                //   // MySnackBar.MySnack(
                //   //     context, 'No se seleciono ningun archivo');
                //   // User canceled the picker
                //   print('USER CANCELED THE PICKER');
                // } else {
                //   setState(() {
                //     // file = File(
                //     //     result.files.single.path!);
                //     fileTwo = File(
                //         result.files.single.path!);
                //     nameFile =
                //         result.files.single.name;
                //   });
                //   // setState(() {});
                //   print(fileTwo!.path);
                // }
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/addFile.png",
                      width: 35,
                      height: 35,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      ' Selecionar Archivo ',
                      style: TextStyleOptionsHome.styleText,
                    ),
                  ],
                ),
              ),
            ),
            if (nameFiles.isEmpty)
              const Text('NO HAY ARCHIVOS SELECCIONADOS')
            else
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Archivos nuevos'),
                  SizedBox(
                      height: 40,
                      child: Wrap(
                        // scrollDirection: Axis.horizontal,
                        children: List.generate(
                          nameFiles.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                nameFiles[index],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// by add syllabas.......

class MyDialogSubject extends StatefulWidget {
  const MyDialogSubject({super.key, required this.formSubject});
  final FormSubjectProvider formSubject;
  @override
  State<MyDialogSubject> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialogSubject> {
  String _tema = '';
  List<String> _subtemas = [];
  String? subtema;
  final TextEditingController _temaController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subtema = _temaController.text;
  }

  /// Creamos un Map
  /// que recibe dos campors

  Map<String, dynamic> syllabas(String namteTem, List<String> subtems) {
    Map<String, dynamic> syllaba = {"nameTema": namteTem, "subtemas": subtems};
    return syllaba;
  }

  int selectedPartial = 0;
  int selectedUnit = 0;
  int? selectedTopic;

  final partials = ['Primer Parcial', 'Segundo parcial', 'Tercer Parcial'];

  final listUnits = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  String tipicsByPartial = '';

  bool addNewPartial = false;
  bool addNewUnit = false;
  late Subjects subject;

  bool status = false;
  // BuildContext dialogContext;

  void _showDialog() {
    setState(() {
      status = true;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        context = context;
        return AlertDialog(
          title: const Text('Título'),
          content: const Text('Contenido'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                setState(() {
                  status = false;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final subjectServices = Provider.of<SubjectServices>(context);
    isDark =
        Provider.of<ThemeProvier>(context).currentTheme == ThemeData.dark();
    final size = MediaQuery.of(context).size;
    subject = widget.formSubject.subject;

    return AlertDialog(
      title: const Text('Agregar tema'),
      content: SizedBox(
        // color: Colors.red,
        width: size.width * .6,
        height: size.height * .7,
        child: subject.syllabas.isEmpty || addNewPartial == true
            ? syllabaIsEmpty(subjectServices, subject, context, size)
            : addSyllaba(subjectServices, subject, size, context),
      ),
      actions: [
        // Botón para agregar el tema
        ElevatedButton(
          onPressed: () async {
            List<Syllaba> newListSyllabas = [];

            // si syllabas esta vacion....
            if (subject.syllabas.isEmpty) {
              // temas  y subtemas....
              final topics = Topics(themeName: _tema, subtopics: _subtemas);
              final unitThemes = UnitTheme(topics: topics);
              List<UnitTheme> listUnitTheme = [];
              listUnitTheme.add(unitThemes);

              final listInits =
                  ListUnit(unitNumber: 0, unitThemes: listUnitTheme);

              List<ListUnit> listsInits = [];
              listsInits.add(listInits);

              final syllaba = Syllaba(
                  partial: partials[0],
                  topicsOfPartialSubject: tipicsByPartial,
                  listUnits: listsInits);

              newListSyllabas.add(syllaba);

              final nnn = await subjectServices.addSyllabasBySubject(
                  syllaba, subject.uid);
              return;
            }
            // si se estra agregando mas parciales......
            if (addNewPartial == true) {
              if (subject.syllabas.length == 3) {
                ShowDialogError.showDialogError(
                    context,
                    const Icon(Icons.topic),
                    'Craer parcial',
                    'Solo se permite agregar tres parciales, a la materia');
                return;
              }

              // temas  y subtemas....
              final topics = Topics(themeName: _tema, subtopics: _subtemas);
              final unitThemes = UnitTheme(topics: topics);
              List<UnitTheme> listUnitTheme = [];
              listUnitTheme.add(unitThemes);

              final listInits =
                  ListUnit(unitNumber: selectedUnit, unitThemes: listUnitTheme);

              List<ListUnit> listsInits = [];
              listsInits.add(listInits);

              final syllaba = Syllaba(
                  partial: partials[widget.formSubject.subject.syllabas.length],
                  topicsOfPartialSubject: tipicsByPartial,
                  listUnits: listsInits);

              newListSyllabas.add(syllaba);

              await subjectServices.addSyllabasBySubject(syllaba, subject.uid);
              // print(widget.formSubject.subject.syllabas);
              return;
            }

            // add new unit......
            if (addNewUnit == true) {
              Syllaba? syllaba;

              // verifica  cual parcial se ha selecinado
              // agregamos los datos.....

              late ListUnit newUnit;
              final topics = Topics(themeName: _tema, subtopics: _subtemas);
              final unitThemes = UnitTheme(topics: topics);
              List<UnitTheme> listUnitTheme = [];
              listUnitTheme.add(unitThemes);

              // lenght units

              final lengthListUnits = subjectServices.syllaba!.listUnits.length;
              final unit = ListUnit(
                  unitNumber: lengthListUnits, unitThemes: listUnitTheme);

              List<ListUnit> listsInits = [];
              listsInits.add(unit);

              // final syllaba = Syllaba(
              //     partial: partials[selectedPartial],
              //     topicsOfPartialSubject: tipicsByPartial,
              //     listUnits: listsInits);

              switch (selectedPartial) {
                // saddd units-

                case 0:
                  syllaba = subject.syllabas[selectedPartial];
                  syllaba.listUnits.add(unit);

                  _showDialog();
                  // print(syllaba);
                  // subjectServices.updateSyllabasBySubject(syllaba, subject.uid);

                  break;
                case 1:
                  syllaba = subject.syllabas[selectedPartial];
                  syllaba.listUnits.add(unit);
                  break;
                case 2:
                  syllaba = subject.syllabas[selectedPartial];
                  syllaba.listUnits.add(unit);
                  break;
                default:
                  syllaba = subject.syllabas[selectedPartial];
                  syllaba.listUnits.add(unit);
              }

              if (syllaba == null) {
                ShowDialogError.showDialogError(
                    context,
                    const Icon(Icons.error),
                    'Selecionar parcial',
                    'No  has agregado datos temas y subrema de la unidad');
                return;
              }
              subjectServices.updateSyllabasBySubject(
                  syllaba, subject.uid, selectedPartial);
              return;
            }

            // // temas  y subtemas....
            // final topics = Topics(themeName: _tema, subtopics: _subtemas);
            // final unitThemes = UnitTheme(topics: topics);
            // List<UnitTheme> listUnitTheme = [];
            // listUnitTheme.add(unitThemes);

            // final listInits =
            //     ListUnit(unitNumber: selectedUnit, unitThemes: listUnitTheme);

            // List<ListUnit> listsInits = [];
            // listsInits.add(listInits);

            // final syllaba = Syllaba(
            //     partial: partials[selectedPartial],
            //     topicsOfPartialSubject:
            //         subject.syllabas[selectedPartial].topicsOfPartialSubject,
            //     listUnits: listsInits);

            // Syllaba s = Syllaba(
            //     partial: partials[selectedPartial],
            //     topicsOfPartialSubject: tipicsByPartial,
            //     listUnits: listsInits);
            // // widget.formSubject.subject.syllabas.add(syllaba);

            // if (subject.syllabas.isEmpty) {
            //   // subject.syllabas.add(syllaba);
            //   widget.formSubject.subject.syllabas.add(syllaba);

            //   subjectServices.updateSubject(widget.formSubject.subject);
            //   return;
            // }

            // // verificar cual opcion se ha selecionado...

            // final unitTheme = UnitTheme(
            //     topics: Topics(themeName: _tema, subtopics: _subtemas));
            // final topic = Topics(themeName: _tema, subtopics: _subtemas);

            // switch (selectedPartial) {
            //   case 0:
            //     final ss = subject.syllabas[selectedPartial];

            //     if (selectedTopic == null) {
            //       syllaba.listUnits[selectedUnit].unitThemes.add(unitTheme);
            //       // await subjectServices.addSyllabasBySubject(
            //       //     syllaba, subject.uid);
            //     } else {
            //       syllaba.listUnits[selectedUnit].unitThemes[selectedTopic!]
            //           .topics.subtopics
            //           .addAll(_subtemas);

            //       // await subjectServices.addSyllabasBySubject(
            //       //     syllaba, subject.uid);
            //     }

            //     break;
            //   case 1:
            //     if (selectedTopic == null) {
            //       syllaba.listUnits[selectedUnit].unitThemes.add(unitTheme);
            //       return;
            //     }
            //     syllaba.listUnits[selectedUnit].unitThemes[selectedTopic!]
            //         .topics.subtopics
            //         .addAll(_subtemas);

            //     final ss = subjectServices.syllaba = s;
            //     widget.formSubject.subject.syllabas.add(ss);
            //     // await subjectServices.addSyllabasBySubject(
            //     //     syllaba, subject.uid);

            //     // subjectServic
            //     // .updateSubject(widget.formSubject.subject.syllabas.add(ss)
            //     // );

            //     break;
            //   case 2:
            //     if (selectedTopic == null) {
            //       syllaba.listUnits[selectedUnit].unitThemes.add(unitTheme);
            //     }
            //     syllaba.listUnits[selectedUnit].unitThemes[selectedTopic!]
            //         .topics.subtopics
            //         .addAll(_subtemas);
            //     break;

            //   default:
            //     syllaba.listUnits[0].unitThemes.add(unitTheme);
            // }

            //  subject.syllaba =

            // verificar sual unidad se esta agregando...

            // final subjectServices =
            //     Provider.of<SubjectServices>(context, listen: false);
            // // Cierra el showDialog

            // // Map<String, dynamic> syllaba = syllabas(_tema, _subtemas);

            // List<SyllabaElement> syllaba = [];
            // syllaba.add(SyllabaElement(
            //     partial: selectedIndex!,
            //     topics: Topics(themeName: _tema, subtopics: _subtemas)));

            // Navigator.of(context).pop();
            // // esta parte se ha modificado
            // final s = Syllaba(syllabas: syllaba);
            // widget.formSubject.subject.syllabas.add(s);
            // // Imprime los temas y subtemas

            // // subjectServices.updateSubject(widget.formSubject.subject);
          },
          child: Text('Guardar'),
        ),
        ElevatedButton(
          onPressed: () {
            // Cierra el showDialog
            Navigator.of(context).pop();
            // Imprime los temas y subtemas
          },
          child: Text('Salir'),
        ),
      ],
    );
  }

  Column addSyllaba(SubjectServices subjectServices, Subjects subject,
      Size size, BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // si es parcial no so treas agregar la opcion de agregar mas
        Row(
          children: [
            listPartials(widget.formSubject.subject, subjectServices),
            if (subject.syllabas.length < 3)
              TextButton(
                  onPressed: () {
                    setState(() {
                      addNewPartial = true;
                      final cout = widget.formSubject.subject.syllabas.length;

                      selectedPartial = cout + 1;
                    });
                    // print('Partial que se agregara$selectedPartial');
                  },
                  child: const Row(
                    children: [
                      // Text('Agregar'),
                      Icon(Icons.add),
                    ],
                  )),
          ],
        ),

        // listsPartials(subjectServices, subject),
        const SizedBox(
          height: 5,
        ),
        subjectServices.syllaba == null
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    SizedBox(
                        height: 70,
                        width: 80,
                        child: Image.asset("assets/search2.png")),
                    Text(
                      'Selecionad un parcial',
                      style: TextStyleOptionsHome.styleText,
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '° Tema principal del parcial:' +
                              "    " +
                              subjectServices.syllaba!.topicsOfPartialSubject,
                          style: TextStyleOptionsHome.styleText,
                        ),
                        Row(
                          children: [
                            Text(
                              '° Unidades parcial  ( $selectedPartial ) : ',
                              style: TextStyleOptionsHome.styleText,
                            ),
                            SizedBox(
                              width: 500,
                              height: 30,
                              child: MyScrollConfigure(
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(
                                      subject.syllabas[selectedPartial]
                                          .listUnits.length,
                                      (index) => TextButton(
                                          onPressed: () {
                                            setState(() {
                                              selectedUnit = index;
                                              addNewUnit = false;
                                            });
                                          },
                                          child: Text(
                                              'Unidad  ${subject.syllabas[selectedPartial].listUnits[index].unitNumber}'))),
                                ),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    addNewUnit = true;
                                    // selectedUnit = selectedUnit + 1;
                                    addNewUnit = true;
                                    print('Add unit by partial');
                                  });
                                },
                                icon: const Icon(Icons.add))
                          ],
                        ),
                        SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              Text(
                                '° Temas de la unidad  ( $selectedUnit ) :',
                                style: TextStyleOptionsHome.styleText,
                              ),
                              SizedBox(
                                width: 300,
                                child: MyScrollConfigure(
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: List.generate(
                                        subject
                                            .syllabas[selectedPartial]
                                            .listUnits[selectedUnit]
                                            .unitThemes
                                            .length,
                                        (index) => TextButton(
                                            onPressed: () {
                                              setState(() {
                                                selectedTopic = index;
                                              });
                                            },
                                            child: Text(subject
                                                .syllabas[selectedPartial]
                                                .listUnits[selectedUnit]
                                                .unitThemes[index]
                                                .topics
                                                .themeName))),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    form(subject, context, size, isDark),
                  ],
                ),
              )
      ],
    );
  }

  Widget syllabaIsEmpty(SubjectServices subjectServices, Subjects subject,
      BuildContext context, Size size) {
    return SingleChildScrollView(
      child: Column(
        children: [
          listPartials(subject, subjectServices), // parte de subjeccts
          // listsPartials(
          //     subjectServices, subject), // agregado solo en esta vista
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Selecciona la unidad'),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 30,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                        listUnits.length,
                        (index) => TextButton(
                            onPressed: () {
                              setState(() {
                                selectedUnit = index;
                              });
                            },
                            child: Text(listUnits[index].toString())))),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),

          form(subject, context, size, isDark),
        ],
      ),
    );
  }

  SizedBox listsPartials(SubjectServices subjectServices, Subjects subject) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
            partials.length,
            (index) => TextButton(
                onPressed: () {
                  setState(() {
                    if (subject.syllabas.isNotEmpty) {
                      subjectServices.syllaba = subject.syllabas[index];
                      selectedPartial = index;
                    }

                    selectedPartial = index;
                  });
                },
                child: Text(partials[index]))),
      ),
    );
  }

// form add syllaba
  Widget form(Subjects subject, BuildContext context, Size size, bool isDark) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: isDark ? Colors.white24 : Colors.black26),
          // color: Colors.blue,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [formAddData(subject, context, size), listSubtopics(size)],
      ),
    );
  }

  Widget listSubtopics(Size size) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: isDark ? Colors.white24 : Colors.black26),
            // color: Colors.blue,
            borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lista de subjetemas',
                style: TextStyleOptionsHome.styleText,
              ),
              const SizedBox(height: 20),
              listSubTopics(size, isDark)
            ],
          ),
        ),
      ),
    );
  }

  Column formAddData(Subjects subject, BuildContext context, Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        subject.syllabas.isEmpty || addNewPartial == true
            ? SizedBox(
                width: size.width * 0.2,
                child: TextFormField(
                  maxLines: 3,
                  minLines: 1,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 16),
                  decoration: const InputDecoration(
                    labelText: 'Tema principal de partial',
                  ),
                  onChanged: (value) {
                    tipicsByPartial = value;
                    setState(() {});
                  },
                ))
            : Container(),
        tipics(size),
        // Campo para agregar subtemas

        subTopics(context, size),
        // Campo para ingresar el tema
      ],
    );
  }

  Widget listSubTopics(Size size, bool isDark) {
    return SizedBox(
      // color: Colors.blue,
      height: size.height * 0.3,
      width: size.width * 0.3,
      child: ListView(
        clipBehavior: Clip.antiAlias,
        // direction: Axis.horizontal,
        children: List.generate(
            _subtemas.length,
            (index) => Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: isDark ? Colors.white12 : Colors.white24),
                      // color: Colors.blue,
                      borderRadius: BorderRadius.circular(6)),
                  // width: size.width * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('$index.-   ${_subtemas[index]}'),
                  ),
                )),
      ),
    );
  }

  SizedBox tipics(Size size) {
    return SizedBox(
      width: size.width * 0.25,
      child: TextField(
        maxLines: 4,
        minLines: 1,
        style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
        decoration: const InputDecoration(
          labelText: 'Tema',
        ),
        onChanged: (value) {
          _tema = value;
        },
      ),
    );
  }

  SizedBox subTopics(BuildContext context, Size size) {
    return SizedBox(
      width: size.width * 0.25,
      child: TextField(
        maxLines: 4,
        minLines: 2,
        controller: _temaController,
        decoration: InputDecoration(
          labelText: 'Subtema',
          suffix: IconButton(
              onPressed: () {
                print('Tema: $_tema, subtemas: $_subtemas');
                if (subtema!.isEmpty) {
                  print('Tien que agregar algun subtema');

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('No se agregó ningún subtema'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Aceptar'),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }
                _subtemas.add(subtema!);

                _temaController.clear();

                subtema = _temaController.text;
                setState(() {});
              },
              icon: const Icon(Icons.add)),
        ),
        onChanged: (value) {
          // _subtemas.add(value);
          subtema = value;
        },
      ),
    );
  }

  Widget listPartials(Subjects subject, SubjectServices subjectServices) {
    return Card(
      child: SizedBox(
        width: 600,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                  subject.syllabas.length,
                  (index) => TextButton(
                      onPressed: () {
                        setState(() {
                          subjectServices.syllaba = subject.syllabas[index];
                          selectedPartial = index;
                          addNewPartial = false;
                        });
                      },
                      child: Text(
                        subject.syllabas[index].partial,
                        style: TextStyleOptionsHome.styleText,
                      )))),
        ),
      ),
    );
  }
}
