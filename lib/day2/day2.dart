import 'package:aoc2022dart/common/read_txt.dart';

class Day2 {
  static Future<int> runPart1({bool useTest = false}) async {
    final file = useTest ? 'lib/day2/test.input_2.txt' : 'lib/day2/input_2.txt';
    final input = await readTXT(file);

    return input
        .split('\n')
        .map((item) => item.split(' '))
        .map((item) => MapEntry(item.first, item.last))
        .map((item) => _computeOutcome(item))
        .whereType<int>()
        .reduce((value, element) => value + element);
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final file = useTest ? 'lib/day2/test.input_2.txt' : 'lib/day2/input_2.txt';
    final input = await readTXT(file);

    return input
        .split('\n')
        .map((item) => item.split(' '))
        .map((item) => MapEntry(item.first, item.last))
        .map((item) => _computeRiggedOutcome(item))
        .whereType<int>()
        .reduce((value, element) => value + element);
  }

  static int? _computeOutcome(MapEntry<String, String> play) {
    final playScore = _PlayersMove.from(play.value)?.score;
    final outcomeScore = _Outcome.getOutcome(play)?.score;
    if (playScore != null && outcomeScore != null) {
      return playScore + outcomeScore;
    }

    return null;
  }

  static int? _computeRiggedOutcome(MapEntry<String, String> play) {
    final expectedPlayScore =
        _OpponentsMove.from(play.key)?.expectedPlay[play.value]?.score;
    final outcomeScore = _Outcome.getRiggedOutcome(play.value)?.score;
    if (expectedPlayScore != null && outcomeScore != null) {
      return expectedPlayScore + outcomeScore;
    }

    return null;
  }

  const Day2._();
}

enum _OpponentsMove {
  rock({
    'X': _PlayersMove.scissors,
    'Y': _PlayersMove.rock,
    'Z': _PlayersMove.paper,
  }),
  paper({
    'X': _PlayersMove.rock,
    'Y': _PlayersMove.paper,
    'Z': _PlayersMove.scissors,
  }),
  scissors({
    'X': _PlayersMove.paper,
    'Y': _PlayersMove.scissors,
    'Z': _PlayersMove.rock,
  });

  static _OpponentsMove? from(String code) {
    switch (code) {
      case 'A':
        return _OpponentsMove.rock;
      case 'B':
        return _OpponentsMove.paper;
      case 'C':
        return _OpponentsMove.scissors;
      default:
        return null;
    }
  }

  final Map<String, _PlayersMove> expectedPlay;

  const _OpponentsMove(this.expectedPlay);
}

enum _PlayersMove {
  rock(1),
  paper(2),
  scissors(3);

  static _PlayersMove? from(String code) {
    switch (code) {
      case 'X':
        return _PlayersMove.rock;
      case 'Y':
        return _PlayersMove.paper;
      case 'Z':
        return _PlayersMove.scissors;
      default:
        return null;
    }
  }

  final int score;

  const _PlayersMove(this.score);
}

enum _Outcome {
  win(6, {'A': 'Y', 'B': 'Z', 'C': 'X'}),
  draw(3, {'A': 'X', 'B': 'Y', 'C': 'Z'}),
  loss(0, {'A': 'Z', 'B': 'X', 'C': 'Y'});

  static _Outcome? getOutcome(MapEntry<String, String> play) {
    if (_Outcome.win.outcomes[play.key] == play.value) {
      return _Outcome.win;
    } else if (_Outcome.draw.outcomes[play.key] == play.value) {
      return _Outcome.draw;
    } else if (_Outcome.loss.outcomes[play.key] == play.value) {
      return _Outcome.loss;
    } else {
      return null;
    }
  }

  static _Outcome? getRiggedOutcome(String code) {
    switch (code) {
      case 'X':
        return _Outcome.loss;
      case 'Y':
        return _Outcome.draw;

      case 'Z':
        return _Outcome.win;

      default:
        return null;
    }
  }

  final int score;
  final Map<String, String> outcomes;

  const _Outcome(
    this.score,
    this.outcomes,
  );
}
