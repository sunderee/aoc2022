import 'dart:math';

import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/also.dart';
import 'package:equatable/equatable.dart';

class Day18 {
  static Future<int> runPart1({bool useTest = false}) async {
    final testInput = 'lib/day18/test.input_18.txt';
    final realInput = 'lib/day18/input_18.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final cubePositions = input
        .split('\n')
        .map((item) => item.split(','))
        .where((item) => item.length == 3)
        .map((item) => item.map((innerItem) => int.parse(innerItem)).toList())
        .map((item) => Point3D(item[0], item[1], item[2]));

    return cubePositions
        .expand((item) => _getNeighborsIn3D(item.x, item.y, item.z))
        .where((item) => !cubePositions.contains(item))
        .length;
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final testInput = 'lib/day18/test.input_18.txt';
    final realInput = 'lib/day18/input_18.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final cubePositions = input
        .split('\n')
        .map((item) => item.split(','))
        .where((item) => item.length == 3)
        .map((item) => item.map((innerItem) => int.parse(innerItem)).toList())
        .map((item) => Point3D(item[0], item[1], item[2]));
    final setOfCubePositions = cubePositions.toSet();

    final maximums = [
      cubePositions.map((item) => item.x).reduce(max),
      cubePositions.map((item) => item.y).reduce(max),
      cubePositions.map((item) => item.z).reduce(max),
    ];

    final visited = <Point3D>{};
    final frontier = [Point3D(0, 0, 0)];
    final directions = [
      [1, 0, 0],
      [-1, 0, 0],
      [0, 1, 0],
      [0, -1, 0],
      [0, 0, 1],
      [0, 0, -1]
    ];

    while (frontier.isNotEmpty) {
      final next = frontier.removeLast().also((it) => visited.add(it));

      for (final direction in directions) {
        final nextCube = Point3D(
          next.x + direction[0],
          next.y + direction[1],
          next.z + direction[2],
        );
        if (nextCube.x >= -1 &&
            nextCube.y >= -1 &&
            nextCube.z >= -1 &&
            nextCube.x <= maximums[0] + 1 &&
            nextCube.y <= maximums[1] + 1 &&
            nextCube.z <= maximums[2] + 1) {
          if (!setOfCubePositions.contains(nextCube) &&
              !visited.contains(nextCube)) {
            frontier.add(nextCube);
          }
        }
      }
    }

    var exteriorSurfaceArea = 0;
    for (final cube in cubePositions) {
      for (final water in visited) {
        final distance = (water.x - cube.x).abs() +
            (water.y - cube.y).abs() +
            (water.z - cube.z).abs();
        if (distance == 1) {
          exteriorSurfaceArea++;
        }
      }
    }
    return exteriorSurfaceArea;
  }

  static List<Point3D> _getNeighborsIn3D(int x, int y, int z) => [
        Point3D(x + 1, y, z),
        Point3D(x, y + 1, z),
        Point3D(x, y, z + 1),
        Point3D(x - 1, y, z),
        Point3D(x, y - 1, z),
        Point3D(x, y, z - 1),
      ];

  const Day18._();
}

class Point3D extends Equatable {
  final int x;
  final int y;
  final int z;

  @override
  List<Object?> get props => [x, y, z];

  Point3D(this.x, this.y, this.z);
}
