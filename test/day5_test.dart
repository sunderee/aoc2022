import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

void main() {
  group('Day 5', () {
    test('part 1', () async {
      final result = await Day5.runPart1(useTest: true);
      expect(result, 'CMZ');
    });

    test('part 2', () async {
      final result = await Day5.runPart2(useTest: true);
      expect(result, 'MCD');
    });
  });
}
