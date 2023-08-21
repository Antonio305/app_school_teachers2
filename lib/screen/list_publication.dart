import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/publication_services.dart';
import '../models/publication.dart';

class ListPublicationScreen extends StatefulWidget {
  const ListPublicationScreen({super.key});

  @override
  State<ListPublicationScreen> createState() => _ListPublicationScreenState();
}

class _ListPublicationScreenState extends State<ListPublicationScreen> {
  // crete lsit tupe publication
  late List<Publication> publications = [];

  List<String> links = [
    'https://www.mundogatos.com/Uploads/mundogatos.com/ImagenesGrandes/fotos-de-gatitos-7.jpg',
    'https://i.pinimg.com/originals/f0/50/45/f05045dac9cb83f7665e8634581f5151.jpg',
    'https://i.pinimg.com/originals/f0/50/45/f05045dac9cb83f7665e8634581f5151.jpg',
    'https://i.pinimg.com/originals/f0/50/45/f05045dac9cb83f7665e8634581f5151.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final publicationServices = Provider.of<PublicationServices>(context);
    final publication = publicationServices.publication;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('PUBLICACIONES')),
      body: Container(
        child: publicationServices.status == true
            ? const CircularProgressIndicator()
            : Center(
                child: SingleChildScrollView(
                  child: Wrap(
                    clipBehavior: Clip.hardEdge,
                    children: List.generate(
                      publication.length,
                      (index) => GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, 'update_publication',
                          //     arguments: publication[index]);

                          Navigator.pushNamed(context, 'show_publication',
                              arguments: publication[index]);
                        },
                        child: Container(
                          // margin: const EdgeInsets.only(bottom: 10),
                          // semanticContainer: true,
                          // borderOnForeground: true,
                          decoration: const BoxDecoration(
                              // color: Color(0xff25282F),
                              border: Border.symmetric(
                                  horizontal: BorderSide(
                                      color: Colors.white12, width: 0.5))),

                          // color: Colors.red,
                          child: SizedBox(
                            width: Platform.isAndroid || Platform.isIOS
                                ? size.height
                                : 270,
                            // height: 200,
                            // color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                      radius: 20,
                                      child: Icon(Icons.person, size: 30)),
                                  const SizedBox(width: 7),
                                  SizedBox(
                                    width: Platform.isAndroid || Platform.isIOS
                                        ? size.width * 0.78
                                        : 220,
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              publication[index].author!.name +
                                                  " " +
                                                  publication[index]
                                                      .author!
                                                      .lastName
                                              // +
                                              // " " +
                                              // publication[index]
                                              //     .author!
                                              // .secondName
                                              ,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              '( ${publication[index].author!.rol} )',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.white54,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          publication[index].title,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white60),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        SizedBox(
                                          // width: 220,
                                          width: Platform.isAndroid ||
                                                  Platform.isIOS
                                              ? size.width * 0.98
                                              : 220,

                                          height:
                                              publication[index].description ==
                                                      null
                                                  ? 300
                                                  : 330,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                links.first,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          // ListView(
                                          //   scrollDirection: Axis.vertical,
                                          //   children: List.generate(links.length,
                                          //       (index) {
                                          //     return Padding(
                                          //       padding: const EdgeInsets.all(3.0),
                                          //       child: Image.network(links[index]),
                                          //     );
                                          //   }),
                                          // ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        publication[index].description == null
                                            ? const SizedBox()
                                            : Text(
                                                publication[index].description!,
                                                overflow: TextOverflow.visible,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white38),
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     showDialogAlert(context);
                      //   },
                      //   child: Card(
                      //     // color: Colors.red,
                      //     child: SizedBox(
                      //       width: Platform.isAndroid || Platform.isIOS
                      //           ? size.width
                      //           : size.width * 0.31,
                      //       // height: size.height * 0.1,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(10.0),
                      //         child: Column(children: [
                      //           Text(publications[index].title),
                      //           const SizedBox(height: 10),
                      //           Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Column(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 SizedBox(
                      //                   width: 220,
                      //                   height: 160,
                      //                   child: Image.asset(
                      //                     'assets/student.png',
                      //                     height: 180,
                      //                   ),
                      //                 ),
                      //                 Container(
                      //                   // width: 220,
                      //                   height: 60,
                      //                   child: Text(
                      //                     publications[index].description!,

                      //                     // style: TextStyle(  )
                      //                     overflow: TextOverflow.fade,
                      //                     softWrap: true, maxLines: 5,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           const Align(
                      //               alignment: Alignment.bottomRight,
                      //               child: Text('Fecha de publicacion')),
                      //         ]),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  // creste function
  void showDialogAlert(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Título de la alerta'),
          content: const Text('Mensaje de la alerta'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
