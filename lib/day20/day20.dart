import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

/// This day's solution is heavily inspired by work from Meï.
class Day20 {
  static Future<int> runPart1({bool useTest = false}) async {
    final testInput = 'lib/day20/test.input_20.txt';
    final realInput = 'lib/day20/input_20.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final data = input
        .split('\n')
        .map((item) => int.tryParse(item))
        .whereType<int>()
        .mapIndexed((i, item) => ArrayElement(value: item, position: i))
        .toList();

    for (int i = 0; i < data.length; i++) {
      int indexOfValue = data.indexWhere((item) => item.position == i);
      final encryptedData = data[indexOfValue];
      int value = data[indexOfValue].value;
      value = value % (data.length - 1);
      if (value < 0) {
        for (int x = 0; x < value.abs(); x++) {
          if (indexOfValue == 0) {
            data.removeAt(indexOfValue);
            data.insert(data.length, encryptedData);
            indexOfValue = data.length - 1;
          }
          data.swap(indexOfValue, indexOfValue - 1);
          indexOfValue -= 1;
          if (indexOfValue == 0) {
            data.removeAt(indexOfValue);
            data.insert(data.length, encryptedData);
            indexOfValue = data.length - 1;
          }
        }
      } else {
        for (int x = 0; x < value.abs(); x++) {
          if (indexOfValue == data.length - 1) {
            data.removeAt(indexOfValue);
            data.insert(0, encryptedData);
            indexOfValue = 0;
          }
          data.swap(indexOfValue, indexOfValue + 1);
          indexOfValue += 1;
          if (indexOfValue == data.length - 1) {
            data.removeAt(indexOfValue);
            data.insert(0, encryptedData);
            indexOfValue = 0;
          }
        }
      }
    }
    final indexOfZero = data.indexWhere((element) => element.value == 0);

    return [
      data[(indexOfZero + 1000) % data.length].value,
      data[(indexOfZero + 2000) % data.length].value,
      data[(indexOfZero + 3000) % data.length].value,
    ].reduce((value, element) => value + element);
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final testInput = 'lib/day20/test.input_20.txt';
    final realInput = 'lib/day20/input_20.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final data = input
        .split('\n')
        .map((item) => int.tryParse(item))
        .whereType<int>()
        .map((item) => item * 811589153)
        .mapIndexed((i, item) => ArrayElement(value: item, position: i))
        .toList();

    for (int round = 0; round < 10; round += 1) {
      for (int i = 0; i < data.length; i++) {
        int indexOfValue = data.indexWhere((item) => item.position == i);
        final encryptedData = data[indexOfValue];
        int value = data[indexOfValue].value;
        value = value % (data.length - 1);
        if (value < 0) {
          for (int x = 0; x < value.abs(); x++) {
            if (indexOfValue == 0) {
              data.removeAt(indexOfValue);
              data.insert(data.length, encryptedData);
              indexOfValue = data.length - 1;
            }
            data.swap(indexOfValue, indexOfValue - 1);
            indexOfValue -= 1;
            if (indexOfValue == 0) {
              data.removeAt(indexOfValue);
              data.insert(data.length, encryptedData);
              indexOfValue = data.length - 1;
            }
          }
        } else {
          for (int x = 0; x < value.abs(); x++) {
            if (indexOfValue == data.length - 1) {
              data.removeAt(indexOfValue);
              data.insert(0, encryptedData);
              indexOfValue = 0;
            }
            data.swap(indexOfValue, indexOfValue + 1);
            indexOfValue += 1;
            if (indexOfValue == data.length - 1) {
              data.removeAt(indexOfValue);
              data.insert(0, encryptedData);
              indexOfValue = 0;
            }
          }
        }
      }
    }
    final indexOfZero = data.indexWhere((element) => element.value == 0);

    return [
      data[(indexOfZero + 1000) % data.length].value,
      data[(indexOfZero + 2000) % data.length].value,
      data[(indexOfZero + 3000) % data.length].value,
    ].reduce((value, element) => value + element);
  }

  const Day20._();
}

@immutable
class ArrayElement {
  final int value;
  final int position;

  ArrayElement({
    required this.value,
    required this.position,
  });
}
