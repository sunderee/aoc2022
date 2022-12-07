import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

void main() {
  group('Day 7', () {
    test('part 1', () async {
      final result = await Day7.runPart1(useTest: true);
      expect(result, 95437);
    });

    test('part 2', () async {
      final result = await Day7.runPart2(useTest: true);
      expect(result, 24933642);
    });
  });
}
