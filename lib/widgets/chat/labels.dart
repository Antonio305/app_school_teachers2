import 'package:flutter/material.dart';

class Labels extends StatefulWidget {
  final String textButtons;
  final String titleOptions;
  final String route;

  const Labels({Key? key, required this.textButtons, required this.titleOptions, required this.route}) : super(key: key);


  @override
  State<Labels> createState() => _LabelsState();
}

class _LabelsState extends State<Labels> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(widget.titleOptions,
          style: const TextStyle(fontSize: 15, color: Colors.black54)),
      GestureDetector(
          onTap: () {
            // print('fjlsdkjflk');
            Navigator.pushReplacementNamed(context, widget.route);
          },
          child: Text(
            widget.textButtons,
            style: TextStyle(
                fontSize: 15,
                color: Colors.blue[600],
                fontWeight: FontWeight.w500),
          )),
    ]);
  }
}
