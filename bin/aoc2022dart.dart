import 'package:aoc2022dart/aoc2022dart.dart';

Future<void> main() async {
  print('--- START OF DAY 1 ---');
  final resultDay1 = await Day1.run();
  print('Max calories carried by an elf: $resultDay1');
  print('--- END OF DAY 1 ---\n');

  print('--- START OF DAY 2 ---');
  final resultDay2 = await Day2.run();
  print('Total calories carried by top 3 elves: $resultDay2');
  print('--- END OF DAY 2 ---\n');
}
