import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

void main() {
  group('Day 12', () {
    test('part 1', () async {
      final result = await Day12.runPart1(useTest: true);
      expect(result, 31);
    });

    test('part 2', () async {
      final result = await Day12.runPart2(useTest: true);
      expect(result, 29);
    });
  });
}
