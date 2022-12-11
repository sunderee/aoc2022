import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/tuples.dart';

class Day3 {
  static Future<int> runPart1({bool useTest = false}) async {
    final file = useTest ? 'lib/day3/test.input_3.txt' : 'lib/day3/input_3.txt';
    final input = await readTXT(file);

    return input
        .split('\n')
        .map((item) => _compartmentalize(item))
        .map((item) => _findCommonItemInStrings(item.first, item.second))
        .map((item) => _computePriority(item))
        .reduce((value, element) => value + element);
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final file = useTest ? 'lib/day3/test.input_3.txt' : 'lib/day3/input_3.txt';
    final input = await readTXT(file);

    return input
        .split('\n')
        .slices(3)
        .map((item) => [...item.map((innerItem) => innerItem.split(''))])
        .map((item) => _findCommonItemInLists(item))
        .map((item) => _computePriority(item))
        .reduce((value, element) => value + element);
  }

  static int _computePriority(String item) {
    return item.runes.single < 97
        ? item.runes.single - 64 + 26
        : item.runes.single - 96;
  }

  static Pair<String, String> _compartmentalize(String input) {
    if (input.length % 2 != 0) {
      throw ArgumentError('Input needs to have an even number of characters.');
    }

    return Pair(
      input.substring(0, input.length ~/ 2),
      input.substring(input.length ~/ 2),
    );
  }

  static String _findCommonItemInStrings(
    String compartment1,
    String compartment2,
  ) {
    return compartment1
        .split('')
        .where((item) => compartment2.split('').contains(item))
        .first;
  }

  static String _findCommonItemInLists(List<List<String>> group) {
    return group
        .fold<Set<String>>(
          group.first.toSet(),
          (previous, element) => previous.intersection(element.toSet()),
        )
        .first;
  }

  const Day3._();
}

extension _IterableExt<T> on Iterable<T> {
  /// This extension method was copied from the `collection` package. You can
  /// check the documentation here: https://pub.dev/documentation/collection.
  Iterable<List<T>> slices(int length) sync* {
    if (length < 1) {
      throw RangeError.range(length, 1, null, 'length');
    }

    var iterator = this.iterator;
    while (iterator.moveNext()) {
      var slice = [iterator.current];
      for (var i = 1; i < length && iterator.moveNext(); i++) {
        slice.add(iterator.current);
      }
      yield slice;
    }
  }
}
