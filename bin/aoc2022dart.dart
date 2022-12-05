import 'package:aoc2022dart/aoc2022dart.dart';

Future<void> main() async {
  print('--- START OF DAY 1 ---');
  final resultDay1Part1 = await Day1.runPart1();
  final resultDay1Part2 = await Day1.runPart2();

  print('Max calories carried by an Elf: $resultDay1Part1');
  print('Total calories carried by top 3 Elves: $resultDay1Part2');
  print('--- END OF DAY 1 ---\n');

  print('--- START OF DAY 2 ---');
  final resultDay2Part1 = await Day2.runPart1();
  final resultDay2Part2 = await Day2.runPart2();

  print('Rock-Paper-Scissors score: $resultDay2Part1');
  print('Rigged Rock-Paper-Scissors score: $resultDay2Part2');
  print('--- END OF DAY 2 ---\n');

  print('--- START OF DAY 3 ---');
  final resultDay3Part1 = await Day3.runPart1();
  final resultDay3Part2 = await Day3.runPart2();

  print('Items priority sum: $resultDay3Part1');
  print('Sum of priorities of Elf groups: $resultDay3Part2');
  print('--- END OF DAY 3 ---\n');

  print('--- START OF DAY 4 ---');
  final resultDay4Part1 = await Day4.runPart1();
  final resultDay4Part2 = await Day4.runPart2();

  print('Number of overlapping assignments: $resultDay4Part1');
  print('Number of partial overlaps: $resultDay4Part2');
  print('--- END OF DAY 4 ---\n');

  print('--- START OF DAY 5 ---');
  final resultDay5Part1 = await Day5.runPart1();
  final resultDay5Part2 = await Day5.runPart2();

  print('Crates on top: $resultDay5Part1');
  print('Actual crates on top: $resultDay5Part2');
  print('--- END OF DAY 5 ---');
}
