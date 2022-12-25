import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

void main() {
  group('Day 25', () {
    test('part 1', () async {
      final result = await Day25.runPart1(useTest: true);
      expect(result, '2=-1=0');
    });
  });
}
