import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;

final pathToStat = '${path.current}\\statistics\\';

void disorderedSelection() async {
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final Map<String, int> map = await cleanMap;
  writeFile(encoder.convert(map));
}

writeFile(String json) async {
  final file = File('$pathToStat\\disordered_selection_with_returne.json');

  if (await file.exists()) {
    file.delete(recursive: true);
  } else {
    file.create(recursive: true);
  }

  file.writeAsString(json);
}

String getSortedKey(String key) {
  final List<String> splittedKey = key.split('');
  final List<int> _local = [];

  for (String l in splittedKey) {
    _local.add(int.parse(l));
  }
  _local.sort();

  return _local.join();
}

Future<Map<String, dynamic>> get dirtyJson async {
  final file =
      File('${path.current}\\statistics\\ordered_selection_with_returne.json');
  if (await file.exists()) {
    final dirtyData = await file.readAsString();
    return jsonDecode(dirtyData);
  } else {
    print('You need to run ordered_selection_with_returne.dart first');
    exit(0);
  }
}

Future<Map<String, int>> get cleanJson async {
  // get statistic from ordered_selection_with_returne
  Map<String, int> cleanJson = {};
  Map<String, dynamic> _map = await dirtyJson;

  for (int i = 111; i < 445; i++) {
    final String _key = i.toString();
    if (_key.contains(RegExp(r'[0, 5-9]'))) {
      continue;
    }
    cleanJson[_key] = _map[_key].toInt();
  }

  return cleanJson;
}

Future<Map<String, int>> get cleanMap async {
  final Map<String, int> resultMap = {};
  final Map<String, int> data = await cleanJson;
  final Iterable<String> keys = data.keys;

  for (int index = 0; index < data.length; index++) {
    final String key = keys.elementAt(index);
    int sum = data[key]!;
    final String _mainKey = getSortedKey(key);

    for (int counter = 0; counter < data.length; counter++) {
      if (index == counter) continue;
      final String _key = keys.elementAt(counter);

      final String _secondaryKey = getSortedKey(_key);
      if (_mainKey == _secondaryKey) {
        sum += data[_key]!;
      }
    }

    resultMap[_mainKey] = sum;
  }

  return resultMap;
}
