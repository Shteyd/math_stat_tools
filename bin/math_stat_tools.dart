import 'dart:io';

import 'disordered_selection_with_return.dart';
import 'disordered_selection_without_return.dart';
import 'ordered_selection_with_return.dart';
import 'ordered_selection_without_return.dart';

void main(List<String> arguments) async {
  stdout.writeln('Выберите нужный вам вариант задания:');
  stdout.writeln(
    '1. Упорядоченная выборка с возвращением\n'
    '2. Неупорядоченная выборка с возвращением (сначала надо запустить 1)\n'
    '3. Упорядоченная выборка без возвращения\n'
    '4. Неупорядоченная выборка без возвращения (сначала надо запустить 3)\n'
    '5. Запуск всех программ подряд (по списку)\n'
    '${"-" * 50}\n'
    '0. Ничего не делать',
  );
  stdout.write(">>> ");

  final String line = stdin.readLineSync()!;
  switch (line) {
    case "1":
      orderedSelectionWithReturn();
      break;
    case "2":
      disorderedSelectionWithReturn();
      break;
    case "3":
      orderedSelectionWithoutReturn();
      break;
    case "4":
      disorderedSelectionWithoutReturn();
      break;
    case "5":
      await orderedSelectionWithReturn();
      await disorderedSelectionWithReturn();
      await orderedSelectionWithoutReturn();
      await disorderedSelectionWithoutReturn();
      break;
  }
}
