import 'package:flutter/material.dart';

class ScreenGroupChat extends StatefulWidget {
  const ScreenGroupChat({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ScreenGroupChat> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _messages = [];

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(0, text);
    });
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onChanged: (String text) {
                setState(
                    () {}); // Actualizar el estado para habilitar/deshabilitar el botón de envío
              },
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: _textController.text.isEmpty
                  ? null
                  : () => _handleSubmitted(_textController.text),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contacts = [
      Contact(
        'Alice',
      ),
      Contact(
        'Bob',
      ),
      Contact(
        'Alice',
      ),
      Contact(
        'Bob',
      ),
      Contact(
        'Alice',
      ),
      Contact(
        'Bob',
      ),
      Contact(
        'Alice',
      ),
      Contact(
        'Bob',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: <Widget>[
            // Lista de contactos en el lado izquierdo
            Flexible(
              flex: 1,
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(contacts[index].name),
                    onTap: () {
                      // Seleccionar el contacto y mostrar la vista de chat
                    },
                  );
                },
              ),
            ),
            // Vista de chat en el lado derecho
            Flexible(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      reverse: true,
                      itemCount: _messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(title: Text(_messages[index]));
                      },
                    ),
                  ),
                  const Divider(height: 1.0),
                  Container(
                    decoration: BoxDecoration(color: Theme.of(context).cardColor),
                    child: _buildTextComposer(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// pra la sala de  char  de 1 a 1
  // @override
  // Widget build(BuildContext context) {
  //     // Detectar si la aplicación se está ejecutando en Windows o Mac
  // final isWindowsOrMac = Theme.of(context).platform == TargetPlatform.windows ||
  //     Theme.of(context).platform == TargetPlatform.macOS;
  //   return Scaffold(
  //     appBar: AppBar(title: Text('Chat')),
  //     body: Padding(
  //  padding: EdgeInsets.only(
  //       bottom: isWindowsOrMac ? 50.0 : 0.0,), // Agregar un padding
  //       child: Column(
  //         children: <Widget>[
  //           Flexible(
  //             child: ListView.builder(
  //               padding: EdgeInsets.all(8.0),
  //               reverse: true,
  //               itemCount: _messages.length,
  //               itemBuilder: (BuildContext context, int index) {
  //                 return ListTile(title: Text(_messages[index]));
  //               },
  //             ),
  //           ),
  //           Divider(height: 1.0),
  //           Container(
  //             decoration:
  //                 BoxDecoration(color: Theme.of(context).cardColor),
  //             child: _buildTextComposer(),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

// colase para lso contacdtso
class Contact {
  final String name;

  // constructor
  Contact(this.name);
}
