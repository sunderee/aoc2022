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
              robots: _Robots(),
              materials: _Materials(),
              blueprint: item,
            ))
        .reduce((value, element) => value + element);
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final testInput = 'lib/day19/test.input_19.txt';
    final realInput = 'lib/day19/input_19.txt';
    final input = await readTXT(useTest ? testInput : realInput);

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
        .map(
          (item) => _getMaxAmountOfProducedGeodes(
              timeLeft: 32,
              currentMaxGeodesProduced: 0,
              robots: _Robots(),
              materials: _Materials(),
              blueprint: item),
        )
        .fold<int>(1, (previousValue, element) => previousValue * element);
  }

  static int _getMaxAmountOfProducedGeodes({
    required int timeLeft,
    required int currentMaxGeodesProduced,
    required _Robots robots,
    required _Materials materials,
    required _Blueprint blueprint,
  }) {
    if (timeLeft <= 0) {
      return currentMaxGeodesProduced;
    }

    final maxGeodesProduced = max(
      materials.geodeCount,
      currentMaxGeodesProduced,
    );
    currentMaxGeodesProduced = maxGeodesProduced;

    final maxOresNeeded = [
      blueprint.oreRobotCost,
      blueprint.clayRobotCost,
      blueprint.obsidianRobotCosts.first,
      blueprint.geodeRobotCosts.first
    ].reduce(max);

    if (robots.obsidianCollectingRobotsCount > 0) {
      final canGeodeRobotBeBuilt =
          blueprint.geodeRobotCosts.first <= materials.oreCount &&
              blueprint.geodeRobotCosts.second <= materials.obsidianCount;

      final timeToHavingEnoughResources = max(
              ((blueprint.geodeRobotCosts.first - materials.oreCount) /
                      robots.oreCollectingRobotsCount)
                  .ceil(),
              ((blueprint.geodeRobotCosts.second - materials.obsidianCount) /
                  robots.obsidianCollectingRobotsCount))
          .toInt();

      final time = (canGeodeRobotBeBuilt ? 0 : timeToHavingEnoughResources) + 1;

      materials
        ..oreCount = materials.oreCount +
            time * robots.oreCollectingRobotsCount -
            blueprint.geodeRobotCosts.first
        ..clayCount =
            materials.clayCount + time * robots.clayCollectingRobotsCount
        ..obsidianCount = materials.obsidianCount +
            time * robots.obsidianCollectingRobotsCount -
            blueprint.geodeRobotCosts.second
        ..geodeCount = materials.geodeCount + (timeLeft - time);

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

    if (robots.clayCollectingRobotsCount > 0) {
      final canObsidianRobotBeBuilt =
          blueprint.obsidianRobotCosts.first <= materials.oreCount &&
              blueprint.obsidianRobotCosts.second <= materials.clayCount;

      final timeToHavingEnoughResources = max(
              ((blueprint.obsidianRobotCosts.first - materials.oreCount) /
                      robots.oreCollectingRobotsCount)
                  .ceil(),
              ((blueprint.obsidianRobotCosts.second - materials.clayCount) /
                  robots.clayCollectingRobotsCount))
          .toInt();

      final time =
          (canObsidianRobotBeBuilt ? 0 : timeToHavingEnoughResources) + 1;

      if (timeLeft - time > 2) {
        robots.obsidianCollectingRobotsCount =
            robots.obsidianCollectingRobotsCount + 1;

        materials
          ..oreCount = materials.oreCount +
              time * robots.oreCollectingRobotsCount -
              blueprint.obsidianRobotCosts.first
          ..clayCount = materials.clayCount +
              time * robots.clayCollectingRobotsCount -
              blueprint.obsidianRobotCosts.second
          ..obsidianCount = materials.obsidianCount +
              time * robots.obsidianCollectingRobotsCount;

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

    if (robots.clayCollectingRobotsCount <
        blueprint.obsidianRobotCosts.second) {
      final canClayRobotBeBuilt = blueprint.clayRobotCost <= materials.oreCount;
      final timeUntilEnoughOre =
          ((blueprint.clayRobotCost - materials.oreCount) /
                  robots.oreCollectingRobotsCount)
              .ceil();
      final time = (canClayRobotBeBuilt ? 0 : timeUntilEnoughOre) + 1;

      if (timeLeft - time > 3) {
        robots.clayCollectingRobotsCount = robots.clayCollectingRobotsCount + 1;

        materials
          ..oreCount = materials.oreCount +
              time * robots.oreCollectingRobotsCount -
              blueprint.clayRobotCost
          ..clayCount =
              materials.clayCount + time * robots.clayCollectingRobotsCount
          ..obsidianCount = materials.obsidianCount +
              time * robots.obsidianCollectingRobotsCount;

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

    if (robots.oreCollectingRobotsCount < maxOresNeeded) {
      final canOreRobotBeBuilt = blueprint.oreRobotCost <= materials.oreCount;
      final timeUntilEnoughOre =
          ((blueprint.oreRobotCost - materials.oreCount) /
                  robots.oreCollectingRobotsCount)
              .ceil();
      final time = (canOreRobotBeBuilt ? 0 : timeUntilEnoughOre) + 1;

      if (timeLeft - time > 4) {
        robots.oreCollectingRobotsCount = robots.oreCollectingRobotsCount + 1;

        materials
          ..oreCount = materials.oreCount +
              time * robots.oreCollectingRobotsCount -
              blueprint.oreRobotCost
          ..clayCount =
              materials.clayCount + time * robots.clayCollectingRobotsCount
          ..obsidianCount = materials.obsidianCount +
              time * robots.obsidianCollectingRobotsCount;

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

final Map<String, int> robots = {
  'ore': 1,
  'clay': 0,
  'obsidian': 0,
};

final Map<String, int> materials = {
  'ore': 1,
  'clay': 0,
  'obsidian': 0,
  'geode': 0,
};

class _Robots {
  int oreCollectingRobotsCount = 1;
  int clayCollectingRobotsCount = 0;
  int obsidianCollectingRobotsCount = 0;

  _Robots()
      : oreCollectingRobotsCount = 1,
        clayCollectingRobotsCount = 0,
        obsidianCollectingRobotsCount = 0;
}

class _Materials {
  int oreCount = 0;
  int clayCount = 0;
  int obsidianCount = 0;
  int geodeCount = 0;

  _Materials()
      : oreCount = 0,
        clayCount = 0,
        obsidianCount = 0,
        geodeCount = 0;
}
