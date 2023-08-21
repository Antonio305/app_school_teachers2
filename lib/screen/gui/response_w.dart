import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/response_notifier.dart';

class ResponseWindow extends StatelessWidget {
  const ResponseWindow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        width: double.infinity,
        color: Colors.lightBlue[100],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: context.watch<ResponseNotifier>().responseWidget,
          ),
        ),
      ),
    );
  }
}