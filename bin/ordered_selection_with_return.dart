import 'dart:math';

import 'package:path/path.dart' as path;

import 'service.dart';

const List<int> store = [1, 2, 3, 4];

Future<void> orderedSelectionWithReturn() async {
  final FileService _fileService = FileService(
    path: path.current,
    jsonFilename: "ordered_selection_with_return",
    json: _dataForJson,
  );
  await _fileService.writeFile();
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
