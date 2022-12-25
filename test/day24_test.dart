import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

void main() {
  group('Day 24', () {
    test('part 1', () async {
      final result = await Day24.runPart1(useTest: true);
      expect(result, 18);
    });

    test('part 2', () async {
      final result = await Day24.runPart2(useTest: true);
      expect(result, 54);
    });
  });
}
