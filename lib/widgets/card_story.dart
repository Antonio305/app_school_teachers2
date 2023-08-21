

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';

import 'dart:io';

import '../Services/story_services.dart';
import '../models/story.dart';

class Story extends StatefulWidget {
  const Story({
    Key? key,
  }) : super(key: key);


  @override
  State<Story> createState() => _StoryState();
}

class _StoryState extends State<Story> {


  
  // create list types Storys
  List<Storys> storys = [];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final storyServices = Provider.of<StoryServices>(context);
    storys = storyServices.storysByStatusTrue;
    
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border:
              Border.all(width: 0.5, color: Colors.white70.withOpacity(0.1))),
      width: Platform.isAndroid || Platform.isIOS
          ? size.width * 0.96
          : size.width / 2.2,
      height: Platform.isAndroid || Platform.isIOS
          ? size.height * 0.3
          : size.height * 0.5,
      child: storys.isEmpty
          ? const Center(child: Text('No hay hostoarias que mostrar'))
          : CardSwiper(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              // threshold: 20,
              // maxAngle: 10,
              numberOfCardsDisplayed: 1,
              // isHorizontalSwipingEnabled: true,
              direction: CardSwiperDirection.left,
              cardsCount: storys.length,
              cardBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          width: 0.5, color: Colors.white70.withOpacity(0.1))),
                  width: size.width / 2.2,
                  height: size.height * 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: storys[index].archivos == null
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('No Image'),
                                Text(
                                  storys[index].data!,
                                  style: const TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ))
                        : Image.network(
                            // 'https://prepabochil.fly.dev/api/uploadFile/${storys[index].id}/story',

                            // 'http://192.168.1.78:3000/api/uploadFile/${storys[index].id}/story',ç
                            'https://www.staffcreativa.pe/blog/wp-content/uploads/facebook-cineplanet.jpg',
                            fit: BoxFit.fill,
                          ),

                    //  Image.network(
                    //     'http://192.168.1.71:8080/api/uploadFile/${storys[index].id}/story',
                    //     fit: BoxFit.fill,
                    //   ),
                  ),
                );
              }),
    );
  }
}