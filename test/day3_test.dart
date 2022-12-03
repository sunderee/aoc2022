import 'package:aoc2022dart/day3/day3.dart';
import 'package:test/test.dart';

void main() {
  group('Day 3', () {
    test('part 1', () async {
      final result = await Day3.runPart1(useTest: true);
      expect(result, 157);
    });

    test('part 2', () async {
      final result = await Day3.runPart2(useTest: true);
      expect(result, 70);
    });
  });
}
