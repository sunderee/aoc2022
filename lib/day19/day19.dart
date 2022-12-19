import 'dart:math';

import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/let.dart';
import 'package:aoc2022dart/common/helpers/tuples.dart';

/// This day's solution is heavily inspired by work from Oscar Molnar.
class Day19 {
  static Future<int> runPart1({bool useTest = false}) async {
    final testInput = 'lib/day19/test.input_19.txt';
    final realInput = 'lib/day19/input_19.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final Map<String, int> robots = {'ore': 1, 'clay': 0, 'obsidian': 0};
    final Map<String, int> materials = {
      'ore': 1,
      'clay': 0,
      'obsidian': 0,
      'geode': 0,
    };

    final blueprintsList = input.split('\n').map((item) {
      final blueprintID = RegExp(r'(?<=Blueprint )\d{1,2}')
          .stringMatch(item)
          ?.let((it) => int.tryParse(it));
      final oreRobotCost = RegExp(r'(?<=ore robot costs )\d')
          .stringMatch(item)
          ?.let((it) => int.tryParse(it));
      final clayRobotCost = RegExp(r'(?<=clay robot costs )\d')
          .stringMatch(item)
          ?.let((it) => int.tryParse(it));
      final obsidianRobotCosts = [
        RegExp(r'(?<=obsidian robot costs )\d').stringMatch(item),
        RegExp(r'(?<=and )\d{1,2}(?= clay)').stringMatch(item)
      ]
          .whereType<String>()
          .map((item) => item.let((it) => int.tryParse(it)))
          .whereType<int>()
          .let((it) => Pair(it.first, it.last));
      final geodeRobotCosts = [
        RegExp(r'(?<=geode robot costs )\d').stringMatch(item),
        RegExp(r'(?<=and )\d{1,2}(?= obsidian)').stringMatch(item)
      ]
          .whereType<String>()
          .map((item) => item.let((it) => int.tryParse(it)))
          .whereType<int>()
          .let((it) => Pair(it.first, it.last));

      return blueprintID != null &&
              oreRobotCost != null &&
              clayRobotCost != null
          ? _Blueprint(
              blueprintID: blueprintID,
              oreRobotCost: oreRobotCost,
              clayRobotCost: clayRobotCost,
              obsidianRobotCosts: obsidianRobotCosts,
              geodeRobotCosts: geodeRobotCosts,
            )
          : null;
    }).whereType<_Blueprint>();

    return blueprintsList
        .map((item) =>
            item.blueprintID *
            _getMaxAmountOfProducedGeodes(
              timeLeft: 24,
              currentMaxGeodesProduced: 0,
              robots: robots,
              materials: materials,
              blueprint: item,
            ))
        .reduce((value, element) => value + element);
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final testInput = 'lib/day19/test.input_19.txt';
    final realInput = 'lib/day19/input_19.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    final Map<String, int> robots = {'ore': 1, 'clay': 0, 'obsidian': 0};
    final Map<String, int> materials = {
      'ore': 1,
      'clay': 0,
      'obsidian': 0,
      'geode': 0,
    };

    final blueprintsList = input
        .split('\n')
        .map((item) {
          final blueprintID = RegExp(r'(?<=Blueprint )\d{1,2}')
              .stringMatch(item)
              ?.let((it) => int.tryParse(it));
          final oreRobotCost = RegExp(r'(?<=ore robot costs )\d')
              .stringMatch(item)
              ?.let((it) => int.tryParse(it));
          final clayRobotCost = RegExp(r'(?<=clay robot costs )\d')
              .stringMatch(item)
              ?.let((it) => int.tryParse(it));
          final obsidianRobotCosts = [
            RegExp(r'(?<=obsidian robot costs )\d').stringMatch(item),
            RegExp(r'(?<=and )\d{1,2}(?= clay)').stringMatch(item)
          ]
              .whereType<String>()
              .map((item) => item.let((it) => int.tryParse(it)))
              .whereType<int>()
              .let((it) => Pair(it.first, it.last));
          final geodeRobotCosts = [
            RegExp(r'(?<=geode robot costs )\d').stringMatch(item),
            RegExp(r'(?<=and )\d{1,2}(?= obsidian)').stringMatch(item)
          ]
              .whereType<String>()
              .map((item) => item.let((it) => int.tryParse(it)))
              .whereType<int>()
              .let((it) => Pair(it.first, it.last));

          return blueprintID != null &&
                  oreRobotCost != null &&
                  clayRobotCost != null
              ? _Blueprint(
                  blueprintID: blueprintID,
                  oreRobotCost: oreRobotCost,
                  clayRobotCost: clayRobotCost,
                  obsidianRobotCosts: obsidianRobotCosts,
                  geodeRobotCosts: geodeRobotCosts,
                )
              : null;
        })
        .whereType<_Blueprint>()
        .toList()
        .sublist(0, useTest ? 2 : 3);

    return blueprintsList
        .map((item) => _getMaxAmountOfProducedGeodes(
            timeLeft: 32,
            currentMaxGeodesProduced: 0,
            robots: robots,
            materials: materials,
            blueprint: item))
        .reduce((value, element) => value * element);
  }

