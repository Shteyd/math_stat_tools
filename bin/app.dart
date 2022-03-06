import 'dart:io';
import 'dart:convert';

import 'disordered_selection_with_returne.dart';
import 'ordered_selection_with_returne.dart';

void main(List<String> arguments) async {
  print('Выберите нужный вам вариант задания:');
  print(
    '1. Упорядоченная выборка с возвращением\n'
    '2. Неупорядоченная выборка с возвращением\n',
  );

  final String line = stdin.readLineSync(encoding: utf8)!;
  switch (line) {
    case "1":
      orderedSelection();
      break;
    case "2":
      disorderedSelection();
      break;
  }
}
