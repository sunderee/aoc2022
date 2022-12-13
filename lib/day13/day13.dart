import 'dart:convert';
import 'dart:math';

import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/also.dart';
import 'package:aoc2022dart/common/helpers/tuples.dart';
import 'package:collection/collection.dart';

class Day13 {
  static Future<int> runPart1({bool useTest = false}) async {
    final testInput = 'lib/day13/test.input_13.txt';
    final realInput = 'lib/day13/input_13.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final packetPairs = input
        .split('\n\n')
        .map((item) => item.split('\n'))
        .map((item) => Pair(item.first, item.last))
        .toList();

    final List<Pair<int, _PacketAnalysisResult>> results = [];
    for (var i = 0; i < packetPairs.length; i++) {
      final result = _compareAreInOrder(
        left: jsonDecode(packetPairs[i].first) as List<dynamic>,
        right: jsonDecode(packetPairs[i].second) as List<dynamic>,
      );
      results.add(Pair(i + 1, result));
    }

    return results
        .where((item) => item.second == _PacketAnalysisResult.rightOrder)
        .map((item) => item.first)
        .reduce((value, element) => value + element);
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final testInput = 'lib/day13/test.input_13.txt';
    final realInput = 'lib/day13/input_13.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final allPackets = input
        .split('\n\n')
        .map((item) => item.split('\n'))
        .expand((item) => item)
        .toList()
        .also((it) => it.addAll(['[[2]]', '[[6]]']));

    allPackets.sort(
      (first, second) => _compareAreInOrder(
                  left: jsonDecode(first) as List<dynamic>,
                  right: jsonDecode(second) as List<dynamic>) ==
              _PacketAnalysisResult.rightOrder
          ? -1
          : 1,
    );

    final firstDividerSignalIndex = allPackets.indexOf('[[2]]') + 1;
    final secondDividerSignalIndex = allPackets.indexOf('[[6]]') + 1;

    return firstDividerSignalIndex * secondDividerSignalIndex;
  }

  static _PacketAnalysisResult _compareAreInOrder({
    required dynamic left,
    required dynamic right,
  }) {
    if (left is int && right is int) {
      if (left < right) {
        return _PacketAnalysisResult.rightOrder;
      } else if (left > right) {
        return _PacketAnalysisResult.wrongOrder;
      } else {
        return _PacketAnalysisResult.continueNext;
      }
    } else if (left is List<dynamic> && right is List<dynamic>) {
      final maxLength = max(left.length, right.length);
      final leftArray = _padArray(left, maxLength);
      final rightArray = _padArray(right, maxLength);

      final answers = leftArray
          .mapIndexed((index, item) => _compareAreInOrder(
                left: item,
                right: rightArray[index],
              ))
          .toList();

      final firstGood = answers.indexOf(_PacketAnalysisResult.rightOrder);
      final firstBad = answers.indexOf(_PacketAnalysisResult.wrongOrder);
      if (firstGood != -1 && firstBad != -1) {
        return firstGood < firstBad
            ? _PacketAnalysisResult.rightOrder
            : _PacketAnalysisResult.wrongOrder;
      }

      if (firstGood != -1) {
        return _PacketAnalysisResult.rightOrder;
      }

      if (firstBad != -1) {
        return _PacketAnalysisResult.wrongOrder;
      }

      return _PacketAnalysisResult.continueNext;
    } else {
      if (left is int) {
        if (left == -1) {
          return _PacketAnalysisResult.rightOrder;
        }
        return _compareAreInOrder(left: [left], right: right);
      } else if (right is int) {
        if (right == -1) {
          return _PacketAnalysisResult.wrongOrder;
        }
        return _compareAreInOrder(left: left, right: [right]);
      }
    }

    return _PacketAnalysisResult.continueNext;
  }

  static List<dynamic> _padArray(List<dynamic> array, int length) => [
        ...array,
        ...List.filled(max(array.length, length) - array.length, -1),
      ];

  const Day13._();
}

enum _PacketAnalysisResult { continueNext, rightOrder, wrongOrder }
