import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/let.dart';

class Day10 {
  static Future<int> runPart1({bool useTest = false}) async {
    final testInput = 'lib/day10/test.input_10.txt';
    final realInput = 'lib/day10/input_10.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final List<int> strengthsPerCycle = [];
    int strength = 1;

    input.split('\n').forEach((item) {
      if (item == 'noop') {
        strengthsPerCycle.add(strength);
      } else if (item.startsWith('addx')) {
        strengthsPerCycle.add(strength);
        strengthsPerCycle.add(strength);
        strength += item.split(' ').last.let((it) => int.parse(it));
      }
    });

    final List<int> selection = [];
    for (var i = 19; i <= strengthsPerCycle.length; i += 40) {
      selection.add(strengthsPerCycle[i] * (i + 1));
    }

    return selection.reduce((value, element) => value + element);
  }

  static Future<String> runPart2({bool useTest = false}) async {
    final testInput = 'lib/day10/test.input_10.txt';
    final realInput = 'lib/day10/input_10.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final List<int> strengthsPerCycle = [];
    int strength = 1;

    input.split('\n').forEach((item) {
      if (item == 'noop') {
        strengthsPerCycle.add(strength);
      } else if (item.startsWith('addx')) {
        strengthsPerCycle.add(strength);
        strengthsPerCycle.add(strength);
        strength += item.split(' ').last.let((it) => int.parse(it));
      }
    });

    final buffer = StringBuffer();
    for (var i = 0; i < strengthsPerCycle.length; i += 40) {
      for (var j = 0; j < 40; j++) {
        buffer.write((strengthsPerCycle[i + j] - j).abs() <= 1 ? '#' : '.');
      }
      buffer.writeln();
    }
    return buffer.toString();
  }

  const Day10._();
}
