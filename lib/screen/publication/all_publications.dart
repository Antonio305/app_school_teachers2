import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/publication_services.dart';
import 'package:preppa_profesores/models/publication.dart';
import 'package:preppa_profesores/providers/isMobile.dart';
import 'package:preppa_profesores/widgets/myScrollConfigure.dart';
import 'package:preppa_profesores/widgets/utils/styteTextPublication.dart';
import 'package:preppa_profesores/widgets/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/utils/border.dart';

class ScreenListPublications extends StatelessWidget {
  const ScreenListPublications({super.key});

  @override
  Widget build(BuildContext context) {
    final publicationServices = Provider.of<PublicationServices>(context);
    final size = MediaQuery.of(context).size;

    final publications = publicationServices.publications;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publicaciones'),
        centerTitle: true,
      ),
      body: IsMobile.isMobile()
          ? ListView.builder(
              itemCount: publications.length,
              itemBuilder: (BuildContext context, int index) {
                return CardPubliccation(
                  publication: publications[index],
                );
              },
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  // width: size.width * 0.25,
                  width: size.width * 0.25,
                  // height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('!Buscar por fecha de publicacion¡'),
                      TableCalendar(
                        // locale: 'en_US',
                        // locale: 'es_MX',
                        // selectedDayPredicate: (day) {
                          
                        // },
                          focusedDay: DateTime.now(),
                          firstDay: DateTime.utc(2020, 10, 1),
                          lastDay: DateTime.utc(2030, 3, 1)),
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width * 0.67,
                  child: Flexible(
                    child: ListView.builder(
                      itemCount: publications.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardPubliccation(
                          publication: publications[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class CardPubliccation extends StatelessWidget {
  final Publication publication;

  const CardPubliccation({super.key, required this.publication});

  @override
  Widget build(BuildContext context) {
    StyleTextPublication styleTextPublication;

    final size = MediaQuery.of(context).size;
    final publicationServices = Provider.of<PublicationServices>(context);

    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, 'update_publication',
        //     arguments: publication);
        publicationServices.publicationSelected = publication.withCopy();

        Navigator.pushNamed(context, 'show_publications');
      },
      child: Center(
          child: IsMobile.isMobile()
              ? contentMobile(size, context)
              : contentDesktp(size, context)),
    );
  }

  Widget contentMobile(Size size, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Container(
        width: IsMobile.isMobile() ? size.width : size.width * 0.7,
        // height: 200,
        // color: Colors.red,
        // decoration: MyBorder.myDecorationBorder(Colors.transparent),
        decoration: BoxDecoration(
          borderRadius: MyBorder.myBorderRadius(),
          border: Border.all(
              color: ThemeSelected.isDarkTheme(context)
                  ? Colors.white10
                  : Colors.black12),
        ),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avatar(),
                const SizedBox(width: 7),
                SizedBox(
                  width: IsMobile.isMobile()
                      ? size.width * 0.8
                      // : size.width * 0.65,
                      : 400,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      authorPublication(context),
                      const SizedBox(
                        height: 8,
                      ),
                      titlePublication(context),
                      const SizedBox(
                        height: 8,
                      ),
                      listImagesPublication(size),
                      const SizedBox(
                        height: 6,
                      ),
                      publication.description == null
                          ? const SizedBox()
                          : Text(
                              publication.description!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: StyleTextPublication.styleDescription(
                                  context),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget contentDesktp(Size size, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Container(
        width: size.width * 0.7,
        decoration: BoxDecoration(
          // color: Colors.blue,
          borderRadius: MyBorder.myBorderRadius(),
          border: Border.all(
              color: ThemeSelected.isDarkTheme(context)
                  ? Colors.white10.withOpacity(0.07)
                  : Colors.black12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avatar(),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  // color: Colors.red,
                  // width: size.width * 0.25,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const SizedBox(
                        height: 5,
                      ),

                      authorPublication(context),
                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          listImagesPublication(size),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              titlePublication(context),
                              const SizedBox(
                                height: 20,
                              ),
                              publication.description == null
                                  ? const SizedBox()
                                  : SizedBox(
                                      width: size.width * 0.35,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          publication.description!,
                                          // overflow: TextOverflow.ellipsis,
                                          maxLines: 10,
                                          style: StyleTextPublication
                                              .styleDescription(context),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const SizedBox(
                      //       height: 6,
                      //     ),
                      //     publication.description == null
                      //         ? const SizedBox()
                      //         : Container(
                      //             width: size.width * 0.4,
                      //             child: Column(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceEvenly,
                      //               children: [
                      //                 titlePublication(context),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 Text(
                      //                   publication.description!,
                      //                   overflow: TextOverflow.ellipsis,
                      //                   // maxLines: 5,
                      //                   style: StyleTextPublication
                      //                       .styleDescription(context),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text titlePublication(BuildContext context) {
    return Text(publication.title,
        style: StyleTextPublication.styleTile(context, 15.5));
  }

  Row authorPublication(BuildContext context) {
    return Row(
      children: [
        Text(
            "${publication.author!.name} ${publication.author!.lastName}"
            // +
            // " " +
            // publication
            //     .author!
            // .secondName
            ,
            style: StyleTextPublication.styleAuthor(context, 13)),
        const SizedBox(
          width: 3,
        ),
        Text(
          '( ${publication.author!.rol} )',
          style: StyleTextPublication.styleRolAuthor(context),
        ),
      ],
    );
  }

  CircleAvatar avatar() {
    return const CircleAvatar(radius: 20, child: Icon(Icons.person, size: 30));
  }

  SizedBox listImagesPublication(Size size) {
    return SizedBox(
      height: publication.description == null ? 300 : size.height * 0.5,
      width: IsMobile.isMobile() ? size.width * 0.8 : size.width * 0.25,
      child: MyScrollConfigure(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                SizedBox(
                  // width: 220,
                  width: IsMobile.isMobile()
                      ? size.width * 0.8
                      : size.width * 0.25,

                  height: publication.description == null ? 400 : 400,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://acf.geeknetic.es/imagenes/auto/2020/9/10/9p1-valorant-cuales-son-los-mejores-personajes.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    right: 0,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.download_for_offline))),
              ],
            );
          },
        ),
      ),
    );
  }
}
