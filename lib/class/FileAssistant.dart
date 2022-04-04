import 'dart:ui';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// method that return the local path of the flutter application
Future<String> getLocalPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

/// method that return the file of a local file [fileName] in base of the local path of the application
Future<File> getLocalFile(String fileName) async {
  final path = await getLocalPath();
  return File(join(path, fileName));
}

Future<bool> existData(String fileName, {bool local = true}) async {
  if (kIsWeb) {
    return await hasItem(fileName);
  }
  else{
    // check if the file exist
    final file = await getLocalFile(fileName);
    return await file.exists();
  }
}

/// method that save data in a file idetified by [fileName] who is joined with the local path of the application if the flag local is true
Future<void> saveData(String fileName, String data, {bool local = true}) async {
  try {
    if (kIsWeb) {
      // set local storage item [filename] with [data]
      await setItem(fileName, data);
    } else {
      final file = await getLocalFile(fileName);
      await file.writeAsString(data);
    }
  } catch (e) {
    throw Exception('basic_file_io: impossible to save the data');
  }
}

/// method that load data in a file idetified by [fileName] who is joined with the local path of the application if the flag local is true
Future<String> loadData(String fileName, {bool local = true}) async {
  try {
    if (kIsWeb) {
      // get local storage item [filename]
      return (await getItem(fileName))!;
    } else {
      final file = await getLocalFile(fileName);
      return file.readAsString();
    }
  } catch (e) {
    throw Exception('basic_file_io: impossible to load the data');
  }
}

class FileAssistant with ChangeNotifier {
  String fileName;
  bool isLocal = true;
  String _data = "";
  String get data => _data;

  bool autoSave;
  bool _inLoading = false;
  bool get inLoading => _inLoading;

  FileAssistant(this.fileName, {this.autoSave = true}) {
    _inLoading = true;
  }

  Future<void> save() async {
    return await saveData(fileName, data, local: isLocal);
  }

  Future<void> setData(String value) async {
    _data = value;
    if (autoSave) await save();
  }

  Future<bool> exist() async{
    return await existData(fileName, local: isLocal);
  }

  Future<String> load() async {
    _data = await loadData(fileName, local: isLocal);
    return data;
  }
}

//method that check if a browser local storage item exists
Future<bool> hasItem(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey(key);
}

//method to acces to the browser local storage item, given the key
Future<String?> getItem(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

//method to set the browser local storage item, given the key and the value
Future<bool> setItem(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString(key, value);
}
