import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

// Before the test, make sure that you use test data
void main() {
  group('Day 1', () {
    test('part 1', () async {
      final result = await Day1.runPart1(useTest: true);
      expect(result, 24000);
    });

    test('part 2', () async {
      final result = await Day1.runPart2(useTest: true);
      expect(result, 45000);
    });
  });
}
