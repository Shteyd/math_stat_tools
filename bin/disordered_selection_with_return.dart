import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;

import 'service.dart';

final pathToStat = '${path.current}\\statistics\\';

Future<void> disorderedSelectionWithReturn() async {
  final Map<String, int> _map = await _cleanMap;
  final FileService _fileService = FileService(
    path: path.current,
    jsonFilename: "disordered_selection_with_return",
    json: _map,
  );
  await _fileService.writeFile();
}

String _getSortedKey(String key) {
  final List<String> splittedKey = key.split('');
  final List<int> _local = [];

  for (String l in splittedKey) {
    _local.add(int.parse(l));
  }
  _local.sort();

  return _local.join();
}

Future<Map<String, dynamic>> get _dirtyJson async {
  final file = File('$pathToStat\\ordered_selection_with_return.json');
  if (await file.exists()) {
    final _dirtyData = await file.readAsString();
    return jsonDecode(_dirtyData);
  } else {
    stdout.writeln('You need to run ordered_selection_with_return.dart first');
    exit(0);
  }
}

Future<Map<String, int>> get _cleanJson async {
  final Map<String, int> cleanJson = {};
  final Map<String, dynamic> _map = await _dirtyJson;

  for (int i = 111; i < 445; i++) {
    final String _key = i.toString();
    if (_key.contains(RegExp(r'[0, 5-9]'))) {
      continue;
    }
    cleanJson[_key] = _map[_key].toInt();
  }

  return cleanJson;
}

Future<Map<String, int>> get _cleanMap async {
  final Map<String, int> resultMap = {};
  final Map<String, int> data = await _cleanJson;
  final Iterable<String> keys = data.keys;

  for (int index = 0; index < data.length; index++) {
    final String key = keys.elementAt(index);
    int sum = data[key]!;
    final String _mainKey = _getSortedKey(key);

    for (int counter = 0; counter < data.length; counter++) {
      if (index == counter) continue;
      final String _key = keys.elementAt(counter);

      final String _secondaryKey = _getSortedKey(_key);
      if (_mainKey == _secondaryKey) {
        sum += data[_key]!;
      }
    }

    resultMap[_mainKey] = sum;
  }

  return resultMap;
}
