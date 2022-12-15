import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

void main() {
  group('Day 15', () {
    test('part 1', () async {
      final result = await Day15.runPart1(useTest: true);
      expect(result, 26);
    });

    test('part 2', () async {
      final result = await Day15.runPart2(useTest: true);
      expect(result, 56000011);
    });
  });
}
