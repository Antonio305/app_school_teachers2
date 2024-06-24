import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preppa_profesores/providers/isMobile.dart';
import 'package:provider/provider.dart';

import '../Services/chat/chat_services.dart';
import '../Services/chat/socket_servives.dart';
import '../Services/teacher_services.dart';
import '../models/chat/messages.dart';
import 'chat/chat_message.dart';

class ChatPageBodyMovil extends StatefulWidget {
  const ChatPageBodyMovil({super.key});

  @override
  State<ChatPageBodyMovil> createState() => _ChatPageBodyState();
}

class _ChatPageBodyState extends State<ChatPageBodyMovil>
    with TickerProviderStateMixin {
  List<ChatMessage> messages = [];

  // List<ChatMessage> messages = [];

  bool writing = false;

  final TextEditingController _textController = TextEditingController();

  // controlador para el focus nods
  final _focusNode = FocusNode();

  // creo  una lista de chat Message
  // List<ChatMessage> messages = [];

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

    cargarChat(chatService!.userPara!.uid);

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
      messages.insert(0, message);
    });

    // faltaba la animacion jaja
    message.animationController.forward();
  }

// fun cion para cargar la historias de chat
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
      messages.insertAll(0, history);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('data ${chatService!.userPara!.name}'),
        centerTitle: true,
      ),
      body: Container(
          // margin: const EdgeInsets.all(20),
        width: size.width,
        // height: 300,
        // height: size.height * 0.75,
        height: size.height,

        child: Column(children: [
          Flexible(
            child: ListView.builder(
              reverse: true,
              physics: const BouncingScrollPhysics(),
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: IsMobile.isMobile()
                      ? const EdgeInsets.symmetric(horizontal: 8)
                      : const EdgeInsets.symmetric(horizontal: 20),
                  child: messages[index],
                );
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
                          hintText: 'Enviar mensjae'),
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
      ),
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
    messages.insert(0, newMessage);

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
    for (ChatMessage message in messages) {
      message.animationController.dispose();
    }
    socketService.socket.off('mensaje-personal');
    super.dispose();
  }
}
