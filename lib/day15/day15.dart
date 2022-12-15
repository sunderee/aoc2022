import 'dart:math';

import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/let.dart';
import 'package:aoc2022dart/common/helpers/tuples.dart';
import 'package:collection/collection.dart';

class Day15 {
  static Future<int> runPart1({bool useTest = false}) async {
    final testInput = 'lib/day15/test.input_15.txt';
    final realInput = 'lib/day15/input_15.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final List<Pair<Point<int>, Point<int>>> sensorsAndBeacons = [];
    input.split('\n').forEach((item) {
      final xCoordinates = RegExp(r'(?<=x\=)(\d+|\-\d+)(?=\,)')
          .allMatches(item)
          .map((match) => match.group(0))
          .whereType<String>()
          .let((it) => Pair(int.parse(it.first), int.parse(it.last)));
      final yCoordinates = RegExp(r'(?<=y\=)(\d+|\-\d+)')
          .allMatches(item)
          .map((match) => match.group(0))
          .whereType<String>()
          .let((it) => Pair(int.parse(it.first), int.parse(it.last)));

      sensorsAndBeacons.add(Pair(
        Point(xCoordinates.first, yCoordinates.first),
        Point(xCoordinates.second, yCoordinates.second),
      ));
    });

    final rowIndex = useTest ? 20 : 2000000;
    final Set<Point<int>> sensorsBeaconsOrOccupied = {};
    for (var item in sensorsAndBeacons) {
      final distance = _manhattanDistance(item.first, item.second);
      if ((rowIndex - item.first.y).abs() < distance) {
        for (var x = -distance + (rowIndex - item.first.y).abs();
            x <= distance - (rowIndex - item.first.y).abs();
            x++) {
          sensorsBeaconsOrOccupied.add(Point(item.first.x + x, rowIndex));
        }
      }
    }

    return sensorsBeaconsOrOccupied.length - 1;
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final testInput = 'lib/day15/test.input_15.txt';
    final realInput = 'lib/day15/input_15.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final List<Pair<Point<int>, Point<int>>> sensorsAndBeacons = [];
    input.split('\n').forEach((item) {
      final xCoordinates = RegExp(r'(?<=x\=)(\d+|\-\d+)(?=\,)')
          .allMatches(item)
          .map((match) => match.group(0))
          .whereType<String>()
          .let((it) => Pair(int.parse(it.first), int.parse(it.last)));
      final yCoordinates = RegExp(r'(?<=y\=)(\d+|\-\d+)')
          .allMatches(item)
          .map((match) => match.group(0))
          .whereType<String>()
          .let((it) => Pair(int.parse(it.first), int.parse(it.last)));

      sensorsAndBeacons.add(Pair(
        Point(xCoordinates.first, yCoordinates.first),
        Point(xCoordinates.second, yCoordinates.second),
      ));
    });

    final candidates = <Point<int>>{};
    final maxXorYCoordinate = useTest ? 20 : 4000000;
    for (final pair in sensorsAndBeacons) {
      final dy = (pair.first.y - pair.second.y).abs();
      final distance = _manhattanDistance(pair.first, pair.second) + 1;
      for (var y = -dy - 1; y <= dy + 1; y++) {
        for (final x in [distance - y, -distance + y]) {
          final candidateX = pair.first.x + x;
          final candidateY = pair.first.y + y;
          if (candidateX >= 0 &&
              candidateY >= 0 &&
              candidateX <= maxXorYCoordinate &&
              candidateY <= maxXorYCoordinate) {
            candidates.add(Point<int>(candidateX, candidateY));
          }
        }
      }
    }
    for (final pair in sensorsAndBeacons) {
      final notCandidates = <Point<int>>{};
      for (final candidate in candidates) {
        final distance = _manhattanDistance(pair.first, pair.second);
        final candidateDeltaX = (candidate.x - pair.first.x).abs();
        final candidateDeltaY = (candidate.y - pair.first.y).abs();
        final candidateDist = candidateDeltaX + candidateDeltaY;
        if (candidateDist <= distance) {
          notCandidates.add(candidate);
        }
        notCandidates.add(pair.second);
      }

      candidates.removeAll(notCandidates);
    }

    final result = candidates.firstOrNull?.let((it) => it.x * 4000000 + it.y);
    return result ?? -1;
  }

  static int _manhattanDistance(Point<int> first, Point<int> second) {
    return (first.x - second.x).abs() + (first.y - second.y).abs();
  }

  const Day15._();
}
