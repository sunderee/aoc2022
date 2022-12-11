import 'dart:math';

import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/let.dart';
import 'package:aoc2022dart/common/helpers/tuples.dart';

class Day9 {
  static final Map<String, Point<int>> _translations = {
    'U': Point(0, 1),
    'D': Point(0, -1),
    'L': Point(-1, 0),
    'R': Point(1, 0)
  };

  static Future<int> runPart1({bool useTest = false}) async {
    final file = useTest ? 'lib/day9/test.input_9.txt' : 'lib/day9/input_9.txt';
    final input = await readTXT(file);

    final rope = _Rope(2);
    final visited = {Point(0, 0)};

    input
        .split('\n')
        .map((item) => item.split(' '))
        .map((item) => Pair(item.first, int.parse(item.last)))
        .forEach((item) {
      final translation = _translations[item.first];
      for (var i = 1; i <= item.second; ++i) {
        translation?.let((it) {
          rope.move(it);
          visited.add(Point(rope.tail.x, rope.tail.y));
        });
      }
    });
    return visited.length;
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final file = useTest ? 'lib/day9/test.input_9.txt' : 'lib/day9/input_9.txt';
    final input = await readTXT(file);

    final rope = _Rope(10);
    final visited = {Point(0, 0)};

    input
        .split('\n')
        .map((item) => item.split(' '))
        .map((item) => Pair(item.first, int.parse(item.last)))
        .forEach((item) {
      final translation = _translations[item.first];
      for (var i = 1; i <= item.second; ++i) {
        translation?.let((it) {
          rope.move(it);
          visited.add(Point(rope.tail.x, rope.tail.y));
        });
      }
    });

    return visited.length;
  }

  const Day9._();
}

extension PointExt on Point<int> {
  Point<int> moveTo(Point<int> direction) => Point(
        x + direction.x,
        y + direction.y,
      );

  Point<int> moveTowards(Point<int> direction) {
    final dx = direction.x - x;
    final dy = direction.y - y;

    return Point(
      x + (dx != 0 ? dx ~/ dx.abs() : 0),
      y + (dy != 0 ? dy ~/ dy.abs() : 0),
    );
  }
}

class _Rope {
  final List<Point<int>> knots;

  Point<int> get tail => knots.last;

  _Rope(int length) : knots = List.generate(length, (_) => Point(0, 0));

  void move(Point<int> direction) {
    knots.first = knots.first.moveTo(direction);
    for (int i = 1; i < knots.length; ++i) {
      if (knots[i].squaredDistanceTo(knots[i - 1]) > 2) {
        knots[i] = knots[i].moveTowards(knots[i - 1]);
      }
    }
  }
}
