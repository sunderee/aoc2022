import 'package:aoc2022dart/aoc2022dart.dart';
import 'package:test/test.dart';

void main() {
  group('Day 6', () {
    // Some other test inputs that were provided that you can copy-paste and
    // substitute them in the test.input_6.txt file. Don't forget to modify the
    // expected value should you do this!
    //
    // - mjqjpqmgbljsphdztnvjfqwrcgsmlb     -> result 7
    // - bvwbjplbgvbhsrlpgdmjqwftvncz       -> result 5
    // - nppdvjthqldpwncqszvftbrmjlhg       -> result 6
    // - nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg  -> result 10
    // - zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw   -> result 11
    test('part 1', () async {
      final result = await Day6.runPart1(useTest: true);
      expect(result, 7);
    });

    // Same as above, these are test inputs with the solutions:
    //
    // - mjqjpqmgbljsphdztnvjfqwrcgsmlb     -> result 19
    // - bvwbjplbgvbhsrlpgdmjqwftvncz       -> result 23
    // - nppdvjthqldpwncqszvftbrmjlhg       -> result 23
    // - nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg  -> result 29
    // - zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw   -> result 26
    test('part 2', () async {
      final result = await Day6.runPart2(useTest: true);
      expect(result, 19);
    });
  });
}