  static int _getMaxAmountOfProducedGeodes({
    required int timeLeft,
    required int currentMaxGeodesProduced,
    required Map<String, int> robots,
    required Map<String, int> materials,
    required _Blueprint blueprint,
  }) {
    if (timeLeft == 0) {
      return currentMaxGeodesProduced;
    }

    final maxGeodesProduced = max(
      materials['geode']!,
      currentMaxGeodesProduced,
    );
    currentMaxGeodesProduced = maxGeodesProduced;

    final maxOresNeeded = [
      blueprint.oreRobotCost,
      blueprint.clayRobotCost,
      blueprint.obsidianRobotCosts.first,
      blueprint.geodeRobotCosts.first
    ].reduce(max);

    if (robots['obsidian']! > 0) {
      final canGeodeRobotBeBuilt =
          blueprint.geodeRobotCosts.first <= materials['ore']! &&
              blueprint.geodeRobotCosts.second <= materials['obsidian']!;

      final timeToHavingEnoughResources = max(
              ((blueprint.geodeRobotCosts.first - materials['ore']!) /
                      robots['ore']!)
                  .ceil(),
              ((blueprint.geodeRobotCosts.second - materials['obsidian']!) /
                  robots['obsidian']!))
          .toInt();

      final time = (canGeodeRobotBeBuilt ? 0 : timeToHavingEnoughResources) + 1;

      materials['ore'] = materials['ore']! +
          time * robots['ore']! -
          blueprint.geodeRobotCosts.first;
      materials['clay'] = materials['clay']! + time * robots['clay']!;
      materials['obsidian'] = materials['obsidian']! +
          time * robots['obsidian']! -
          blueprint.geodeRobotCosts.second;
      materials['geode'] = materials['geode']! + (timeLeft - time);

      final maxProduced = max(
        _getMaxAmountOfProducedGeodes(
          timeLeft: timeLeft - time,
          currentMaxGeodesProduced: currentMaxGeodesProduced,
          robots: robots,
          materials: materials,
          blueprint: blueprint,
        ),
        currentMaxGeodesProduced,
      );
      currentMaxGeodesProduced = maxProduced;

      if (canGeodeRobotBeBuilt) {
        return currentMaxGeodesProduced;
      }
    }

    if (robots['clay']! > 0) {
      final canObsidianRobotBeBuilt =
          blueprint.obsidianRobotCosts.first <= materials['ore']! &&
              blueprint.obsidianRobotCosts.second <= materials['clay']!;

      final timeToHavingEnoughResources = max(
              ((blueprint.obsidianRobotCosts.first - materials['ore']!) /
                      robots['ore']!)
                  .ceil(),
              ((blueprint.obsidianRobotCosts.second - materials['clay']!) /
                  robots['clay']!))
          .toInt();

      final time =
          (canObsidianRobotBeBuilt ? 0 : timeToHavingEnoughResources) + 1;

      if (timeLeft - time > 2) {
        robots['obsidian'] = robots['obsidian']! + 1;

        materials['ore'] = materials['ore']! +
            time * robots['ore']! -
            blueprint.obsidianRobotCosts.first;
        materials['clay'] = materials['clay']! +
            time * robots['clay']! -
            blueprint.obsidianRobotCosts.second;
        materials['obsidian'] =
            materials['obsidian']! + time * robots['obsidian']!;

        final maxProduced = max(
          _getMaxAmountOfProducedGeodes(
            timeLeft: timeLeft - time,
            currentMaxGeodesProduced: currentMaxGeodesProduced,
            robots: robots,
            materials: materials,
            blueprint: blueprint,
          ),
          currentMaxGeodesProduced,
        );
        currentMaxGeodesProduced = maxProduced;
      }
    }

    if (robots['clay']! < blueprint.obsidianRobotCosts.second) {
      final canClayRobotBeBuilt = blueprint.clayRobotCost <= materials['ore']!;
      final timeUntilEnoughOre =
          ((blueprint.clayRobotCost - materials['ore']!) / robots['ore']!)
              .ceil();
      final time = (canClayRobotBeBuilt ? 0 : timeUntilEnoughOre) + 1;

      if (timeLeft - time > 3) {
        robots['clay'] = robots['clay']! + 1;

        materials['ore'] =
            materials['ore']! + time * robots['ore']! - blueprint.clayRobotCost;
        materials['clay'] = materials['clay']! + time * robots['clay']!;
        materials['obsidian'] =
            materials['obsidian']! + time * robots['obsidian']!;

        final maxProduced = max(
          _getMaxAmountOfProducedGeodes(
            timeLeft: timeLeft - time,
            currentMaxGeodesProduced: currentMaxGeodesProduced,
            robots: robots,
            materials: materials,
            blueprint: blueprint,
          ),
          currentMaxGeodesProduced,
        );
        currentMaxGeodesProduced = maxProduced;
      }
    }

    if (robots['ore']! < maxOresNeeded) {
      final canOreRobotBeBuilt = blueprint.oreRobotCost <= materials['ore']!;
      final timeUntilEnoughOre =
          ((blueprint.oreRobotCost - materials['ore']!) / robots['ore']!)
              .ceil();
      final time = (canOreRobotBeBuilt ? 0 : timeUntilEnoughOre) + 1;

      if (timeLeft - time > 4) {
        robots['ore'] = robots['ore']! + 1;

        materials['ore'] =
            materials['ore']! + time * robots['ore']! - blueprint.oreRobotCost;
        materials['clay'] = materials['clay']! + time * robots['clay']!;
        materials['obsidian'] =
            materials['obsidian']! + time * robots['obsidian']!;

        currentMaxGeodesProduced = max(
          _getMaxAmountOfProducedGeodes(
            timeLeft: timeLeft - time,
            currentMaxGeodesProduced: currentMaxGeodesProduced,
            robots: robots,
            materials: materials,
            blueprint: blueprint,
          ),
          currentMaxGeodesProduced,
        );
      }
    }

    return currentMaxGeodesProduced;
  }

  const Day19._();
}

class _Blueprint {
  final int blueprintID;
  final int oreRobotCost;
  final int clayRobotCost;
  final Pair<int, int> obsidianRobotCosts;
  final Pair<int, int> geodeRobotCosts;

  _Blueprint({
    required this.blueprintID,
    required this.oreRobotCost,
    required this.clayRobotCost,
    required this.obsidianRobotCosts,
    required this.geodeRobotCosts,
  });
}
