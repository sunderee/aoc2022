import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

void main() {
  group('Day 23', () {
    test('part 1', () async {
      final result = await Day23.runPart1(useTest: true);
      expect(result, 27);
    });

    test('part 2', () async {
      final result = await Day23.runPart2(useTest: true);
      expect(result, 1);
    });
  });
}
