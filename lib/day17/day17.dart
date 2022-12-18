import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/tuples.dart';
import 'package:collection/collection.dart';

/// This day's solution is heavily inspired by work from Nicolas Delanou.
class Day17 {
  static final rocks = [
    [
      [true, true, true, true]
    ],
    [
      [false, true, false],
      [true, true, true],
      [false, true, false]
    ],
    [
      [true, true, true],
      [false, false, true],
      [false, false, true]
    ],
    [
      [
        true,
      ],
      [
        true,
      ],
      [
        true,
      ],
      [
        true,
      ]
    ],
    [
      [true, true],
      [true, true]
    ],
  ];

  static Future<int> runPart1({bool useTest = false}) async {
    final testInput = 'lib/day17/test.input_17.txt';
    final realInput = 'lib/day17/input_17.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final instructions = input
        .split('')
        .where((item) => item == '>' || item == '<')
        .map((item) => item == '>' ? 1 : -1)
        .toList();
    return _letsPlaySomeTetrisBoys(instructions, 2022);
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final testInput = 'lib/day17/test.input_17.txt';
    final realInput = 'lib/day17/input_17.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final instructions = input
        .split('')
        .where((item) => item == '>' || item == '<')
        .map((item) => item == '>' ? 1 : -1)
        .toList();

    return _letsPlaySomeTetrisBoys(instructions, 1000000000000);
  }

  static bool _isBlockColliding(
    List<Set<int>> state,
    List<List<bool>> rock,
    Pair<int, int> rockPosition,
  ) {
    if (rockPosition.second == 0) {
      return true;
    }

    for (var rockY = 0; rockY < rock.length; rockY++) {
      for (var rockX = 0; rockX < rock[rockY].length; rockX++) {
        if (rock[rockY][rockX]) {
          if (state[rockX + rockPosition.first]
              .contains(rockY + rockPosition.second)) {
            return true;
          }
        }
      }
    }
    return false;
  }

  static void _addBlockToGameGrid(
    List<Set<int>> state,
    List<List<bool>> rock,
    Pair<int, int> rockPosition,
  ) {
    for (var rockY = 0; rockY < rock.length; rockY++) {
      for (var rockX = 0; rockX < rock[rockY].length; rockX++) {
        if (rock[rockY][rockX]) {
          state[rockX + rockPosition.first].add(rockY + rockPosition.second);
        }
      }
    }
  }

  static int _letsPlaySomeTetrisBoys(List<int> jets, int numberOfBlocks) {
    final state = List.generate(7, (index) => <int>{});
    final Map<String, Pair<int, int>> cache = {};

    int jetIndex = 0;
    for (var roundIndex = 0; roundIndex < numberOfBlocks; roundIndex++) {
      final rockIndex = roundIndex % 5;
      final rock = rocks[rockIndex];
      final maxHeight = _getMaxGameGridHeight(state);
      var rockCursor = Pair<int, int>(2, maxHeight + 4);

      final cacheKey = getKey(jetIndex, rockIndex);
      if (cache.containsKey(cacheKey)) {
        final previous = cache[cacheKey]!;
        final previousRoundIndex = previous.first;
        final cycleLength = roundIndex - previousRoundIndex;

        final remainingRounds = numberOfBlocks - roundIndex;
        if (remainingRounds % cycleLength == 0) {
          final prevMaxHeight = previous.second;
          final cycleHeight = maxHeight - prevMaxHeight;

          return maxHeight + (remainingRounds ~/ cycleLength) * cycleHeight;
        }
      } else {
        cache[cacheKey] = Pair(roundIndex, maxHeight);
      }

      bool falling = true;
      while (falling) {
        int jet = jets[jetIndex];
        if (rockCursor.first + jet >= 0 &&
            rockCursor.first + rock.first.length + jet <= 7 &&
            !_isBlockColliding(state, rock, rockCursor.moved(jet, 0))) {
          rockCursor = rockCursor.moved(jet, 0);
        }
        jetIndex = (jetIndex + 1) % jets.length;

        if (_isBlockColliding(state, rock, rockCursor.moved(0, -1))) {
          _addBlockToGameGrid(state, rock, rockCursor);
          falling = false;
        } else {
          rockCursor = rockCursor.moved(0, -1);
        }
      }
    }

    return _getMaxGameGridHeight(state);
  }

  static int _getMaxGameGridHeight(List<Set<int>> state) =>
      state.map((e) => e.maxOrNull ?? 0).max;

  static String getKey(int jetIndex, int rockIndex) {
    return '$jetIndex-$rockIndex';
  }

  const Day17._();
}

extension _PairExt on Pair<int, int> {
  Pair<int, int> moved(int dx, int dy) => Pair(first + dx, second + dy);
}
