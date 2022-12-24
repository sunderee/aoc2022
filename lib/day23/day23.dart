import 'dart:math';

import 'package:aoc2022dart/common/helpers/read_txt.dart';

class Day23 {
  static final _directions = [
    [
      Point<int>(-1, -1),
      Point<int>(0, -1),
      Point<int>(1, -1),
    ],
    [
      Point<int>(1, 1),
      Point<int>(0, 1),
      Point<int>(-1, 1),
    ],
    [
      Point<int>(-1, 1),
      Point<int>(-1, 0),
      Point<int>(-1, -1),
    ],
    [
      Point<int>(1, -1),
      Point<int>(1, 0),
      Point<int>(1, 1),
    ],
  ];

  static final _elfOrientation = [
    Point<int>(-1, -1),
    Point<int>(0, -1),
    Point<int>(1, -1),
    Point<int>(1, 1),
    Point<int>(0, 1),
    Point<int>(-1, 1),
    Point<int>(-1, 0),
    Point<int>(1, 0)
  ];

  static Future<int> runPart1({bool useTest = false}) async {
    final testInput = 'lib/day23/test.input_23.txt';
    final realInput = 'lib/day23/input_23.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final lines = input.split('\n');
    final elves = <Point<int>>{};
    for (var y = 0; y < lines.length; y++) {
      final line = lines[y];
      for (var x = 0; x < line.length; x++) {
        if (line[x] == '#') {
          elves.add(Point<int>(x, y));
        }
      }
    }

    final firstDirection = cycle(List.generate(4, (i) => i)).iterator;
    for (var i = 0; i < 10; i++) {
      _moveElves(elves, firstDirection);
    }

    final minX = elves.reduce((a, b) => a.x < b.x ? a : b).x;
    final maxX = elves.reduce((a, b) => a.x > b.x ? a : b).x;
    final minY = elves.reduce((a, b) => a.y < b.y ? a : b).y;
    final maxY = elves.reduce((a, b) => a.y > b.y ? a : b).y;

    return List.generate(maxY - minY + 1, (y) => minY + y)
        .expand(
            (y) => List.generate(maxX - minX + 1, (x) => Point(minX + x, y)))
        .where((point) => !elves.contains(point))
        .length;
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final testInput = 'lib/day23/test.input_23.txt';
    final realInput = 'lib/day23/input_23.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final lines = input.split('\n');
    final elves = <Point<int>>{};
    for (var y = 0; y < lines.length; y++) {
      final line = lines[y];
      for (var x = 0; x < line.length; x++) {
        if (line[x] == '#') {
          elves.add(Point<int>(x, y));
        }
      }
    }
    final firstDirection = cycle(List.generate(4, (i) => i)).iterator;

    int round = 0;
    while (true) {
      round++;
      if (_moveElves(elves, firstDirection) == 0) {
        break;
      }
    }

    return round;
  }

  static int _moveElves(
    Set<Point<int>> elves,
    Iterator<int> firstDirection,
  ) {
    final proposals = <Point<int>, List<Point>>{};
    int startFacing;
    if (firstDirection.moveNext()) {
      startFacing = firstDirection.current;
    } else {
      return 0;
    }

    for (final elf in elves) {
      if (_elfOrientation.any((point) =>
          elves.contains(Point<int>(elf.x + point.x, elf.y + point.y)))) {
        continue;
      }

      for (var i = 0; i < 4; i++) {
        bool crowded = false;
        for (final direction in _directions[(startFacing + i) % 4]) {
          if (elves
              .contains(Point<int>(elf.x + direction.x, elf.y + direction.y))) {
            crowded = true;
            break;
          }
        }
        if (!crowded) {
          final direction = _directions[(startFacing + i) % 4][1];
          final proposal = Point<int>(elf.x + direction.x, elf.y + direction.y);
          proposals.putIfAbsent(proposal, () => []);
          proposals[proposal]?.add(elf);
          break;
        }
      }
    }

    for (final proposal in proposals.keys) {
      if (proposals[proposal]?.length == 1) {
        elves.remove(proposals[proposal]?[0]);
        elves.add(proposal);
      }
    }

    return proposals.isEmpty ? 0 : 1;
  }

  static Iterable<T> cycle<T>(Iterable<T> elements) sync* {
    while (true) {
      yield* elements;
    }
  }

  const Day23._();
}
