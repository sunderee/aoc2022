import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

void main() {
  group('Day 12', () {
    test('part 1', () async {
      final result = await Day20.runPart1(useTest: true);
      expect(result, 3);
    });

    test('part 2', () async {
      final result = await Day20.runPart2(useTest: true);
      expect(result, 1623178306);
    });
  });
}
