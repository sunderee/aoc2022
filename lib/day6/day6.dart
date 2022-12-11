import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/let.dart';

class Day6 {
  static Future<int> runPart1({bool useTest = false}) async {
    final file = useTest ? 'lib/day6/test.input_6.txt' : 'lib/day6/input_6.txt';
    final input = await readTXT(file);

    return [
      for (var i = 0; i <= input.length - 4; i++) input.substring(i, i + 4)
    ]
        .firstWhere((item) => item.split('').toSet().length == 4)
        .let((it) => input.indexOf(it) + 4);
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final file = useTest ? 'lib/day6/test.input_6.txt' : 'lib/day6/input_6.txt';
    final input = await readTXT(file);

    final packetBody = [
      for (var i = 0; i <= input.length - 4; i++) input.substring(i, i + 4)
    ]
        .firstWhere((item) => item.split('').toSet().length == 4)
        .let((it) => input.indexOf(it) + 4)
        .let((it) => input.substring(it));

    return [
      for (var i = 0; i <= packetBody.length - 14; i++)
        input.substring(i, i + 14)
    ]
        .firstWhere((item) => item.split('').toSet().length == 14)
        .let((it) => input.indexOf(it) + 14);
  }

  const Day6._();
}
