import 'package:flutter/material.dart';
import 'package:preppa_profesores/Services/nework/download_image.dart';
import 'package:preppa_profesores/local_storage/get_picture_path.dart';
import 'package:provider/provider.dart';

import '../../../Services/nework/get_url_list.dart';
import '../../../providers/response_notifier.dart';

class GetImageButton extends StatelessWidget {
  const GetImageButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_function_declarations_over_variables
    Function updateStatus = (message) {
      context.read<ResponseNotifier>().updateResponseWidget(
            Text(
              message,
              style: const TextStyle(fontSize: 30),
            ),
          );
    };

    return TextButton(
      child: const Text('Get Images'),
      onPressed: () async {
        context.read<ResponseNotifier>().updateResponseWidget(
              const CircularProgressIndicator(),
            );
        // find windows local storage directory
        String picturePath = await GetPictuture.getPicturesPath();
        print('picture path is $picturePath');
        var urlList = await GetUriList.theta();
        // var urlList = GetUrlList.picsum();
        // print(urlList);
        downlodImages(urlList, updateStatus);
      },
    );
  }
}