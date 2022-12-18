import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

void main() {
  group('Day 16', () {
    test('part 1', () async {
      final result = await Day16.runPart1(useTest: true);
      expect(result, 1651);
    });

    test('part 2', () async {
      final result = await Day16.runPart2(useTest: true);
      expect(result, 2654);
    });
  });
}
