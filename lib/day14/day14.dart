import 'dart:math';

import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/let.dart';
import 'package:collection/collection.dart';

class Day14 {
  static Future<int> runPart1({bool useTest = false}) async {
    final testInput = 'lib/day14/test.input_14.txt';
    final realInput = 'lib/day14/input_14.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final scan = input.split('\n').map((item) => item.split('->').map(
        (innerItem) => innerItem
            .trim()
            .split(',')
            .let((it) => Point(int.parse(it.first), int.parse(it.last)))));

    final Set<Point<int>> positionsOfRocks = {};
    for (var element in scan) {
      element.forEachIndexed((index, point) {
        if (index == 0) {
          positionsOfRocks.add(point);
        } else {
          final previousPoint = element.elementAt(index - 1);

          if (point.x == previousPoint.x) {
            final count = (point.y - previousPoint.y).abs();
            final startY = min(point.y, previousPoint.y);
            final rocks = List.generate(
              count + 1,
              (i) => Point(point.x, i + startY),
            );
            positionsOfRocks.addAll(rocks);
          } else if (point.y == previousPoint.y) {
            final count = (point.x - previousPoint.x).abs();
            final startX = min(point.x, previousPoint.x);

            final rocks = List.generate(
              count + 1,
              (i) => Point(i + startX, point.y),
            );
            positionsOfRocks.addAll(rocks);
          }
        }
      });
    }

    final origin = Point(500, 0);
    final maxFallDistance = 600;
    final positionsOfRocksAndSand = {...positionsOfRocks};
    final positionsOfSand = <Point<int>>{};

    bool isSandFalling = true;
    do {
      Point<int> sandBlockPosition = origin;
      int distance = 0;

      while (_positionSandParticle(
                sandBlockPosition,
                positionsOfRocksAndSand,
              ) !=
              null &&
          distance < maxFallDistance) {
        _positionSandParticle(sandBlockPosition, positionsOfRocksAndSand)
            ?.let((it) => sandBlockPosition = it);
        distance++;
      }
      positionsOfRocksAndSand.add(sandBlockPosition);
      positionsOfSand.add(sandBlockPosition);

      isSandFalling = distance < maxFallDistance;
    } while (isSandFalling);

    return positionsOfSand.length - 1;
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final testInput = 'lib/day14/test.input_14.txt';
    final realInput = 'lib/day14/input_14.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final scan = input.split('\n').map((item) => item.split('->').map(
        (innerItem) => innerItem
            .trim()
            .split(',')
            .let((it) => Point(int.parse(it.first), int.parse(it.last)))));

    final Set<Point<int>> positionsOfRocks = {};
    for (var element in scan) {
      element.forEachIndexed((index, point) {
        if (index == 0) {
          positionsOfRocks.add(point);
        } else {
          final previousPoint = element.elementAt(index - 1);

          if (point.x == previousPoint.x) {
            final count = (point.y - previousPoint.y).abs();
            final startY = min(point.y, previousPoint.y);
            final rocks = List.generate(
              count + 1,
              (i) => Point(point.x, i + startY),
            );
            positionsOfRocks.addAll(rocks);
          } else if (point.y == previousPoint.y) {
            final count = (point.x - previousPoint.x).abs();
            final startX = min(point.x, previousPoint.x);

            final rocks = List.generate(
              count + 1,
              (i) => Point(i + startX, point.y),
            );
            positionsOfRocks.addAll(rocks);
          }
        }
      });
    }

    final floorDepth = positionsOfRocks.map((item) => item.y).reduce(max) + 2;
    for (var x = -10000; x <= 10000; x++) {
      positionsOfRocks.add(Point(x, floorDepth));
    }

    final origin = Point(500, 0);
    final positionsOfRocksAndSand = {...positionsOfRocks};
    final positionsOfSand = <Point<int>>{};

    bool isSandFalling = true;
    do {
      Point<int> sandBlockPosition = origin;

      while (_positionSandParticle(
            sandBlockPosition,
            positionsOfRocksAndSand,
          ) !=
          null) {
        _positionSandParticle(sandBlockPosition, positionsOfRocksAndSand)
            ?.let((it) => sandBlockPosition = it);
      }
      positionsOfRocksAndSand.add(sandBlockPosition);
      positionsOfSand.add(sandBlockPosition);

      isSandFalling = sandBlockPosition != origin;
    } while (isSandFalling);

    return positionsOfSand.length;
  }

  static Point<int>? _positionSandParticle(
    Point<int> position,
    Set<Point<int>> occupiedOrBlockedPositions,
  ) {
    final positionBelow = position.let((it) => Point(it.x, it.y + 1));
    final positionBelowLeft = position.let((it) => Point(it.x - 1, it.y + 1));
    final positionBelowRight = position.let((it) => Point(it.x + 1, it.y + 1));

    if (!occupiedOrBlockedPositions.contains(positionBelow)) {
      return positionBelow;
    } else if (!occupiedOrBlockedPositions.contains(positionBelowLeft)) {
      return positionBelowLeft;
    } else if (!occupiedOrBlockedPositions.contains(positionBelowRight)) {
      return positionBelowRight;
    }

    return null;
  }

  const Day14._();
}
