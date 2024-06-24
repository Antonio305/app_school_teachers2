import 'package:flutter/material.dart';
import 'package:preppa_profesores/providers/showDialogChats.dart';


class DraggableButton extends StatefulWidget {
  const DraggableButton({super.key});

  @override
  _DraggableButtonState createState() => _DraggableButtonState();
}

class _DraggableButtonState extends State<DraggableButton> {
  Offset position = const Offset(10.0, 10.0);

  bool _showOptions = false;

  void _toggleOptions() {
    setState(() {
      _showOptions = !_showOptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: position.dx,
          top: position.dy,

          // codigos mios ne la ual no funciona

          // bottom: position.dy,
          // height: position.dx,
          child: Draggable(
            onDraggableCanceled: (velocity, offset) {
              setState(() {
                position = offset;
              });
            },
            feedback: FloatingActionButton(
              onPressed: _toggleOptions,
              child: const Icon(Icons.drag_handle),
            ),
            child: Column(
              children: [
                FloatingActionButton.extended(
                  backgroundColor: Colors.blueAccent,
                  onPressed: () {
                    ShowDialogChat.showDialogChat(context);
                  },
                  label: const Row(children: [
                    Icon(Icons.chat_bubble_outline),
                    Text('CHATS')
                  ]),

                  // child: const Icon(Icons.drag_handle),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
