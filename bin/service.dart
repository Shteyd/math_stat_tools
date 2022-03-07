// for work with files
import 'dart:convert';
import 'dart:io';

class FileService {
  final String path;
  final String jsonFilename;
  final Map<String, int> json;

  const FileService({
    required this.path,
    required this.jsonFilename,
    required this.json,
  });

  String get _cleanJson {
    const JsonEncoder _encoder = JsonEncoder.withIndent('\t');
    return _encoder.convert(json);
  }

  Future<String> get _dirPath async {
    final Directory dir = Directory('$path\\statistics');

    if (await dir.exists()) {
      return dir.path;
    }

    final Directory _ = await dir.create(recursive: true);
    return _.path;
  }

  Future<void> writeFile() async {
    final _localPath = await _dirPath;
    final _file = File('$_localPath\\$jsonFilename.json');

    if (await _file.exists()) {
      _file.delete(recursive: true);
    } else {
      _file.create(recursive: true);
    }
    _file.writeAsString(_cleanJson);

    return;
  }
}
