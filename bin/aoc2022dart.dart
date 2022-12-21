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
  print('--- END OF DAY 5 ---\n');

  print('--- START OF DAY 6 ---');
  final resultDay6Part1 = await Day6.runPart1();
  final resultDay6Part2 = await Day6.runPart2();

  print('# characters before first start-of-packet marker: $resultDay6Part1');
  print('# characters before first start-of-message marker: $resultDay6Part2');
  print('--- END OF DAY 6 ---\n');

  print('--- START OF DAY 7 ---');
  final resultDay7Part1 = await Day7.runPart1();
  final resultDay7Part2 = await Day7.runPart2();

  print('Total size of directories smaller than 100k: $resultDay7Part1');
  print('Size of the smallest directory to delete: $resultDay7Part2');
  print('--- END OF DAY 7 ---\n');

  print('--- START OF DAY 8 ---');
  final resultDay8Part1 = await Day8.runPart1();
  final resultDay8Part2 = await Day8.runPart2();

  print('Number of visible trees: $resultDay8Part1');
  print('Best scenic score: $resultDay8Part2');
  print('--- END OF DAY 8 ---\n');

  print('--- START OF DAY 9 ---');
  final resultDay9Part1 = await Day9.runPart1();
  final resultDay9Part2 = await Day9.runPart2();

  print('Visited positions by rope\'s tail: $resultDay9Part1');
  print('Oh snap! Positions visited by tail at least once: $resultDay9Part2');
  print('--- END OF DAY 9 ---\n');

  print('--- START OF DAY 10 ---');
  final resultDay10Part1 = await Day10.runPart1();
  final resultDay10Part2 = await Day10.runPart2();

  print('Sum of signal strengths: $resultDay10Part1');
  print('CRT output:\n$resultDay10Part2');
  print('--- END OF DAY 10 ---\n');

  print('--- START OF DAY 11 ---');
  final resultDay11Part1 = Day11.runPart1();
  final resultDay11Part2 = Day11.runPart2();

  print('Level of monkey business (20 rounds) $resultDay11Part1');
  print('Level of monkey business #2 (10k rounds): $resultDay11Part2');
  print('--- END OF DAY 11 ---\n');

  print('--- START OF DAY 12 ---');
  final resultDay12Part1 = await Day12.runPart1();
  final resultDay12Part2 = await Day12.runPart2();

  print('Shortest path from S -> E: $resultDay12Part1');
  print('Shortest path from any "a" -> E: $resultDay12Part2');
  print('--- END OF DAY 12 ---\n');

  print('--- START OF DAY 13 ---');
  final resultDay13Part1 = await Day13.runPart1();
  final resultDay13Part2 = await Day13.runPart2();

  print('Sum of indices of pairs in the right order: $resultDay13Part1');
  print('Decoder key for distress signal: $resultDay13Part2');
  print('--- END OF DAY 13 ---\n');

  print('--- START OF DAY 14 ---');
  final resultDay14Part1 = await Day14.runPart1();
  final resultDay14Part2 = await Day14.runPart2();

  print('Units of sand before they overflow to abyss: $resultDay14Part1');
  print('Units of sand before they fill floor -> 500,0: $resultDay14Part2');
  print('--- END OF DAY 14 ---\n');

  print('--- START OF DAY 15 ---');
  final resultDay15Part1 = await Day15.runPart1();
  final resultDay15Part2 = await Day15.runPart2();

  print('# positions that cannot contain a beacon: $resultDay15Part1');
  print('Distress beacon\'s tuning frequency: $resultDay15Part2');
  print('--- END OF DAY 15 ---\n');

  print('--- START OF DAY 16 ---');
  final resultDay16Part1 = await Day16.runPart1();
  final resultDay16Part2 = await Day16.runPart2();

  print('Total pressure released in 30 minutes: $resultDay16Part1');
  print('Pressure released with the help of an elephant: $resultDay16Part2');
  print('--- END OF DAY 16 ---\n');

  print('--- START OF DAY 17 ---');
  final resultDay17Part1 = await Day17.runPart1();
  final resultDay17Part2 = await Day17.runPart2();

  print('Rock tower height after 2022 rocks: $resultDay17Part1');
  print('Rock tower height after 1e12 rocks: $resultDay17Part2');
  print('--- END OF DAY 17 ---\n');

  print('--- START OF DAY 18 ---');
  final resultDay18Part1 = await Day18.runPart1();
  final resultDay18Part2 = await Day18.runPart2();

  print('Surface area of scanned lava droplet: $resultDay18Part1');
  print('Exterior surface area of scanned lava droplet: $resultDay18Part2');
  print('--- END OF DAY 18 ---\n');

  print('--- START OF DAY 19 ---');
  final resultDay19Part1 = await Day19.runPart1();
  final resultDay19Part2 = await Day19.runPart2();

  print('Sum of all quality levels: $resultDay19Part1');
  print('Result of first three multiplied: $resultDay19Part2');
  print('--- END OF DAY 19 ---\n');

  print('--- START OF DAY 20 ---');
  final resultDay20Part1 = await Day20.runPart1();
  final resultDay20Part2 = await Day20.runPart2();

  print('Sum of numbers forming groove coordinates: $resultDay20Part1');
  print('Sum after applying the decryption key: $resultDay20Part2');
  print('--- END OF DAY 20 ---\n');
}
