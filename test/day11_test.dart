import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

void main() {
  group('Day 11', () {
    test('part 1', () {
      final result = Day11.runPart1(useTest: true);
      expect(result, 10605);
    });

    test('part 2', () {
      final result = Day11.runPart2(useTest: true);
      expect(result, 2713310158);
    });
  });
}
