import 'dart:collection';
import 'dart:math';

import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:equatable/equatable.dart';
import 'package:more/more.dart';

/// This day's solution is heavily inspired by work from an unknown Redditor.
class Day24 {
  static const headings = {
    'N': Point3(0, -1, 1),
    'W': Point3(-1, 0, 1),
    'E': Point3(1, 0, 1),
    'S': Point3(0, 1, 1),
    'F': Point3(0, 0, 1),
  };
  static final headingValues = headings.values;

  static const breezeDirections = {
    '^': Point(0, -1),
    '<': Point(-1, 0),
    '>': Point(1, 0),
    'v': Point(0, 1),
  };

  static Future<int> runPart1({bool useTest = false}) async {
    final testInput = 'lib/day24/test.input_24.txt';
    final realInput = 'lib/day24/input_24.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final lines = input.split('\n');
    final grid = lines.map((e) => e.split('')).toList();
    final height = grid.length - 2;
    final width = grid.first.length - 2;

    final starting = Point<int>(grid.first.indexOf('.') - 1, -1);
    final ending = Point<int>(grid.last.indexOf('.') - 1, height);

    final blizzards = <Blizzard>{};
    for (var y in 1.to(grid.length - 1)) {
      for (var x
          in 1.to(grid.first.length - 1).where((x) => grid[y][x] != '.')) {
        blizzards.add(
          Blizzard(
            Point(x - 1, y - 1),
            breezeDirections[grid[y][x]]!,
          ),
        );
      }
    }

    final duration = width.lcm(height);
    final blocks = <Point3>{};
    for (var t in 0.to(duration)) {
      for (var b in blizzards) {
        blocks.add(Point3(b.position.x, b.position.y, t));
        b.move(width, height);
      }
    }

    var cameFrom = <Point3, Point3>{};

    bool isBlocked(Point3 p3) => blocks.contains(Point3(
          p3.x,
          p3.y,
          p3.z % duration,
        ));

    bool isInBounds(Point3 point) {
      return Point(point.x, point.y) == starting ||
          Point(point.x, point.y) == ending ||
          point.x.between(0, width - 1) && point.y.between(0, height - 1);
    }

    Map<Point3, int> dijkstra(Point3 start, Point<int> end) {
      cameFrom = {start: Point3(-1, -1, -1)};

      final bestCost = {start: 0};
      final frontier = ListQueue<Point3>();
      frontier.add(start);

      while (frontier.isNotEmpty) {
        final currentLocation = frontier.removeFirst();
        if (currentLocation.x == end.x && currentLocation.y == end.y) break;
        var ns = headingValues
            .map((item) => currentLocation + item)
            .where((item) => isInBounds(item) && !isBlocked(item));
        for (var next in ns) {
          final newCost = bestCost[currentLocation]! + 1;
          if (!bestCost.containsKey(next) || newCost < bestCost[next]!) {
            bestCost[next] = newCost;
            frontier.add(next);
            cameFrom[next] = currentLocation;
          }
        }
      }
      return bestCost;
    }

    return dijkstra(Point3(starting.x, starting.y, 0), ending)
        .keys
        .firstWhere((e) => e.x == ending.x && e.y == ending.y)
        .z;
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final testInput = 'lib/day24/test.input_24.txt';
    final realInput = 'lib/day24/input_24.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final lines = input.split('\n');
    final grid = lines.map((e) => e.split('')).toList();
    final height = grid.length - 2;
    final width = grid.first.length - 2;

    final starting = Point<int>(grid.first.indexOf('.') - 1, -1);
    final ending = Point<int>(grid.last.indexOf('.') - 1, height);

    final blizzards = <Blizzard>{};
    for (var y in 1.to(grid.length - 1)) {
      for (var x
          in 1.to(grid.first.length - 1).where((x) => grid[y][x] != '.')) {
        blizzards.add(
          Blizzard(
            Point(x - 1, y - 1),
            breezeDirections[grid[y][x]]!,
          ),
        );
      }
    }

    final duration = width.lcm(height);
    final blocks = <Point3>{};
    for (var t in 0.to(duration)) {
      for (var b in blizzards) {
        blocks.add(Point3(b.position.x, b.position.y, t));
        b.move(width, height);
      }
    }

    var cameFrom = <Point3, Point3>{};

    bool isBlocked(Point3 p3) => blocks.contains(Point3(
          p3.x,
          p3.y,
          p3.z % duration,
        ));

    bool isInBounds(Point3 point) {
      return Point(point.x, point.y) == starting ||
          Point(point.x, point.y) == ending ||
          point.x.between(0, width - 1) && point.y.between(0, height - 1);
    }

    Map<Point3, int> dijkstra(Point3 start, Point<int> end) {
      cameFrom = {start: Point3(-1, -1, -1)};

      final bestCost = {start: 0};
      final frontier = ListQueue<Point3>();
      frontier.add(start);

      while (frontier.isNotEmpty) {
        final currentLocation = frontier.removeFirst();
        if (currentLocation.x == end.x && currentLocation.y == end.y) break;
        var ns = headingValues
            .map((item) => currentLocation + item)
            .where((item) => isInBounds(item) && !isBlocked(item));
        for (var next in ns) {
          final newCost = bestCost[currentLocation]! + 1;
          if (!bestCost.containsKey(next) || newCost < bestCost[next]!) {
            bestCost[next] = newCost;
            frontier.add(next);
            cameFrom[next] = currentLocation;
          }
        }
      }
      return bestCost;
    }

    var result = dijkstra(Point3(starting.x, starting.y, 0), ending);
    var keys =
        result.keys.firstWhere((e) => e.x == ending.x && e.y == ending.y).z;
    result = dijkstra(Point3(ending.x, ending.y, keys), starting);
    keys =
        result.keys.firstWhere((e) => e.x == starting.x && e.y == starting.y).z;
    result = dijkstra(Point3(starting.x, starting.y, keys), ending);

    return result.keys.firstWhere((e) => e.x == ending.x && e.y == ending.y).z;
  }

  const Day24._();
}

class Point3 extends Equatable {
  final int x;
  final int y;
  final int z;

  @override
  List<Object?> get props => [x, y, z];

  const Point3(
    this.x,
    this.y,
    this.z,
  );

  Point3 operator +(Point3 o) => Point3(o.x + x, o.y + y, o.z + z);
}

class Blizzard {
  Point<int> position;
  Point<int> direction;

  Blizzard(this.position, this.direction);

  void move(int width, int height) {
    position = Point<int>(
      (position.x + direction.x) % width,
      (position.y + direction.y) % height,
    );
  }
}
