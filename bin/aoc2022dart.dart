import 'package:aoc2022dart/aoc2022dart.dart';

Future<void> main() async {
  print('--- START OF DAY 1 ---');
  final resultDay1Part1 = await Day1.runPart1();
  final resultDay1Part2 = await Day1.runPart2();

  print('Max calories carried by an elf: $resultDay1Part1');
  print('Total calories carried by top 3 elves: $resultDay1Part2');
  print('--- END OF DAY 1 ---\n');

  print('--- START OF DAY 2 ---');
  final resultDay2Part1 = await Day2.runPart1();
  final resultDay2Part2 = await Day2.runPart2();

  print('RPS score: $resultDay2Part1');
  print('Rigged RPS score: $resultDay2Part2');
  print('--- END OF DAY 2 ---\n');
}
