import 'dart:math';

import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/let.dart';

class Day8 {
  static Future<int> runPart1({bool useTest = false}) async {
    final file = useTest ? 'lib/day8/test.input_8.txt' : 'lib/day8/input_8.txt';
    final input = await readTXT(file);

    final grid = input
        .split('\n')
        .map((item) => item.split('').map((inner) => int.parse(inner)).toList())
        .toList();

    int countOfVisibleTrees = ((2 * grid.first.length) + (2 * grid.length)) - 4;

    for (var y = 1; y < grid.length - 1; y++) {
      for (var x = 1; x < grid[y].length - 1; x++) {
        final item = grid[y][x];
        final immediateNeighbors = [
          grid[y][x - 1],
          grid[y][x + 1],
          grid[y - 1][x],
          grid[y + 1][x]
        ];
        if (immediateNeighbors.every((element) => element >= item)) {
          continue;
        }

        final top = [for (var i = 0; i <= y - 1; i++) grid[i][x]]
            .every((element) => element < item);
        final bottom = [
          for (var i = y + 1; i <= grid.length - 1; i++) grid[i][x]
        ].every((element) => element < item);
        final left = [for (var i = 0; i <= x - 1; i++) grid[y][i]]
            .every((element) => element < item);
        final right = [
          for (var i = x + 1; i <= grid.first.length - 1; i++) grid[y][i]
        ].every((element) => element < item);
        if (top || bottom || left || right) {
          countOfVisibleTrees++;
        }
      }
    }

    return countOfVisibleTrees;
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final file = useTest ? 'lib/day8/test.input_8.txt' : 'lib/day8/input_8.txt';
    final input = await readTXT(file);

    final grid = input
        .split('\n')
        .map((item) => item.split('').map((inner) => int.parse(inner)).toList())
        .toList();

    final List<int> scenicScores = [];
    for (var y = 1; y < grid.length - 1; y++) {
      for (var x = 1; x < grid[y].length - 1; x++) {
        final currentItem = grid[y][x];
        final score = [
          [for (var i = 0; i <= y - 1; i++) grid[i][x]]
              .let((it) => List<int>.from(it.reversed)),
          [for (var i = y + 1; i <= grid.length - 1; i++) grid[i][x]],
          [for (var i = 0; i <= x - 1; i++) grid[y][i]]
              .let((it) => List<int>.from(it.reversed)),
          [for (var i = x + 1; i <= grid.first.length - 1; i++) grid[y][i]]
        ]
            .map((item) => _countVisibleTrees(item, currentItem))
            .reduce((value, element) => value * element);

        scenicScores.add(score);
      }
    }

    return scenicScores.reduce(max);
  }

  static int _countVisibleTrees(List<int> lineOfSight, int currentItem) =>
      List<int>.from(lineOfSight).reduce(max) < currentItem
          ? lineOfSight.length
          : lineOfSight.indexWhere((element) => element >= currentItem) + 1;

  const Day8._();
}
