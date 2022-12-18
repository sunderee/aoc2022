import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

void main() {
  group('Day 18', () {
    test('part 1', () async {
      final result = await Day18.runPart1(useTest: true);
      expect(result, -1);
    });

    test('part 6', () async {
      final result = await Day18.runPart2(useTest: true);
      expect(result, -1);
    });
  });
}
