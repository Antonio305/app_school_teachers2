import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/publication_services.dart';
import 'package:preppa_profesores/models/publication.dart';
import 'package:preppa_profesores/widgets/myScrollConfigure.dart';
import 'package:preppa_profesores/widgets/utils/border.dart';
import 'package:preppa_profesores/widgets/utils/styteTextPublication.dart';
import 'package:provider/provider.dart';

import '../../providers/isMobile.dart';

class ShowPublication extends StatefulWidget {
  const ShowPublication({Key? key}) : super(key: key);

  @override
  State<ShowPublication> createState() => _ShowPublicationState();
}

class _ShowPublicationState extends State<ShowPublication>
    with SingleTickerProviderStateMixin {
  // variables para el ontrolador de las animcaeions

  late final AnimationController _controllerAnimation;

// inciamos el controlador
  @override
  void initState() {
    super.initState();
    _controllerAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 50));
    _controllerAnimation.forward();
    // _controllerAnimation.repeat();
  }

  @override
  void dispose() {
    _controllerAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final publicationServices = Provider.of<PublicationServices>(context);

    final publication = publicationServices.publicationSelected;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(publication),
      body: body(publication, context, size),
    );
  }

  SafeArea body(Publication publication, BuildContext context, Size size) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: IsMobile.isMobile()
              ? const EdgeInsets.symmetric(horizontal: 10)
              : const EdgeInsets.symmetric(horizontal: 280),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(
              CurvedAnimation(
                  parent: _controllerAnimation,
                  // curve: Curves.easeInOut,
                  curve: Curves.bounceIn // me g usto mas
                  // curve: Curves.bounceInOut
                  // curve: Curves.easeInCubic // genial
                  // curve: Curves.easeInSine,
                  ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                // title
                titlePublication(publication, context),
                const SizedBox(
                  height: 30,
                ),

                listImagePublication(publication, size),
                const SizedBox(
                  height: 5,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.thumb_up)),
                    const Text('5'),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.thumb_down)),
                    const Text('12'),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                descriptionPublication(publication, context),
                const SizedBox(
                  height: 50,
                ),

                authotPublication(publication, context),

                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar(Publication publication) {
    return AppBar(
      // backgroundColor: const Color(0xff1C1D21),
      scrolledUnderElevation: 1, // sombre uqe aparece cuando se despleaza
      // flexibleSpace: Container(color: Colors.red,),
      bottomOpacity: 0,
      actionsIconTheme: const IconThemeData.fallback(),
      elevation: 0,
      title: Text(publication.title),
      centerTitle: true,
      // shadowColor: Colors.transparent,
    );
  }

  Widget authotPublication(Publication publication, BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Text(
            "${publication.author!.name}  ${publication.author!.lastName}  ${publication.author!.secondName}",
            style: StyleTextPublication.styleAuthor(context, 14)));
  }

  Widget descriptionPublication(Publication publication, BuildContext context) {
    return Text(publication.description!,
        style: StyleTextPublication.styleDescription(context));
  }

  Widget listImagePublication(Publication publication, Size size) {
    return Container(
      decoration: MyBorder.myDecorationBorder(null),
      height:
          publication.description == null || IsMobile.isMobile() ? 300 : 350,
      child: MyScrollConfigure(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Stack(
                children: [
                  SizedBox(
                    // width: 220,
                    width: IsMobile.isMobile() ? size.width * 0.775 : 350,

                    // height: publication.description == null ? 300 : 330,
                    height:
                        publication.description == null || IsMobile.isMobile()
                            ? 300
                            : 400,

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://acf.geeknetic.es/imagenes/auto/2020/9/10/9p1-valorant-cuales-son-los-mejores-personajes.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.download_for_offline))),
                ],
              ),
            );
          },
        ),
      ),
    );
    // return AnimatedBuilder(
    //     animation: _controllerAnimation,
    //     builder: (BuildContext context, Widget? child) {
    // return Container(
    //   transform: Matrix4.translationValues(
    //       _controllerAnimation.value * 8, 0, 20),
    //   decoration: MyBorder.myDecorationBorder(),
    //   height: publication.description == null ? 300 : 330,
    //   child: ListView.builder(
    //     scrollDirection: Axis.horizontal,
    //     itemCount: 10,
    //     itemBuilder: (BuildContext context, int index) {
    //       return Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 3),
    //         child: Stack(
    //           children: [
    //             SizedBox(
    //               // width: 220,
    //               width: IsMobile.isMobile() ? size.width * 0.775 : 220,

    //               height: publication.description == null ? 300 : 330,
    //               child: ClipRRect(
    //                 borderRadius: BorderRadius.circular(10),
    //                 child: Image.network(
    //                   'https://acf.geeknetic.es/imagenes/auto/2020/9/10/9p1-valorant-cuales-son-los-mejores-personajes.jpg',
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //             ),
    //             Positioned(
    //                 right: 0,
    //                 child: IconButton(
    //                     onPressed: () {},
    //                     icon: const Icon(Icons.download_for_offline))),
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );
    // });
  }

  Widget titlePublication(Publication publication, BuildContext context) {
    return Text(publication.title,
        style: StyleTextPublication.styleTile(context, 19));
    //   return AnimatedBuilder(
    //     animation: _controllerAnimation,
    //     builder: (BuildContext context, Widget? child) {
    //       return Container(
    //         transform:
    //             Matrix4.translationValues(_controllerAnimation.value * 20, 0, 0),
    //         child: Text(publication.title,
    //             style: StyleTextPublication.styleTile(context, 19)),
    //       );
    //     },
    //   );
  }
}
