import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:preppa_profesores/providers/isMobile.dart';
import 'package:preppa_profesores/widgets/utils/border.dart';
import 'package:provider/provider.dart';

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

    final width = IsMobile.isMobile() ? size.width * 0.96 : size.width * 0.44;
    final height = IsMobile.isMobile() ? size.height * 0.25 : size.height * 0.5;

    return Container(
      // decoration: MyBorder.decorationWidgetStory(Colors.transparent),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
            colors: [Color(0xff6157FF), Color(0xffEE49ff)],
                        // colors: [Color.fromARGB(255, 70, 59, 226), Color.fromARGB(255, 219, 58, 237)],

            ),
      ),
      width: width,
      height: height,
      child: storys.isEmpty ? IsEmptyStoy() : listStorys(size),
    );
  }

  CardSwiper<Widget> listStorys(Size size) {
    return CardSwiper(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        // threshold: 20,
        // maxAngle: 10,
        numberOfCardsDisplayed: 1,
        // isHorizontalSwipingEnabled: true,
        direction: CardSwiperDirection.left,
        cardsCount: storys.length,
        cardBuilder: (context, index) {
          return Container(
            decoration: MyBorder.decorationWidgetStory(
              Colors.blue.withOpacity(0.2),
            ),
            width: size.width / 2.2,
            height: size.height * 0.5,
            child: ClipRRect(
              borderRadius: MyBorder.myBorderRadius(),
              child: storys[index].archivos == null
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const Text('No Image'),
                          Text(
                            storys[index].data!,
                            style: const TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ))
                  : Image.network(
                      'https://www.staffcreativa.pe/blog/wp-content/uploads/facebook-cineplanet.jpg',
                      fit: BoxFit.fill,
                    ),

              //  Image.network(
              //     'http://192.168.1.71:8080/api/uploadFile/${storys[index].id}/story',
              //     fit: BoxFit.fill,
              //   ),
            ),
          );
        });
  }

  Column IsEmptyStoy() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.amp_stories_sharp),
        SizedBox(
          height: 10,
        ),
        Text('No hay historias'),
      ],
    );
  }
}
