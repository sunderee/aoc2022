import 'dart:math';

import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/let.dart';

class Day25 {
  static Future<String> runPart1({bool useTest = false}) async {
    final testInput = 'lib/day25/test.input_25.txt';
    final realInput = 'lib/day25/input_25.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    return input
        .split('\n')
        .map((item) => item.snafuToInt())
        .reduce((value, element) => value + element)
        .intToSnafu();
  }

  const Day25._();
}

const Map<String, int> multipliers = {
  "0": 0,
  "1": 1,
  "2": 2,
  "-": -1,
  "=": -2,
};

extension _StringExt on String {
  int snafuToInt() {
    int result = 0;
    for (int i = 0; i < length; i++) {
      String character = this[length - 1 - i];
      result +=
          multipliers[character]?.let((it) => pow(5, i) * it).toInt() ?? 0;
    }
    return result;
  }
}

extension _IntExt on int {
  String intToSnafu() {
    final List<String> snafu = [];
    int result = this;
    int carry = 0;

    while (result != 0) {
      final vMod5 = result % 5;
      result = (result / 5).floor();
      if (vMod5 < 3) {
        snafu.add(vMod5.toString());
        carry = 0;
      } else if (vMod5 == 3) {
        snafu.add("=");
        carry = 1;
      } else {
        snafu.add("-");
        carry = 1;
      }
      result += carry;
    }
    return snafu.reversed.join('');
  }
}
