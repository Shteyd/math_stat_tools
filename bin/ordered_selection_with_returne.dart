import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as path;

const List<int> store = [1, 2, 3, 4];

Future<void> orderedSelection() async {
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final Map<String, int> map = _dataForJson;

  await writeFile(encoder.convert(map));
}

Future<String> get dirPath async {
  final Directory dir = Directory('${path.current}\\statistics');

  if (await dir.exists()) {
    return dir.path;
  }

  final Directory _ = await dir.create(recursive: true);
  return _.path;
}

writeFile(String json) async {
  final localPath = await dirPath;
  final file = File('$localPath\\ordered_selection_with_returne.json');

  if (await file.exists()) {
    file.delete(recursive: true);
  } else {
    file.create(recursive: true);
  }
  file.writeAsString(json);
}

Map<String, int> get _mapKeys {
  final Map<String, int> _map = {};
  for (int i = 111; i < 445; i++) {
    final String _key = i.toString();
    if (_key.contains(RegExp(r'[0, 5-9]'))) {
      continue;
    }
    _map[_key] = 0;
  }
  return _map;
}

Map<String, int> get _dataForJson {
  final Map<String, int> _map = _mapKeys;
  final Random random = Random();

  for (int counter = 0; counter < 6400; counter++) {
    // max length is 3
    final List<int> cells = [];

    for (int cell = 0; cell < 3; cell++) {
      cells.add(store[random.nextInt(4)]);
    }

    _map[cells.join()] = _map[cells.join()]! + 1;
  }

  return _map;
}
