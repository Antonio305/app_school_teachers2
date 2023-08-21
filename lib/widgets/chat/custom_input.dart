import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData iconData;
  final String placeholder;
  final TextEditingController textController;

  /// permite obtene el valor de la caja actual
  final TextInputType keyboarType;
  final bool isPassword;

  const CustomInput(
      {Key? key,
      required this.iconData,
      required this.placeholder,
      required this.textController,
      required this.keyboarType,
      required this.isPassword})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: textController,
        obscureText: isPassword,
        onChanged: (value) {},
        autocorrect: false,
        keyboardType: keyboarType,
        showCursor: false,
        decoration: InputDecoration(
            prefix: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(iconData),
            ),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: placeholder),
      ),
    );
  }
}
