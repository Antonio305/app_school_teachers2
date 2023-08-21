// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class LoadingPage extends StatelessWidget {
//   const LoadingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: checkLoginState(context),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           return const Center(
//             child: Text('Espere...'),
//           );
//         },
//       ),
//     );
//   }

//   Future checkLoginState(BuildContext context) async {
//     final authService = Provider.of<AuthServices>(context, listen: false);
//     final socketService = Provider.of<SocketService>(context, listen: false);
//     final autentication = await authService.isLoggetIn(); //
//     if (autentication) {
//       socketService.connect();
//       // ignore: use_build_context_synchronously
//       Navigator.pushReplacement(context,   
//        PageRouteBuilder(pageBuilder: (_,__,___) {
//         return const UsuarioPage();
//       })
//       );
//       // PageRouteBuilder(pageBuilder: (BuildContext context,
//       //     Animation<double> animation, Animation<double> secondaryAnimation) {
//       //   return const UsuarioPage();
//       // });
//     } else {
//       // ignore: use_build_context_synchronously
//       Navigator.pushReplacement(
//           context,
//           PageRouteBuilder(
//               pageBuilder: (_, __, ___) => const LoginPage(),
//               transitionDuration: const Duration(milliseconds: 0)));
//     }
//   }
// }
