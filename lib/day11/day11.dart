import 'package:aoc2022dart/common/helpers/scope_functions/let.dart';

class Day11 {
  static int runPart1({bool useTest = false}) {
    final monkeys = Map<int, _Monkey>.from(
      useTest
          ? {
              0: _Monkey(
                items: [79, 98],
                operation: (old) => old * 19,
                test: (item) => item % 23 == 0 ? 2 : 3,
              ),
              1: _Monkey(
                items: [54, 65, 75, 74],
                operation: (old) => old + 6,
                test: (item) => item % 19 == 0 ? 2 : 0,
              ),
              2: _Monkey(
                items: [79, 60, 97],
                operation: (old) => old * old,
                test: (item) => item % 13 == 0 ? 1 : 3,
              ),
              3: _Monkey(
                items: [74],
                operation: (old) => old + 3,
                test: (item) => item % 17 == 0 ? 0 : 1,
              ),
            }
          : {
              0: _Monkey(
                items: [75, 63],
                operation: (old) => old * 3,
                test: (item) => item % 11 == 0 ? 7 : 2,
              ),
              1: _Monkey(
                items: [65, 79, 98, 77, 56, 54, 83, 94],
                operation: (old) => old + 3,
                test: (item) => item % 2 == 0 ? 2 : 0,
              ),
              2: _Monkey(
                items: [66],
                operation: (old) => old + 5,
                test: (item) => item % 5 == 0 ? 7 : 5,
              ),
              3: _Monkey(
                items: [51, 89, 90],
                operation: (old) => old * 19,
                test: (item) => item % 7 == 0 ? 6 : 4,
              ),
              4: _Monkey(
                items: [75, 94, 66, 90, 77, 82, 61],
                operation: (old) => old + 1,
                test: (item) => item % 17 == 0 ? 6 : 1,
              ),
              5: _Monkey(
                items: [53, 76, 59, 92, 95],
                operation: (old) => old + 2,
                test: (item) => item % 19 == 0 ? 4 : 3,
              ),
              6: _Monkey(
                items: [81, 61, 75, 89, 70, 92],
                operation: (old) => old * old,
                test: (item) => item % 3 == 0 ? 0 : 1,
              ),
              7: _Monkey(
                items: [81, 86, 62, 87],
                operation: (old) => old + 8,
                test: (item) => item % 13 == 0 ? 3 : 5,
              ),
            },
    );
    final monkeyInspectionCount = Map<int, int>.fromEntries(
      monkeys.entries.map(
        (entry) => MapEntry(
          entry.key,
          0,
        ),
      ),
    );

    for (var i = 0; i < 20; i++) {
      for (var monkeyEntry in monkeys.entries) {
        final monkeyID = monkeyEntry.key;
        final monkey = monkeyEntry.value;
        if (monkey.items.isNotEmpty) {
          while (monkey.items.isNotEmpty) {
            monkeyInspectionCount[monkeyID]
                ?.let((it) => monkeyInspectionCount[monkeyID] = it + 1);
            final item = monkey.items
                .removeAt(0)
                .let((it) => (monkey.operation(it) / 3).floor());
            monkeys[monkey.test(item)]?.items.add(item);
          }
        }
      }
    }

    final counts = monkeyInspectionCount.values.toList()..sort();
    return counts
        .let((it) => List<int>.from(it.reversed))
        .take(2)
        .reduce((value, element) => value * element);
  }

  static int runPart2({bool useTest = false}) {
    final monkeys = Map<int, _Monkey>.from(
      useTest
          ? {
              0: _Monkey(
                items: [79, 98],
                operation: (old) => old * 19,
                test: (item) => item % 23 == 0 ? 2 : 3,
              ),
              1: _Monkey(
                items: [54, 65, 75, 74],
                operation: (old) => old + 6,
                test: (item) => item % 19 == 0 ? 2 : 0,
              ),
              2: _Monkey(
                items: [79, 60, 97],
                operation: (old) => old * old,
                test: (item) => item % 13 == 0 ? 1 : 3,
              ),
              3: _Monkey(
                items: [74],
                operation: (old) => old + 3,
                test: (item) => item % 17 == 0 ? 0 : 1,
              ),
            }
          : {
              0: _Monkey(
                items: [75, 63],
                operation: (old) => old * 3,
                test: (item) => item % 11 == 0 ? 7 : 2,
              ),
              1: _Monkey(
                items: [65, 79, 98, 77, 56, 54, 83, 94],
                operation: (old) => old + 3,
                test: (item) => item % 2 == 0 ? 2 : 0,
              ),
              2: _Monkey(
                items: [66],
                operation: (old) => old + 5,
                test: (item) => item % 5 == 0 ? 7 : 5,
              ),
              3: _Monkey(
                items: [51, 89, 90],
                operation: (old) => old * 19,
                test: (item) => item % 7 == 0 ? 6 : 4,
              ),
              4: _Monkey(
                items: [75, 94, 66, 90, 77, 82, 61],
                operation: (old) => old + 1,
                test: (item) => item % 17 == 0 ? 6 : 1,
              ),
              5: _Monkey(
                items: [53, 76, 59, 92, 95],
                operation: (old) => old + 2,
                test: (item) => item % 19 == 0 ? 4 : 3,
              ),
              6: _Monkey(
                items: [81, 61, 75, 89, 70, 92],
                operation: (old) => old * old,
                test: (item) => item % 3 == 0 ? 0 : 1,
              ),
              7: _Monkey(
                items: [81, 86, 62, 87],
                operation: (old) => old + 8,
                test: (item) => item % 13 == 0 ? 3 : 5,
              ),
            },
    );

    final monkeyInspectionCount = Map<int, int>.fromEntries(
      monkeys.entries.map(
        (entry) => MapEntry(
          entry.key,
          0,
        ),
      ),
    );

    final base = useTest
        ? [13, 17, 19, 23].let((it) => lcd(it))
        : [2, 3, 5, 7, 11, 13, 17, 19].let((it) => lcd(it));
    for (var i = 0; i < 10000; i++) {
      for (var monkeyEntry in monkeys.entries) {
        final monkeyID = monkeyEntry.key;
        final monkey = monkeyEntry.value;
        if (monkey.items.isNotEmpty) {
          while (monkey.items.isNotEmpty) {
            monkeyInspectionCount[monkeyID]
                ?.let((it) => monkeyInspectionCount[monkeyID] = it + 1);
            final item = monkey.items
                .removeAt(0)
                .let((it) => monkey.operation(it) % base);
            monkeys[monkey.test(item)]?.items.add(item);
          }
        }
      }
    }

    final counts = monkeyInspectionCount.values.toList()..sort();
    return counts
        .let((it) => List<int>.from(it.reversed))
        .take(2)
        .reduce((value, element) => value * element);
  }

  static int lcd(List<int> input) {
    if (input.isEmpty) {
      return 0;
    }

    var result = input[0];
    for (var i = 1; i < input.length; i++) {
      result = (result * input[i]) ~/ _gcd(result, input[i]);
    }
    return result;
  }

  static int _gcd(int a, int b) {
    while (b != 0) {
      var temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  const Day11._();
}

class _Monkey {
  final List<int> items;
  final int Function(int old) operation;
  final int Function(int item) test;

  _Monkey({
    required this.items,
    required this.operation,
    required this.test,
  });
}
