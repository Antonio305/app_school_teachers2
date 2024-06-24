import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:sistema_escolar_prepa/widgets/messageSnackBar.dart';
import 'package:http/http.dart' as http;

class SaveFileInLocalProvider extends ChangeNotifier {
  bool isDesktop() {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      return true;
    } else {
      return false;
    }
  }

  String? result;
  bool isBusy = false;
  final OpenFileDialogType _dialogType = OpenFileDialogType.image;
  final SourceType _sourceType = SourceType.photoLibrary;
  final bool _allowEditing = false;
  File? _currentFile;
  String? _savedFilePath;
  final bool _localOnly = false;
  final bool _copyFileToCacheDir = true;
  String? _pickedFilePath;

  DirectoryLocation? _pickedDirecotry;
  final Future<bool> isPickDirectorySupported =
      FlutterFileDialog.isPickDirectorySupported();

// bool isBusy = false;
  Future<bool> tengoAccesoParaGuardarDatos() async {
    // Obtiene el permiso de escritura en el almacenamiento local
    PermissionStatus permissionStatus = await Permission.storage.status;

    // Devuelve true si el permiso está concedido

    if (permissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      openAppSettings();
      debugPrint(" --------------------- Permission denied");
      return false;
    }
  }

  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> pickDirectory() async {
    _pickedDirecotry = (await FlutterFileDialog.pickDirectory());
    notifyListeners();
  }

  Future<void> saveFileToDirectory(File file, BuildContext context) async {
    // file.writeAsStringSync('Este es un archivo de texto');
    await pickDirectory();
    // pickDirectory

    _currentFile = file;
    // _currentFile.writeAsStringSync('Este es un archivo de texto');

    String ext = _currentFile!.path.split('.').last;
    String nameFile = _currentFile!.path.split('/').last;
    if (ext == 'jpg') ext = 'jpeg';

    final fileData = _currentFile!.readAsBytesSync();
    final mimeType = 'image/$ext';
    // final newFileName = 'abc12.$ext';
    final newFileName = nameFile;

    FlutterFileDialog.saveFileToDirectory(
      directory: _pickedDirecotry!,
      data: fileData,
      mimeType: mimeType,
      fileName: newFileName,
      replace: false,
      onFileExists: () async {
        await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text('File already exists'),
              children: <Widget>[
                SimpleDialogOption(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                SimpleDialogOption(
                  child: const Text('Replace'),
                  onPressed: () {
                    Navigator.pop(context);
                    FlutterFileDialog.saveFileToDirectory(
                      directory: _pickedDirecotry!,
                      data: fileData,
                      mimeType: mimeType,
                      fileName: newFileName,
                      replace: true,
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  /**
   * 
   * 
   * 
   * 
   */

  Future<void> pickFile() async {
    String? result;
    try {
      isBusy = true;
      _currentFile = null;
      notifyListeners();

      final params = OpenFileDialogParams(
        dialogType: _dialogType,
        sourceType: _sourceType,
        allowEditing: _allowEditing,
        localOnly: _localOnly,
        copyFileToCacheDir: _copyFileToCacheDir,
      );
      result = await FlutterFileDialog.pickFile(params: params);
      print(result);
    } on PlatformException catch (e) {
      print(e);
    } finally {
      _pickedFilePath = result;
      if (result != null) {
        _currentFile = File(result);
      } else {
        _currentFile = null;
      }
      isBusy = false;
      notifyListeners();
    }
  }

// save file

  Future<void> saveFile(bool useData, File? _currentFile) async {

    String? result;
    try {
      isBusy = true;
      notifyListeners();
      final data = useData ? await _currentFile!.readAsBytes() : null;
      final params = SaveFileDialogParams(
          sourceFilePath: useData ? null : _currentFile!.path,
          data: data,
          localOnly: _localOnly,
          fileName: useData ? "untitled" : null);
      result = await FlutterFileDialog.saveFile(params: params);
      print(result);
    } on PlatformException catch (e) {
      print(e);
    } finally {
      _savedFilePath = result ?? _savedFilePath;
      isBusy = false;
      notifyListeners();
    }
  }

  Future<bool> existFiles(File? currentFile) async {
    await pickDirectory();

    if (_currentFile?.existsSync() == true) {
      return true;
    }
    return false;
  }

  // Exis FIle

  Future<bool> existFile() async {
    await pickDirectory();

    // verificcar is hay diretorio
    if (_pickedDirecotry != null) {
      return true;
    }
    if (_pickedDirecotry != null && _currentFile != null) {
      return true;
    }
    if (_pickedFilePath?.isNotEmpty == true) {
      return true;
    }
    return true;
  }
}
