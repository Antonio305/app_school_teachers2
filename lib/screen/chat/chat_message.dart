import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/Services.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
// controlador par alas animaciones

  final AnimationController animationController;

// hay que savbe saber diferencia cual es el mio Y la de la otra persona

  final String text; // el  texto que se envia

// si el id es  igual al mio yo envie en  menaje caso contrari ode la otra persona
  final String uid;

  const ChatMessage(
      {Key? key,
      required this.animationController,
      required this.text,
      required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatServices = Provider.of<TeachaerServices>(context, listen: false);

    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        // curved es como queremos que sa, rapido al inicio, rapido al final etc
        // este me gusto bounceInOut
        sizeFactor: CurvedAnimation(
            parent: animationController, curve: Curves.bounceOut),
        child: Container(
            // color: Colors.red,
            // width: double.infinity,
            child: uid == chatServices.teacherForID.uid
                ? _myMesage()
                : notMyMessage()),
      ),
    );
  }

// DLE MADO DRECHO
  Widget _myMesage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, top: 5, left: 60, right: 10),
        decoration: BoxDecoration(
          // color: const Color(0xff4d9ef6),
          color: const Color(0xff242529),

          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(fontSize: 15, color: Colors.white60),
          ),
        ),
      ),
    );
  }

  Widget notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 60),
        decoration: BoxDecoration(
          color: const Color(0xff242529),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(text,
              style: const TextStyle(fontSize: 15,  color:  Colors.white60)),
        ),
      ),
    );
  }
}
