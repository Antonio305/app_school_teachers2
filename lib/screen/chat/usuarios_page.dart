// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:provider/provider.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:real_time_chat/models/usuarios.dart';
// import 'package:real_time_chat/services/auth_services.dart';
// import 'package:real_time_chat/services/chat_services.dart';
// import 'package:real_time_chat/services/socket_servives.dart';
// import 'package:real_time_chat/services/user_services.dart';

// class UsuarioPage extends StatefulWidget {
//   const UsuarioPage({super.key});

//   @override
//   State<UsuarioPage> createState() => _UsuarioPageState();
// }

// class _UsuarioPageState extends State<UsuarioPage> {
//   final userService = UserServices();
//   // cremos ua lista de usuarios
//   List<User> users = [];
//   // controlador para el refresh
//   RefreshController _refreshController =
//       RefreshController(initialRefresh: false);

//   //  fucion que se ejecuta para que se actualize
//   void _onRefresh() async {
// // hacemos la llamdara del metodo de suarios
//     final userService = UserServices();
//     users = await userService.getUser();
//     // await Future.delayed(const Duration(microseconds: 1000));
//     _refreshController.refreshCompleted();
//     setState(() {});
//   }

//   //  para cargar los datos

//   void _onLoading() async {
//     await Future.delayed(const Duration(milliseconds: 100));
//     // users.add((users) );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _onRefresh();
//   }

//   //  crete list users
//   // final users = [
//   //   User(online: true, email: 'rojas@gmail.comd', name: 'lucas', uid: '0'),
//   //   User(online: false, email: 'preta@gmail.comd', name: 'prepta', uid: '1'),
//   //   User(online: true, email: 'dalila@gmail.comd', name: 'Dalila', uid: '2')
//   // ];
//   @override
//   Widget build(BuildContext context) {
//     final loginS = Provider.of<AuthServices>(context);
//     String user = loginS.user.name;
//     final socketS = Provider.of<SocketService>(context);
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(user),
//         elevation: 1,
//         leading: IconButton(
//           onPressed: () {
//             /// c8ando es un metodo de tipo eestatico no HACE FALTA HACERLA INSTANCIA DE LA CLASE CON  EL PROVIER
//             Navigator.pushReplacementNamed(context, 'login');
//             AuthServices.deleteToken();

//             socketS.disconnect();
//           },
//           icon: const Icon(Icons.exit_to_app),
//         ),
//         // esto cambiar dependido si tnemos coneccion o no
//         actions: [
//           Container(
//             color: Colors.red,
//             margin: const EdgeInsets.only(right: 15),
//             // falta co cofigurcion si tenemos coneccion o no
//             child: socketS.serverStatus == ServerStatus.Online
//                 ? const Icon(Icons.check_circle, color: Colors.black)
//                 : const Icon(Icons.offline_bolt, color: Colors.white),
//           )
//         ],
//       ),
//       body: SmartRefresher(
//           enableTwoLevel: true,
//           onRefresh: _onRefresh,
//           header: WaterDropHeader(
//               complete: Icon(Icons.check, color: Colors.blue[400]),
//               waterDropColor: Colors.blue),
//           controller: _refreshController,
//           child: _lsitViewUsuarios()),
//     );
//   }

//   ListView _lsitViewUsuarios() {
//     return ListView.separated(
//       physics: const BouncingScrollPhysics(),
//       itemCount: users.length,
//       separatorBuilder: (BuildContext context, int index) {
//         return Divider();
//       },
//       itemBuilder: (BuildContext context, int index) {
//         return _userListTile(users[index]);
//       },
//     );
//   }

//   AppBar appBar(String name) {
//     return AppBar(
//       centerTitle: true,
//       title: Text(name),
//       elevation: 1,
//       leading: IconButton(
//         onPressed: () {
//           /// c8ando es un metodo de tipo eestatico no HACE FALTA HACERLA INSTANCIA DE LA CLASE CON  EL PROVIER
//           Navigator.pushReplacementNamed(context, 'login');
//           AuthServices.deleteToken();
//           final socketS = Provider.of<SocketService>(context, listen: false);
//           socketS.disconnect();
//         },
//         icon: const Icon(Icons.exit_to_app),
//       ),
//       // esto cambiar dependido si tnemos coneccion o no
//       actions: [
//         Container(
//           color: Colors.red,
//           margin: const EdgeInsets.only(right: 15),
//           // falta co cofigurcion si tenemos coneccion o no
//           child: Icon(Icons.check_circle, color: Colors.blue[500]),
//           // Icon(Icons.offline_bolt, color: Colors.red),
//         )
//       ],
//     );
//   }

//   ListTile _userListTile(User users) {
//     return ListTile(
//       title: Text(users.name),
//       leading: CircleAvatar(
//         child: Text(users.name.substring(0, 2)),
//       ),
//       // subtitle: T,
//       subtitle: Text(users.email),
//       trailing: Container(
//         width: 15,
//         height: 15,
//         decoration: BoxDecoration(
//             color: users.online ? Colors.green[300] : Colors.red,
//             borderRadius: BorderRadius.circular(100)),
//       ),
//       onTap: () {
//         final chatServices = Provider.of<ChatServices>(context, listen: false);
//         chatServices.userPara = users;
//         Navigator.pushNamed(context, 'chat');
//       },
//     );
//   }
// }
