import 'dart:math';

import 'package:path/path.dart' as path;

import 'service.dart';

Future<void> orderedSelectionWithoutReturn() async {
  final FileService _fileService = FileService(
    path: path.current,
    jsonFilename: "ordered_selection_without_return",
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

    final List<String> _list = _key.split('');
    if (_list.length != Set.from(_list).length) {
      continue;
    }

    _map[_key] = 0;
  }

  return _map;
}

Map<String, int> get _dataForJson {
  final Map<String, int> _map = _mapKeys;
  final Random random = Random();

  for (int counter = 0; counter < 2400; counter++) {
    final List<int> _store = [1, 2, 3, 4];
    final List<int> _cells = [];

    for (int i = 4; i > 1; i--) {
      final int _index = random.nextInt(i);

      _cells.add(_store[_index]);
      _store.removeAt(_index);
    }

    _map[_cells.join()] = _map[_cells.join()]! + 1;
  }

  return _map;
}
