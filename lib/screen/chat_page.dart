import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/Services.dart';
import 'package:preppa_profesores/Services/chat/chat_services.dart';
import 'package:preppa_profesores/Services/chat/socket_servives.dart';
import 'package:preppa_profesores/models/chat/messages.dart';
import 'package:preppa_profesores/models/subjects.dart';
import 'package:preppa_profesores/providers/isMobile.dart';
import 'package:preppa_profesores/widgets/utils/style_ElevatedButton.dart';
import 'package:provider/provider.dart';

import 'chat/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = [];

  bool status = false;

  ChatServices? chatService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatService = Provider.of<ChatServices>(context, listen: false);
  }

  int indexSelectedStudent = 0;
  int indexSubjectSelected = 0;

  void cargarChat(String usuarioID) async {
    List<Message> chat = await chatService!.getMessage(usuarioID);

    print(chat);
    final history = chat.map(
      (e) => ChatMessage(
          text: e.message,
          uid: e.de,
          animationController: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 0))
            ..forward()),
    );

    // agergar ala colecion de mensajes
    setState(() {
      _messages.insertAll(0, history);
    });
  }

  @override
  Widget build(BuildContext context) {
    final subjectServices = Provider.of<SubjectServices>(context);
    final subjects = subjectServices.subjects;
    final size = MediaQuery.of(context).size;
    final studentSubjectsServices = Provider.of<StudentServices>(context);

    return Scaffold(
      // appBar: AppBar(title: const Text('Chats')),
      body: Padding(
        padding: IsMobile.isMobile()
            ? const EdgeInsets.symmetric(horizontal: 8)
            : const EdgeInsets.symmetric(horizontal: 38),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text('Chats',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        color: Colors.indigo.withOpacity(0.5),
                        offset: const Offset(1, 1),
                        blurRadius: 1,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              _listSubject(subjects, size),
              const SizedBox(
                height: 10,
              ),
              // IsMobile.isMobile()
              //     ? Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           ListStudent(studentSubjectsServices, size),
              //           status == false
              //               ? Container(
              //                   // color: Colors.red,
              //                   // width: double.infinity,
              //                   width: Platform.isAndroid || Platform.isIOS
              //                       ? size.width * 0.9
              //                       // ? 500
              //                       : size.width * 0.45,
              //                   height: size.height * 0.5,
              //                   // color: Colors.red,
              //                   decoration: BoxDecoration(
              //                     color:
              //                         const Color(0xff13162C).withOpacity(0.4),
              //                     borderRadius: BorderRadius.circular(10),
              //                   ),
              //                 )
              //               : ChatPageBody(messages: _messages)
              //         ],
              //       )
              //     :

              ListStudent(studentSubjectsServices, size),
            ]),
      ),
    );
  }

  Flexible ListStudent(StudentServices studentSubjectsServices, Size size) {
    final student = studentSubjectsServices.studentBySubject;
    return Flexible(
      child: Container(
        // color: Colors.red,
        // width: double.infinity,
        // width: IsMobile.isMobile() ? size.width * 0.9 : size.width * 0.5,
        // // ? 500
        // height: IsMobile.isMobile() ? size.height * 0.68 : size.height * 0.7,
        decoration: BoxDecoration(
          // color: const Color(0xff13162C).withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: studentSubjectsServices.status == true
            ? const Center(child: CircularProgressIndicator())
            : student.isEmpty
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/search.png', width: 150, height: 150),
                      const Text('LISTA VACIA - SELECCIONAR MATERIA Y GRUPO'),
                    ],
                  ))
                : ListView.builder(
                    // shrinkWrap: true,
                    itemCount: student.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                          /**
                           * windows y mac , cargar os archivos desde aca
                           */

                          // Students? userPara;

                          // SI ESTAMOS EL WIJDOS SOLO CARGAMOS LOS CHATS, PEROSI ESTAMOS EN UN MOVIL
                          // HACMEOS LA NAVEGACION A LA OTRA VISTA Y CARGAS LOS CHATS DE ESA VISTA
                          final chatServices =
                              Provider.of<ChatServices>(context, listen: false);

                          // if (IsMobile.isMobile() == true) {
                          // chatServices.userPara = student[index];
                          // status = true;
                          // setState(() {
                          //   indexSelectedStudent = index;
                          // });
                          // cargarChat(student[index].uid);

                          // return;
                          // }

                          chatServices.userPara = student[index];
                          setState(() {
                            indexSelectedStudent = index;
                          });

                          Navigator.pushNamed(context, 'chats_movil');
                          chatServices.userPara = student[index];

                          // ChatPageBody
                          // Navigator.pu
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: indexSelectedStudent == index
                                  ? Colors.purple.withOpacity(0.7)
                                  : Colors.transparent,
                              border:
                                  Border.all(width: 0.5, color: Colors.white10),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    child: Text(student[index].name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(student[index].name
                                      // "${student[index].name}  ${student[index].lastName}  ${student[index].secondName}",
                                      // style:
                                      //     const TextStyle(color: Colors.white54)
                                      ),
                                  const Spacer(),
                                  const Icon(Icons.chevron_right_rounded)
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  SizedBox _listSubject(List<Subjects> subjects, Size size) {
    return SizedBox(
      // color: Colors.red,
      // width: 700,
      height: 50,
      // color: Colors.red,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: subjects.length,
        // itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: indexSubjectSelected == index
                ? Colors.indigo.withOpacity(0.5)
                : Colors.transparent,
            semanticContainer: true,
            child: MaterialButton(
              onPressed: () async {
                openDialogByGroup(context, size, subjects[index]);
                setState(() {
                  indexSubjectSelected = index;
                });
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: size.height * 0.13,
                    // width: size.width * 0.14,
                    child: Center(
                        child: Text(subjects[index].name,
                            style: const TextStyle(color: Colors.white54))),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // for select group
  Future<String?> openDialogByGroup(
          BuildContext context,
          Size size,
          // String subjectId,
          Subjects subject) =>
      showDialog<String>(
          // barrierColor: Colors.red[200], // color de fondo del dialong
          context: context,
          builder: (context) {
            return Center(
              child: AlertDialog(
                icon: const Icon(Icons.subject),
                title: const Text('Seleciona un grupo'),
                content: ContentSelectGroup(subject: subject),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  ElevatedButton(
                      style: StyleElevatedButton.styleButton,
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Salir',
                      ))
                ],
              ),
            );
          });
}

class ContentSelectGroup extends StatefulWidget {
  final Subjects subject;

  const ContentSelectGroup({super.key, required this.subject});
  @override
  State<ContentSelectGroup> createState() => _SelectGroupState();
}

class _SelectGroupState extends State<ContentSelectGroup> {
  // intancr group

  @override
  Widget build(BuildContext context) {
    final groupServider = Provider.of<GroupServices>(context, listen: false);
    final groups = groupServider.group;
    final size = MediaQuery.of(context).size;

    return Wrap(
      children: List.generate(groups.groups.length, (index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: StyleElevatedButton.styleButton,
            onPressed: () async {
              setState(() {});
              // widget.group = groups.groups[index];
              final studentServices =
                  Provider.of<StudentServices>(context, listen: false);

              Navigator.pop(context);
              await studentServices.getStudentForGroupAndSubject(
                  groups.groups[index].uid, widget.subject.uid);
              // ignore: use_build_context_synchronously
            },
            child: Text(
              groups.groups[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        );
      }),
    );
  }
}

// clase para contener la lista de mensajes

class ChatPageBody extends StatefulWidget {
  final List<ChatMessage> messages;

  const ChatPageBody({super.key, required this.messages});

  @override
  State<ChatPageBody> createState() => _ChatPageBodyState();
}

class _ChatPageBodyState extends State<ChatPageBody>
    with TickerProviderStateMixin {
  bool writing = false;

  final TextEditingController _textController = TextEditingController();

  // controlador para el focus nods
  final _focusNode = FocusNode();

  // creo  una lista de chat Message
  // List<ChatMessage> _messages = [];

  // solo se declara ya se inicializa en el init State
  ChatServices? chatService;
  // socker
  late SocketService socketService;
// de quie se le envia el mensale
  // TeachaerServices? userService;

  TeachaerServices? authService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // aca no podemos redibujar nada, solo si estamos en un callback
    chatService = Provider.of<ChatServices>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<TeachaerServices>(context, listen: false);

    // PARA ESCUHAR EL MENAJE DEL EVENTO mensaje-personal

    socketService.socket.on("mensaje-personal", _escucharMensaje);

    // cargarChat(chatService!.userPara!.uid);

    // socketService.socket.on(
    //     'mensaje-personal', (data) => print('tengo mensaje de : ${data}'));
  }

  // craer un function
  void _escucharMensaje(dynamic payload) {
    print('tengo mensaje de : $payload');
    ChatMessage message = ChatMessage(
      text: payload['message'],
      uid: payload['de'],
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 800)),
    );

    // Actualizacion de la lista
    setState(() {
      widget.messages.insert(0, message);
    });

    // faltaba la animacion jaja
    message.animationController.forward();
  }

// fun cion para cargar la historias de chat
  // void cargarChat(String usuarioID) async {
  //   List<Message> chat = await chatService!.getMessage(usuarioID);

  //   print(chat);
  //   final history = chat.map(
  //     (e) => ChatMessage(
  //         text: e.message,
  //         uid: e.de,
  //         animationController: AnimationController(
  //             vsync: this, duration: const Duration(milliseconds: 0))
  //           ..forward()),
  //   );

  //   // agergar ala colecion de mensajes
  //   setState(() {
  //     _messages.insertAll(0, history);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.43,
      // height: 300,
      height: size.height * 0.75,

      child: Column(children: [
        Flexible(
          child: ListView.builder(
            reverse: true,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.messages.length,
            itemBuilder: (BuildContext context, int index) {
              return widget.messages[index];
            },
          ),
        ),

        /// caja de texto
        const Divider(
          height: 1,
        ),

        Container(
          // color: Colors.red,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(children: [
                // caja de texto
                Flexible(
                  child: TextField(
                    focusNode: _focusNode,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Enviar mensaje'),
                    controller: _textController,
                    // solo agrego la referencia
                    onSubmitted: _haldleSubmit,
                    // TODO: hay que saber cuando esta escribiendo, cuando hay un valor
                    onChanged: (value) {
                      setState(() {
                        if (value.trim().length > 1) {
                          writing = true;
                        } else {
                          writing = false;
                        }
                      });
                    },
                  ),
                ),
                // button

                Container(
                  child: Platform.isIOS
                      ? CupertinoButton(
                          onPressed: writing
                              ? () => _haldleSubmit(_textController.text)
                              : null,
                          child: const Text('Send'),
                        )
                      : IconButton(
                          onPressed: writing
                              ? () => _haldleSubmit(_textController.text)
                              : null,

                          icon: const Icon(Icons.send),
                          // DELETE ANIMATIN OCOLOR
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                ),
                // IconButton(onPressed: (){}, icon: )
              ]),
            ),
          ),
        )
      ]),
    );
  }

// para escuchar lo quehemos puesto
  _haldleSubmit(String text) async {
    if (text.trim().isEmpty) return;
    print(text);

    // este es para ios
    // solicitar el foco cuando se enviar los  mensjaes
    // en android n oes necesario
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      text: text,
      // elque esta logeado

      uid: authService!.teacherForID.uid,

      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 800)),
    );
    widget.messages.insert(0, newMessage);

    // una vex agergado en la lista inicar la animacin
    newMessage.animationController
        .forward(); // foward indica que es solo una vez
    setState(() {
      writing = false;
    });

// enviamos el mensaje
    // nombre del evento mensaje-personal
    socketService.emit('mensaje-personal', {
      'de': authService!.teacherForID.uid,
      'para': chatService!.userPara!.uid,
      'message': text
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //TODO: OFF DEL SOCKET

    // LIMIAR LAS INSTANCIA DEL ARREGLO DE ChatMessage
    //  teminamos las animaciones que se han creado
    for (ChatMessage message in widget.messages) {
      message.animationController.dispose();
    }
    // si no cierro wl socker puedo enviarle menaje a todo el mundo
    socketService.socket.off('mensaje-personal');

    super.dispose();
  }
}
