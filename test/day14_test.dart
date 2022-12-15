import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

void main() {
  group('Day 14', () {
    test('part 1', () async {
      final result = await Day14.runPart1(useTest: true);
      expect(result, 24);
    });

    test('part 2', () async {
      final result = await Day14.runPart2(useTest: true);
      expect(result, 93);
    });
  });
}
