import 'package:aoc2022dart/common/helpers/read_txt.dart';

class Day11 {
  static Future<int> runPart1({bool useTest = false}) async {
    final testInput = 'lib/day11/test.input_11.txt';
    final realInput = 'lib/day11/input_11.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    return -1;
  }

  static Future<void> runPart2({bool useTest = false}) async {
    final testInput = 'lib/day11/test.input_11.txt';
    final realInput = 'lib/day11/input_11.txt';
    final input = await readTXT(useTest ? testInput : realInput);
  }

  const Day11._();
}
