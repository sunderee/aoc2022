import 'dart:math';

import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/also.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/let.dart';
import 'package:aoc2022dart/common/helpers/tuples.dart';
import 'package:directed_graph/directed_graph.dart';
import 'package:meta/meta.dart';

class Day12 {
  static Future<int> runPart1({bool useTest = false}) async {
    final testInput = 'lib/day12/test.input_12.txt';
    final realInput = 'lib/day12/input_12.txt';
    final input = await readTXT(useTest ? testInput : realInput);
    final grid = input.split('\n').map((item) => item.split('')).toList();

    final Map<String, _Node> rawGraph = {};

    Point<int> start = Point<int>(-1, -1);
    Point<int> end = Point<int>(-1, -1);
    for (var y = 0; y < grid.length; y++) {
      for (var x = 0; x < grid.first.length; x++) {
        if (grid[y][x] == 'S') {
          start = Point<int>(x, y);
        }
        if (grid[y][x] == 'E') {
          end = Point<int>(x, y);
        }

        final elevation = _elevation(grid[y][x]);
        final edges = _viableNeighbors(
          x: x,
          y: y,
          currentElevation: elevation,
          grid: grid,
        )
            .map((item) => _deserialize(item))
            .map((item) => Point(item.first, item.second))
            .toList();

        rawGraph[_serialize(x, y)] = _Node(value: Point(x, y), edges: edges);
      }
    }

    final graph = DirectedGraph<Point<int>>(
      Map.fromEntries(
        rawGraph.entries.map(
          (item) => MapEntry(
            _deserialize(item.key).let(
              (it) => Point(
                it.first,
                it.second,
              ),
            ),
            item.value.edges.toSet(),
          ),
        ),
      ),
    );

    return graph.shortestPath(start, end).length - 1;
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final testInput = 'lib/day12/test.input_12.txt';
    final realInput = 'lib/day12/input_12.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final grid = input.split('\n').map((item) => item.split('')).toList();

    final Map<String, _Node> rawGraph = {};

    final List<Point<int>> starts = [];
    Point<int> end = Point<int>(-1, -1);
    for (var y = 0; y < grid.length; y++) {
      for (var x = 0; x < grid.first.length; x++) {
        if (grid[y][x] == 'S' || grid[y][x] == 'a') {
          starts.add(Point<int>(x, y));
        }
        if (grid[y][x] == 'E') {
          end = Point<int>(x, y);
        }

        final elevation = _elevation(grid[y][x]);
        final edges = _viableNeighbors(
          x: x,
          y: y,
          currentElevation: elevation,
          grid: grid,
        )
            .map((item) => _deserialize(item))
            .map((item) => Point(item.first, item.second))
            .toList();

        rawGraph[_serialize(x, y)] = _Node(value: Point(x, y), edges: edges);
      }
    }

    final graph = DirectedGraph<Point<int>>(
      Map.fromEntries(
        rawGraph.entries.map(
          (item) => MapEntry(
            _deserialize(item.key).let(
              (it) => Point(
                it.first,
                it.second,
              ),
            ),
            item.value.edges.toSet(),
          ),
        ),
      ),
    );

    return starts
        .map((item) => graph.shortestPath(item, end).length - 1)
        .toList()
        .also((it) => it.sort())
        .firstWhere((item) => item > 0);
  }

  static List<String> _viableNeighbors({
    required int x,
    required int y,
    required int currentElevation,
    required List<List<String>> grid,
  }) {
    final rowsCount = grid.length;
    final columnsCount = grid.first.length;

    final itemTop = y < rowsCount - 1
        ? Pair(
            _serialize(x, y + 1),
            grid[y + 1][x],
          )
        : null;
    final itemBottom = y > 0
        ? Pair(
            _serialize(x, y - 1),
            grid[y - 1][x],
          )
        : null;
    final itemLeft = x > 0
        ? Pair(
            _serialize(x - 1, y),
            grid[y][x - 1],
          )
        : null;
    final itemRight = x < columnsCount - 1
        ? Pair(
            _serialize(x + 1, y),
            grid[y][x + 1],
          )
        : null;

    return [itemTop, itemBottom, itemLeft, itemRight]
        .whereType<Pair<String, String>>()
        .where((item) => _elevation(item.second) <= currentElevation + 1)
        .map((item) => item.first)
        .toList();
  }

  static int _elevation(String input) => input == 'S'
      ? 1
      : input == 'E'
          ? 26
          : input.runes.first - 96;

  static String _serialize(int x, int y) => '$x:$y';

  static Pair<int, int> _deserialize(String input) => input
      .split(':')
      .let((it) => Pair(int.parse(it.first), int.parse(it.last)));
}

@immutable
class _Node {
  final Point<int> value;
  final List<Point<int>> edges;

  _Node({
    required this.value,
    required this.edges,
  });
}
