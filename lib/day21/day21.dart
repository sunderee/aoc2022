import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/let.dart';
import 'package:aoc2022dart/common/helpers/tuples.dart';
import 'package:equatable/equatable.dart';

class Day21 {
  static Future<int> runPart1({bool useTest = false}) async {
    final testInput = 'lib/day21/test.input_21.txt';
    final realInput = 'lib/day21/input_21.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final monkeysMap = input.split('\n').map((item) {
      final monkeyID = RegExp(r'[a-z]{4}(?=\:)').stringMatch(item) ?? '';

      if (RegExp(r'(?<=\: )\d{1,}').hasMatch(item)) {
        final value = RegExp(r'(?<=\: )\d{1,}')
                .stringMatch(item)
                ?.let((it) => int.parse(it)) ??
            0;
        final monkey = Monkey.screaming(monkeyID, value);
        return MapEntry(monkeyID, monkey);
      } else {
        final monkeys = RegExp(r'(?<=\: )[a-z]{4} (\+|\-|\*|\/) [a-z]{4}')
                .stringMatch(item) ??
            '';
        final operation = Operation.fromSign(monkeys.substring(5, 6));
        final monkeysPair = Pair(
          monkeys.substring(0, 4),
          monkeys.substring(monkeys.length - 4, monkeys.length),
        );
        final monkey = Monkey.smart(monkeyID, operation, monkeysPair);
        return MapEntry(monkeyID, monkey);
      }
    }).let((it) => Map.fromEntries(it));

    return _runSimulation(
      monkeysMap['root']?.let((it) => [it]) ?? <Monkey>[],
      monkeysMap,
    );
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final testInput = 'lib/day21/test.input_21.txt';
    final realInput = 'lib/day21/input_21.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final monkeysList = input.split('\n').map((item) {
      final monkeyID = RegExp(r'[a-z]{4}(?=\:)').stringMatch(item) ?? '';

      if (RegExp(r'(?<=\: )\d{1,}').hasMatch(item)) {
        final value = RegExp(r'(?<=\: )\d{1,}')
                .stringMatch(item)
                ?.let((it) => int.parse(it)) ??
            0;
        return Monkey.screaming(monkeyID, value);
      } else {
        final monkeys = RegExp(r'(?<=\: )[a-z]{4} (\+|\-|\*|\/) [a-z]{4}')
                .stringMatch(item) ??
            '';
        final operation = Operation.fromSign(monkeys.substring(5, 6));
        final monkeysPair = Pair(
          monkeys.substring(0, 4),
          monkeys.substring(monkeys.length - 4, monkeys.length),
        );
        return Monkey.smart(monkeyID, operation, monkeysPair);
      }
    }).toList();
    final monkeysMap = monkeysList
        .map((item) => MapEntry(
            item is ScreamingMonkey
                ? item.monkeyID
                : (item as SmartMonkey).monkeyID,
            item))
        .let((it) => Map.fromEntries(it));

    final root = monkeysList.firstWhere((item) =>
        (item is ScreamingMonkey
            ? item.monkeyID
            : (item as SmartMonkey).monkeyID) ==
        'root');
    monkeysList
      ..remove(root)
      ..add(root);

    final leMuh = monkeysList.firstWhere((item) =>
        (item is ScreamingMonkey
            ? item.monkeyID
            : (item as SmartMonkey).monkeyID) ==
        'humn');

    return -1;
  }

  static int _runSimulation(List<Monkey> stack, Map<String, Monkey> monkeyMap) {
    int result = 0;

    while (stack.isNotEmpty) {
      final monkey = stack.removeLast();
      if (monkey is SmartMonkey) {
        int firstValue = -1;
        final first = monkeyMap[monkey.screamingMonkeyIDs.first];
        if (first is SmartMonkey) {
          stack.add(first);
          firstValue = _runSimulation(stack, monkeyMap);
        } else {
          firstValue = (first as ScreamingMonkey).number;
        }

        int secondValue = -1;
        final second = monkeyMap[monkey.screamingMonkeyIDs.second];
        if (second is SmartMonkey) {
          stack.add(second);
          secondValue = _runSimulation(stack, monkeyMap);
        } else {
          secondValue = (second as ScreamingMonkey).number;
        }

        result = monkey.operation.result(firstValue, secondValue);
      }
    }

    return result;
  }

  const Day21._();
}

enum Operation {
  addition,
  subtraction,
  multiplication,
  division;

  static Operation fromSign(String sign) {
    switch (sign) {
      case '+':
        return Operation.addition;
      case '-':
        return Operation.subtraction;
      case '*':
        return Operation.multiplication;
      case '/':
        return Operation.division;
      default:
        throw ArgumentError('Unknown sign: $sign');
    }
  }

  int result(int first, int second) {
    switch (this) {
      case Operation.addition:
        return first + second;
      case Operation.subtraction:
        return first - second;
      case Operation.multiplication:
        return first * second;
      case Operation.division:
        return first ~/ second;
    }
  }
}

abstract class Monkey extends Equatable {
  const Monkey._();

  factory Monkey.screaming(
    String monkeyID,
    int number,
  ) = ScreamingMonkey;

  factory Monkey.smart(
    String monkeyID,
    Operation operation,
    Pair<String, String> screamingMonkeyIDs,
  ) = SmartMonkey;
}

class ScreamingMonkey extends Monkey {
  final String monkeyID;
  final int number;

  @override
  List<Object?> get props => [
        monkeyID,
        number,
      ];

  ScreamingMonkey(
    this.monkeyID,
    this.number,
  ) : super._();
}

class SmartMonkey extends Monkey {
  final String monkeyID;
  final Operation operation;
  final Pair<String, String> screamingMonkeyIDs;

  @override
  List<Object?> get props => [
        monkeyID,
        operation,
        screamingMonkeyIDs,
      ];

  SmartMonkey(
    this.monkeyID,
    this.operation,
    this.screamingMonkeyIDs,
  ) : super._();
}
