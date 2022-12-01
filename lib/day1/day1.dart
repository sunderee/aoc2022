import 'dart:math';

import 'package:aoc2022dart/common/read_txt.dart';

class Day1 {
  static Future<int> run() async {
    final input = await readTXT('lib/day1/input_1.txt');

    final lines = input.split('\n');
    final List<int> totalCaloriesByElf = [];
    final List<String> temporaryElfStorage = [];

    for (var i = 0; i < lines.length; i++) {
      if (lines[i].isEmpty) {
        final calories = temporaryElfStorage
            .map((e) => int.parse(e))
            .reduce((value, element) => value + element);
        totalCaloriesByElf.add(calories);
        temporaryElfStorage.clear();
      } else {
        if (i == lines.length - 1) {
          temporaryElfStorage.add(lines[i]);

          final calories = temporaryElfStorage
              .map((e) => int.parse(e))
              .reduce((value, element) => value + element);
          totalCaloriesByElf.add(calories);
          temporaryElfStorage.clear();
        } else {
          temporaryElfStorage.add(lines[i]);
        }
      }
    }

    return totalCaloriesByElf.reduce(max);
  }

  const Day1._();
}
