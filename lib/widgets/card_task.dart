import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/taskReceived.dart';
import 'package:preppa_profesores/widgets/myScrollConfigure.dart';
import 'package:provider/provider.dart';

import '../Services/task_services.dart';
import '../models/task/tasks.dart';
import '../providers/isMobile.dart';

class CardTask extends StatefulWidget {
  final Tasks taskForStatusTrue;

  const CardTask({super.key, required this.taskForStatusTrue});

  @override
  State<CardTask> createState() => _CardTaskState();
}

class _CardTaskState extends State<CardTask> {
  // List<Tasks> widget .taskForStatusTrue = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final taskServices = Provider.of<TaskServices>(context);

    // widget .taskForStatusTrue = taskServices.widget .taskForStatusTrue;

    return Card(
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: _boxDecoration(),
          // height:  IsMobile.isMobile() ? 350 : 450,
          width: IsMobile.isMobile() ? 270 : 270,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                popupMenuButtonTask(context, size),
                detailTask(size, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding detailTask(Size size, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          subjectTask(),
          groupTask(),
          titleTask(),
          SizedBox(height: size.height * 0.01),
          // Text(widget.taskForStatusTrue.description, style: const TextStyle()),
          listFiles(),
          button(context),
          teacherBySubject(),
        ],
      ),
    );
  }

  Align teacherBySubject() {
    return Align(
        alignment: Alignment.bottomRight,
        child: Text(
          widget.taskForStatusTrue.teacherFullName(),
          style: const TextStyle(
            fontSize: 15,
            //    color: Color(0xffC9CACF)
          ),
        ));
  }

  ElevatedButton button(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final taskReceived =
            Provider.of<TaskReceivedServices>(context, listen: false);

        taskReceived.getIdReceivedTask(widget.taskForStatusTrue.id);

        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, 'studentTasktReceived');
      },
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(
            Icons.add,
            size: 20,
          ),
          Text('Entregadoss ',
              style: TextStyle(
                  // fontSize: 11,
                  // color: Color(0xffC9CACF)
                  )),
          Icon(Icons.chevron_right_rounded, size: 20),
        ]),
      ),
    );
  }

  Container listFiles() {
    return Container(
      color: Colors.black12,
      height: 39,
      child: widget.taskForStatusTrue.archivos == null
          ? const Text('No hay archivos')
          : MyScrollConfigure(
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      widget.taskForStatusTrue.archivos!.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.taskForStatusTrue.archivos![index],
                            ),
                          ))),
            ),
    );
  }

  Text titleTask() {
    return Text(widget.taskForStatusTrue.nameTask,
        maxLines: 6,
        style: const TextStyle(fontSize: 14, color: Color(0xff787B9A)));
  }

  Text groupTask() {
    return Text('GRUPO : ${widget.taskForStatusTrue.group.name}',
        style: const TextStyle(
          fontSize: 14,
          // color: Color(0xff787B9A)
        ));
  }

  Center subjectTask() {
    return Center(
      child: Text(widget.taskForStatusTrue.subject.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold
              // color: Color(0xffC9CACF)
              )),
    );
  }

  Positioned popupMenuButtonTask(BuildContext context, Size size) {
    return Positioned(
      right: 0,
      top: 0,
      child: CircleAvatar(
          child: menuTaskOption(
              context, size, widget.taskForStatusTrue.withCopy())),
      //  _EditButtom(
      //     context, widget .taskForStatusTrue.withCopy()),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      // color: const Color(0XFF131428).withOpacity(0.9),
      borderRadius: BorderRadius.circular(15),
    );
  }

  PopupMenuButton<String> menuTaskOption(
      BuildContext context, Size size, Tasks task) {
    return PopupMenuButton(
      tooltip: 'Mostrar menu',
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            // final taskServices =
            //     Provider.of<TaskServices>(context, listen: false);

            // taskServices.taskSelected = widget.tasks;

            // Navigator.pushNamed(context, 'edit_task');
          },
          value: '1',
          child: const Text('Editar tarea'),
        ),
        const PopupMenuItem(
          value: '2',
          child: Text('Eliminar tarea'),
        ),
        const PopupMenuItem(
          value: '3',
          child: Text('Ver tarea'),
        )
      ],
      onSelected: (value) {
        // print('Seleccionó la opción: $value');
        switch (value) {
          case '1':
            final taskServices =
                Provider.of<TaskServices>(context, listen: false);
            taskServices.taskSelected = task;

            Navigator.pushNamed(context, 'edit_task');
            break;
          case '2':
            confirmTaskDeletion(context, size, task);
            break;
          case '3':
            final taskServices =
                Provider.of<TaskServices>(context, listen: false);
            taskServices.taskSelected = task.withCopy();

            Navigator.pushNamed(context, 'show_task');
          default:
        }
      },
    );
  }

  Future<dynamic> confirmTaskDeletion(
      BuildContext context, Size size, Tasks task) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          icon: const Icon(Icons.delete),
          // title: const Text('Confirmación'),
          content: SizedBox(
            width: IsMobile.isMobile() ? size.width : size.width / 3,
            child: Text(
                '¿Está seguro de que desea eliminar esta tarea (${task.nameTask}) de la Materia ${task.subject.name} ?'),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar')),
            TextButton(onPressed: () {}, child: const Text('Confirmar'))
          ]),
    );
  }

  // Button edit
  MaterialButton _EditButtom(BuildContext context, Tasks task) {
    return MaterialButton(
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        // topLeft: Radius.circular(20),
        // bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        topRight: Radius.circular(10),
      )),
      // ignore: sort_child_properties_last
      child: const Icon(
        Icons.edit,
        color: Colors.white,
        size: 20,
      ),
      onPressed: () {
        // print(data.id);
        // openDialogEditTask(context);
        // ShowDialogEditTask.openDialogEditTask(context);
        final taskServices = Provider.of<TaskServices>(context, listen: false);

        taskServices.taskSelected = task;

        Navigator.pushNamed(context, 'edit_task');
      },
      minWidth: 40,
      height: 40,
      // color: Colors.amber[800],
      color: const Color(0xffFF8B65),
      // color: Color(0xff0F1222),
      //rgb(255,139,101)
    );
  }
}
