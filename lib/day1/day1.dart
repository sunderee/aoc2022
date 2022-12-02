import 'dart:math';

import 'package:aoc2022dart/common/read_txt.dart';

class Day1 {
  static Future<int> runPart1() async {
    final input = await readTXT('lib/day1/test.input_1.txt');

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

  static Future<int> runPart2() async {
    final input = await readTXT('lib/day1/test.input_1.txt');

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

    totalCaloriesByElf.sort((first, second) => second.compareTo(first));
    return totalCaloriesByElf
        .sublist(0, 3)
        .reduce((value, element) => value + element);
  }

  const Day1._();
}
