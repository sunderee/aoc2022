import 'package:aoc2022dart/common/data_structures/stack/stack.dart';
import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/let.dart';
import 'package:aoc2022dart/common/helpers/tuples.dart';

class Day5 {
  static const int _maxTestStackSize = 6;
  static const int _maxStackSize = 56;

  static Future<String> runPart1({bool useTest = false}) async {
    final file = useTest ? 'lib/day5/test.input_5.txt' : 'lib/day5/input_5.txt';
    final input = await readTXT(file);

    final Map<int, Stack<String>> stackMap = useTest
        ? {
            1: Stack<String>(_maxTestStackSize)
              ..push('Z')
              ..push('N'),
            2: Stack<String>(_maxTestStackSize)
              ..push('M')
              ..push('C')
              ..push('D'),
            3: Stack<String>(_maxTestStackSize)..push('P')
          }
        : {
            1: Stack<String>(_maxStackSize)
              ..push('Q')
              ..push('W')
              ..push('P')
              ..push('S')
              ..push('Z')
              ..push('R')
              ..push('H')
              ..push('D'),
            2: Stack<String>(_maxStackSize)
              ..push('V')
              ..push('B')
              ..push('R')
              ..push('W')
              ..push('Q')
              ..push('H')
              ..push('F'),
            3: Stack<String>(_maxStackSize)
              ..push('C')
              ..push('V')
              ..push('S')
              ..push('H'),
            4: Stack<String>(_maxStackSize)
              ..push('H')
              ..push('F')
              ..push('G'),
            5: Stack<String>(_maxStackSize)
              ..push('P')
              ..push('G')
              ..push('J')
              ..push('B')
              ..push('Z'),
            6: Stack<String>(_maxStackSize)
              ..push('Q')
              ..push('T')
              ..push('J')
              ..push('H')
              ..push('W')
              ..push('F')
              ..push('L'),
            7: Stack<String>(_maxStackSize)
              ..push('Z')
              ..push('T')
              ..push('W')
              ..push('D')
              ..push('L')
              ..push('V')
              ..push('J')
              ..push('N'),
            8: Stack<String>(_maxStackSize)
              ..push('D')
              ..push('T')
              ..push('Z')
              ..push('C')
              ..push('J')
              ..push('G')
              ..push('H')
              ..push('F'),
            9: Stack<String>(_maxStackSize)
              ..push('W')
              ..push('P')
              ..push('V')
              ..push('M')
              ..push('B')
              ..push('N'),
          };

    input
        .split('\n')
        .sublist(useTest ? 5 : 10)
        .map((item) => RegExp(r'\d{1,2}').allMatches(item))
        .map((item) => Triple(
              item.elementAt(0).group(0),
              item.elementAt(1).group(0),
              item.elementAt(2).group(0),
            ))
        .map((item) => Triple(
            item.first?.let((it) => int.parse(it)),
            item.second?.let((it) => int.parse(it)),
            item.third?.let((it) => int.parse(it))))
        .forEach((item) => _performCrateMover9000Operation(
              stackMap,
              item,
              useTest,
            ));

    return stackMap.values.map((item) => item.peek()).join('');
  }

  static Future<String> runPart2({bool useTest = false}) async {
    final file = useTest ? 'lib/day5/test.input_5.txt' : 'lib/day5/input_5.txt';
    final input = await readTXT(file);

    final Map<int, Stack<String>> stackMap = useTest
        ? {
            1: Stack<String>(_maxTestStackSize)
              ..push('Z')
              ..push('N'),
            2: Stack<String>(_maxTestStackSize)
              ..push('M')
              ..push('C')
              ..push('D'),
            3: Stack<String>(_maxTestStackSize)..push('P')
          }
        : {
            1: Stack<String>(_maxStackSize)
              ..push('Q')
              ..push('W')
              ..push('P')
              ..push('S')
              ..push('Z')
              ..push('R')
              ..push('H')
              ..push('D'),
            2: Stack<String>(_maxStackSize)
              ..push('V')
              ..push('B')
              ..push('R')
              ..push('W')
              ..push('Q')
              ..push('H')
              ..push('F'),
            3: Stack<String>(_maxStackSize)
              ..push('C')
              ..push('V')
              ..push('S')
              ..push('H'),
            4: Stack<String>(_maxStackSize)
              ..push('H')
              ..push('F')
              ..push('G'),
            5: Stack<String>(_maxStackSize)
              ..push('P')
              ..push('G')
              ..push('J')
              ..push('B')
              ..push('Z'),
            6: Stack<String>(_maxStackSize)
              ..push('Q')
              ..push('T')
              ..push('J')
              ..push('H')
              ..push('W')
              ..push('F')
              ..push('L'),
            7: Stack<String>(_maxStackSize)
              ..push('Z')
              ..push('T')
              ..push('W')
              ..push('D')
              ..push('L')
              ..push('V')
              ..push('J')
              ..push('N'),
            8: Stack<String>(_maxStackSize)
              ..push('D')
              ..push('T')
              ..push('Z')
              ..push('C')
              ..push('J')
              ..push('G')
              ..push('H')
              ..push('F'),
            9: Stack<String>(_maxStackSize)
              ..push('W')
              ..push('P')
              ..push('V')
              ..push('M')
              ..push('B')
              ..push('N'),
          };

    final stackListMap = stackMap.entries
        .map((item) => MapEntry(item.key, item.value.toList()))
        .let((it) => Map.fromEntries(it));

    input
        .split('\n')
        .sublist(useTest ? 5 : 10)
        .map((item) => RegExp(r'\d{1,2}').allMatches(item))
        .map((item) => Triple(
              item.elementAt(0).group(0),
              item.elementAt(1).group(0),
              item.elementAt(2).group(0),
            ))
        .map((item) => Triple(
            item.first?.let((it) => int.parse(it)),
            item.second?.let((it) => int.parse(it)),
            item.third?.let((it) => int.parse(it))))
        .forEach((item) => _performCrateMover9001Operation(
              stackListMap,
              item,
              useTest,
            ));

    return stackListMap.values
        .where((item) => item.isNotEmpty)
        .map((item) => item.last)
        .join('');
  }

  static void _performCrateMover9000Operation(
    Map<int, Stack<String>> stackMap,
    Triple<int?, int?, int?> instruction,
    bool useTest,
  ) {
    final start = stackMap[instruction.second];
    final destination = stackMap[instruction.third];

    for (var i = 0; i < (instruction.first ?? 0); i++) {
      final element = start?.pop();
      if (element != null) {
        destination?.push(element);
      }
    }
  }

  static void _performCrateMover9001Operation(
    Map<int, List<String>> stackListMap,
    Triple<int?, int?, int?> instruction,
    bool useTest,
  ) {
    final start = stackListMap[instruction.second];
    final destination = stackListMap[instruction.third];

    final take = instruction.first;
    if (take != null && start != null && destination != null) {
      final grabbedCrates = start.sublist(start.length - take);

      start.removeRange(start.length - take, start.length);
      destination.addAll(grabbedCrates);
    }
  }

  const Day5._();
}
