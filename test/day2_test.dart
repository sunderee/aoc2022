import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

void main() {
  group('Day 2', () {
    test('part 1', () async {
      final result = await Day2.runPart1();
      expect(result, 15);
    });

    test('part 2', () async {
      final result = await Day2.runPart2();
      expect(result, 12);
    });
  });
}
