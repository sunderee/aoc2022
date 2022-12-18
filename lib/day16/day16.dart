import 'dart:math';

import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/let.dart';
import 'package:collection/collection.dart';

class Day16 {
  static Future<int> runPart1({bool useTest = false}) async {
    final testInput = 'lib/day16/test.input_16.txt';
    final realInput = 'lib/day16/input_16.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final List<_Valve> valvesList = [];
    input.split('\n').forEach((item) {
      final id = RegExp(r'(?<=Valve )[A-Z]{2}').stringMatch(item);
      final rate = RegExp(r'(?<=rate=)\d+(?=\;)')
          .stringMatch(item)
          ?.let((it) => int.parse(it));
      final valves = RegExp(r'((?<=valves )[A-Z\, ]+)|((?<=valve )[A-Z]{2})')
          .stringMatch(item)
          ?.let((it) => it.split(', '));

      if (id != null && rate != null && valves != null && valves.isNotEmpty) {
        final valve = _Valve(
          id: id,
          flowRate: rate,
          adjacentValveIDs: valves.toSet(),
        );
        valvesList.add(valve);
      }
    });

    final allValvesMap = valvesList
        .map((item) => MapEntry(item.id, item.adjacentValveIDs))
        .let((it) => Map.fromEntries(it));
    final workingValvesMap = valvesList
        .where((item) => item.flowRate > 0)
        .map((item) => MapEntry(item.id, item.flowRate))
        .let((it) => Map.fromEntries(it));
    final workingValvesMapEnumerated = workingValvesMap.keys
        .mapIndexed((index, element) => MapEntry(element, 1 << index))
        .let((it) => Map.fromEntries(it));

    final valvesConnectionsMap = <String, Map<String, double>>{};
    for (var x in allValvesMap.entries) {
      final connections = allValvesMap[x.key] ?? {};
      final connectionsMap = allValvesMap.keys
          .map((item) => connections.contains(item)
              ? MapEntry(item, 1.0)
              : MapEntry(item, double.infinity))
          .let((it) => Map.fromEntries(it));

      valvesConnectionsMap[x.key] = connectionsMap;
    }
    final postFWValvesConnectionsMap = _floydWarshall(valvesConnectionsMap);

    final result = _runValveComputation(
      'AA',
      30,
      0,
      0,
      {},
      workingValvesMap,
      workingValvesMapEnumerated,
      postFWValvesConnectionsMap,
    );
    return result.values.reduce(max);
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final testInput = 'lib/day16/test.input_16.txt';
    final realInput = 'lib/day16/input_16.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final List<_Valve> valvesList = [];
    input.split('\n').forEach((item) {
      final id = RegExp(r'(?<=Valve )[A-Z]{2}').stringMatch(item);
      final rate = RegExp(r'(?<=rate=)\d+(?=\;)')
          .stringMatch(item)
          ?.let((it) => int.parse(it));
      final valves = RegExp(r'((?<=valves )[A-Z\, ]+)|((?<=valve )[A-Z]{2})')
          .stringMatch(item)
          ?.let((it) => it.split(', '));

      if (id != null && rate != null && valves != null && valves.isNotEmpty) {
        final valve = _Valve(
          id: id,
          flowRate: rate,
          adjacentValveIDs: valves.toSet(),
        );
        valvesList.add(valve);
      }
    });

    final allValvesMap = valvesList
        .map((item) => MapEntry(item.id, item.adjacentValveIDs))
        .let((it) => Map.fromEntries(it));
    final workingValvesMap = valvesList
        .where((item) => item.flowRate > 0)
        .map((item) => MapEntry(item.id, item.flowRate))
        .let((it) => Map.fromEntries(it));
    final workingValvesMapEnumerated = workingValvesMap.keys
        .mapIndexed((index, element) => MapEntry(element, 1 << index))
        .let((it) => Map.fromEntries(it));

    final valvesConnectionsMap = <String, Map<String, double>>{};
    for (var x in allValvesMap.entries) {
      final connections = allValvesMap[x.key] ?? {};
      final connectionsMap = allValvesMap.keys
          .map((item) => connections.contains(item)
              ? MapEntry(item, 1.0)
              : MapEntry(item, double.infinity))
          .let((it) => Map.fromEntries(it));

      valvesConnectionsMap[x.key] = connectionsMap;
    }
    final postFWValvesConnectionsMap = _floydWarshall(valvesConnectionsMap);

    final result = _runValveComputation(
      'AA',
      26,
      0,
      0,
      {},
      workingValvesMap,
      workingValvesMapEnumerated,
      postFWValvesConnectionsMap,
    );

    return result.entries
        .map((item) => result.entries
            .where((innerElement) => !item.key.isBitSet(innerElement.key))
            .map((innerItem) => item.value + innerItem.value)
            .fold<int>(0, max))
        .fold<int>(0, max);
  }

  static Map<String, Map<String, int>> _floydWarshall(
    Map<String, Map<String, double>> input,
  ) {
    final inputCopy = Map.of(input);

    for (var k in inputCopy.keys) {
      for (var i in inputCopy.keys) {
        for (var j in inputCopy.keys) {
          inputCopy[i]![j] = min(
            inputCopy[i]![j]!,
            inputCopy[i]![k]! + inputCopy[k]![j]!,
          );
        }
      }
    }

    return inputCopy.map(
      (key, innerMap) => MapEntry(
        key,
        innerMap.map((innerKey, value) => MapEntry(
              innerKey,
              value.toInt(),
            )),
      ),
    );
  }

  static Map<int, int> _runValveComputation(
    String valveID,
    int time,
    int state,
    int flow,
    Map<int, int> results,
    Map<String, int> workingValvesMap,
    Map<String, int> workingValvesMapEnumerated,
    Map<String, Map<String, int>> valvesConnectionsMap,
  ) {
    results[state] = max(results.putIfAbsent(state, () => 0), flow);
    for (var workingValveID in workingValvesMap.keys) {
      final newTime =
          time - valvesConnectionsMap[valveID]![workingValveID]! - 1;
      if (workingValvesMapEnumerated[workingValveID]! & state > 0 ||
          newTime <= 0) {
        continue;
      }

      _runValveComputation(
        workingValveID,
        newTime,
        state | workingValvesMapEnumerated[workingValveID]!,
        flow + newTime * workingValvesMap[workingValveID]!,
        results,
        workingValvesMap,
        workingValvesMapEnumerated,
        valvesConnectionsMap,
      );
    }

    return results;
  }

  const Day16._();
}

class _Valve {
  final String id;
  final int flowRate;
  final Set<String> adjacentValveIDs;

  _Valve({
    required this.id,
    required this.flowRate,
    required this.adjacentValveIDs,
  });
}

extension _IntExt on int {
  bool isBitSet(int bit) => (this & (1 << bit)) != 0;
}
