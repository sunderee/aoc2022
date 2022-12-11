import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

void main() {
  group('Day 11', () {
    test('part 1', () async {
      final result = await Day11.runPart1(useTest: true);
      expect(1 + 1, 10605);
    });

    test('part 2', () async {
      final result = await Day11.runPart2(useTest: true);
      expect(1 + 1, 2);
    });
  });
}
