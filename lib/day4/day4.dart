import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/let.dart';
import 'package:aoc2022dart/common/helpers/tuples.dart';

class Day4 {
  static Future<int> runPart1({bool useTest = false}) async {
    final file = useTest ? 'lib/day4/test.input_4.txt' : 'lib/day4/input_4.txt';
    final input = await readTXT(file);

    return input
        .split('\n')
        .map((item) => item.split(',').let((it) => Pair(it.first, it.last)))
        .where((item) => _checkForFullOverlap(item))
        .length;
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final file = useTest ? 'lib/day4/test.input_4.txt' : 'lib/day4/input_4.txt';
    final input = await readTXT(file);

    return input
        .split('\n')
        .map((item) => item.split(',').let((it) => Pair(it.first, it.last)))
        .where((item) => _checkForPartialOverlap(item))
        .length;
  }

  static bool _checkForFullOverlap(Pair<String, String> input) {
    final first = _expandRange(input.first);
    final second = _expandRange(input.second);

    return first.every((item) => second.contains(item)) ||
        second.every((item) => first.contains(item));
  }

  static bool _checkForPartialOverlap(Pair<String, String> input) {
    final first = _expandRange(input.first);
    final second = _expandRange(input.second);

    return first.any((item) => second.contains(item)) ||
        second.any((item) => first.contains(item));
  }

  static List<int> _expandRange(String input) {
    final range = input
        .split('-')
        .let((it) => Pair(it.first, it.last))
        .let((it) => Pair(int.parse(it.first), int.parse(it.second)));

    if (range.first > range.second) {
      throw ArgumentError(
        'Start of range cannot be greater than the end',
      );
    }

    return [for (var i = range.first; i <= range.second; i++) i];
  }

  const Day4._();
}
