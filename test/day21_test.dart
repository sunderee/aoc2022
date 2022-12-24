import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

void main() {
  group('Day 21', () {
    test('part 1', () async {
      final result = await Day21.runPart1(useTest: true);
      expect(result, 152);
    });

    test('part 2', () async {
      final result = await Day21.runPart2(useTest: true);
      expect(result, 1);
    });
  });
}
