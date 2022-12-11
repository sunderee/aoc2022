import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

void main() {
  group('Day 10', () {
    test('part 1', () async {
      final result = await Day10.runPart1(useTest: true);
      expect(result, 13140);
    });

    test('part 2', () async {
      final expectedResult = r'''
##..##..##..##..##..##..##..##..##..##..
###...###...###...###...###...###...###.
####....####....####....####....####....
#####.....#####.....#####.....#####.....
######......######......######......####
#######.......#######.......#######.....
''';
      final result = await Day10.runPart2(useTest: true);
      expect(result, expectedResult);
    });
  });
}
