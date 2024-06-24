import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:preppa_profesores/providers/isMobile.dart';
import 'package:preppa_profesores/widgets/myScrollConfigure.dart';
import 'package:provider/provider.dart';

import '../Services/taskReceived.dart';
import '../Services/task_services.dart';
import '../models/task/tasks.dart';

class TaskCard extends StatefulWidget {
  final Tasks tasks;

  const TaskCard({super.key, required this.tasks});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      // borderOnForeground: true,
      margin: const EdgeInsets.only(bottom: 1),
      elevation: 1,
      child: SizedBox(
        height: 330,
        width: Platform.isAndroid || Platform.isIOS
            // ? 300
            ? size.width * 0.95
            : 270,
        // height: size.height * 0.16,
        // width: size.width * 0.16,
        child: Stack(
          children: [
            Positioned(
              right: 5,
              top: 5,
              // child: _EditButtom(context),
              child: CircleAvatar(child: menuTaskOption(context, size)),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  subject(),
                  group(),
                  nameTask(),
                  SizedBox(height: size.height * 0.01),
                  listFiles(),
                  buttonSendTask(context),
                  authoTask(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text nameTask() {
    return Text(
      widget.tasks.nameTask,
      style: const TextStyle(fontSize: 14),
      maxLines: 4,
    );
  }

  Center subject() {
    return Center(
      child: Text(widget.tasks.subject.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Row group() {
    return Row(
      children: [
        const Text('Grupo : '),
        Text(widget.tasks.group.name, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Align authoTask() {
    return Align(
        alignment: Alignment.bottomRight,
        child: Text(
          "${widget.tasks.userTeacher.name}  ${widget.tasks.userTeacher.lastName}  ${widget.tasks.userTeacher.secondName}",
          style: const TextStyle(fontSize: 14),
        ));
  }

  Widget buttonSendTask(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 00),
      child: ElevatedButton(
        // elevation: 5,
        onPressed: () async {
          final taskReceived =
              Provider.of<TaskReceivedServices>(context, listen: false);
          await taskReceived.getIdReceivedTask(widget.tasks.id);

          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, 'studentTasktReceived');
          // ignore: use_build_context_synchronously
          // Navigator.pushNamed(context, 'taskReceived');
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(
              Icons.add,
              size: 20,
            ),
            SizedBox(width: 10),
            Text('Entregados',
                style: TextStyle(
                  fontSize: 14,
                )),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.chevron_right_rounded, size: 20),
          ]),
        ),
      ),
    );
  }

  SizedBox listFiles() {
    return SizedBox(
      height: 39,
      child: widget.tasks.archivos == null
          ? const Text('No hay archivos')
          : MyScrollConfigure(
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      widget.tasks.archivos!.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.tasks.archivos![index]),
                          ))),
            ),
    );
  }

  PopupMenuButton<String> menuTaskOption(BuildContext context, Size size) {
    return PopupMenuButton(
      // texto que se muiestra cuando se para el cursor de raton....
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
        )
      ],
      onSelected: (value) {
        // print('Seleccionó la opción: $value');
        switch (value) {
          case '1':
            final taskServices =
                Provider.of<TaskServices>(context, listen: false);
            taskServices.taskSelected = widget.tasks;
            Navigator.pushNamed(context, 'edit_task');
            break;
          case '2':
            confirmTaskDeletion(context, size);
            break;
          case '3':
            final taskServices =
                Provider.of<TaskServices>(context, listen: false);
            taskServices.taskSelected = widget.tasks.withCopy();

            Navigator.pushNamed(context, 'show_task');
          default:
        }
      },
    );
  }

  Future<dynamic> confirmTaskDeletion(BuildContext context, Size size) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          icon: const Icon(Icons.delete),
          // title: const Text('Confirmación'),
          content: SizedBox(
            width: IsMobile.isMobile() ? size.width : size.width / 3,
            child: Text(
                '¿Está seguro de que desea eliminar esta tarea (${widget.tasks.nameTask}) de la Materia ${widget.tasks.subject.name} ?'),
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

  MaterialButton _EditButtom(BuildContext context) {
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
        // final taskServices = Provider.of<TaskServices>(context, listen: false);

        // taskServices.taskSelected = tasks;

        // Navigator.pushNamed(context, 'edit_task');

        // showModalBottomSheet(
        //   context: context,
        //   builder: (context) => MyBottomSheet(),
        // );
        optionTask(context);
      },
      minWidth: 40,
      height: 40,
      // color: Colors.amber[800],
      color: const Color(0xffFF8B65),
      // color: Color(0xff0F1222),
      //rgb(255,139,101)
    );
  }

  Future<dynamic> optionTask(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              // color: Colors.green,
            ),
            height: 350.0,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Opciones de la tarea",
                      textScaleFactor: 2,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  TextButton(
                      onPressed: () {}, child: const Text('Eliminar tarea')),
                  TextButton(
                      onPressed: () {}, child: const Text('Eliminar tarea'))
                ],
              ),
            ),
          );
        });
  }
}
