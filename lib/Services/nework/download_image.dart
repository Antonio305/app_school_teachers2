import 'package:http/http.dart' as http;
import 'package:preppa_profesores/local_storage/save_image.dart';
// es una funcion de tipo void por que no retornamos nada
// parametro Lista de la url
// estdo de  la status de la descarga

void downlodImages(List<String> urlList, Function updateStatus) async {
  var counter = 1;
  for (String url in urlList) {
    Uri uri = Uri.parse(url);
    final imageData = await http.get(uri);
    print('Saving image $counter');

    saveImage(imageData, '$counter.jpg');

    // update status
    updateStatus('saved image $counter.jpg');
    counter++;
  }
}
