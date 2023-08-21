import 'dart:io';
import 'package:path/path.dart';

import 'package:preppa_profesores/local_storage/get_picture_path.dart';

void saveImage(imageData, String imageName) async {
  var picturesPath = await GetPictuture.getPicturesPath();
  var thetaImage = await File(join(picturesPath, 'theta_images', imageName))
      .create(recursive: true);
  await thetaImage.writeAsBytes(imageData.bodyBytes);


}
