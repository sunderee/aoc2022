import 'package:aoc2022dart/common/helpers/read_txt.dart';

class Day25 {
  static Future<int> runPart1({bool useTest = false}) async {
    final testInput = 'lib/day25/test.input_25.txt';
    final realInput = 'lib/day25/input_25.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    return -1;
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final testInput = 'lib/day24/test.input_24.txt';
    final realInput = 'lib/day24/input_24.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    return -1;
  }

  const Day25._();
}
