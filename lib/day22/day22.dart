import 'dart:math';

import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/let.dart';
import 'package:equatable/equatable.dart';
import 'package:more/more.dart';

/// This day's solution is heavily inspired by work from an unknown Redditor.
class Day22 {
  static final headings = [
    Point(0, -1),
    Point(1, 0),
    Point(0, 1),
    Point(-1, 0)
  ];
  static final arrows = ['^', '>', 'v', '<'];

  static final transforms = {
    'S': {0: Tf('T', 0), 1: Tf('E', 0), 2: Tf('B', 0), 3: Tf('W', 0)},
    'E': {0: Tf('T', 1), 1: Tf('N', 0), 2: Tf('B', 3), 3: Tf('S', 0)},
    'N': {0: Tf('T', 2), 1: Tf('W', 0), 2: Tf('B', 2), 3: Tf('E', 0)},
    'W': {0: Tf('T', 3), 1: Tf('S', 0), 2: Tf('B', 1), 3: Tf('N', 0)},
    'B': {0: Tf('S', 0), 1: Tf('E', 1), 2: Tf('N', 2), 3: Tf('W', 3)},
    'T': {0: Tf('N', 2), 1: Tf('E', 3), 2: Tf('S', 0), 3: Tf('W', 1)},
  };

  static Future<int> runPart1({bool useTest = false}) async {
    final testInput = 'lib/day22/test.input_22.txt';
    final realInput = 'lib/day22/input_22.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    var lines = input.split('\n');
    var navRules = lines.last;
    lines = lines.let((it) => it.sublist(0, it.length - 2));

    final width = lines.map((e) => e.length).max();
    final height = lines.length;
    final grid = lines.map((e) => e.padRight(width).split('')).toList();

    var pos = Point(lines[0].indexOf('.'), 0);
    var heading = 1;

    navRules = navRules.replaceAll('R', ' R ').replaceAll('L', ' L ');
    var nr = navRules.split(' ');
    for (var r in nr) {
      if (r == 'L' || r == 'R') {
        heading = (heading + ((r == 'R') ? 1 : -1)) % headings.length;
        continue;
      }
      var step = int.parse(r);

      while (step > 0) {
        var np = pos + headings[heading];
        np = Point(np.x % width, np.y % height);
        while (grid[np.y][np.x] == ' ') {
          np = np + headings[heading];
          np = Point(np.x % width, np.y % height);
        }

        if (grid[np.y][np.x] == '#') {
          break;
        }
        grid[pos.y][pos.x] = arrows[heading];
        pos = np;
        step -= 1;
      }
    }
    return 1000 * (pos.y + 1) + 4 * (pos.x + 1) + (heading - 1);
  }

  static Future<int> runPart2({bool useTest = false}) async {
    final testInput = 'lib/day22/test.input_22.txt';
    final realInput = 'lib/day22/input_22.txt';
    final input = await readTXT(useTest ? testInput : realInput);

    var lines = input.split('\n');
    var navRules = lines.last;
    lines = lines.let((it) => it.sublist(0, it.length - 2));

    final width = lines.map((e) => e.length).max();
    final height = lines.length;
    final grid = lines.map((e) => e.padRight(width).split('')).toList();

    var faceSize = (width > height) ? width ~/ 4 : width ~/ 3;

    var x = [grid.first.indexOf('.'), grid.first.indexOf('#')].min();
    Map<String, Face> faces = _buildFaces(x, faceSize, width, height, grid);

    var face = faces['T']!;
    var pos = Point(x, 0);
    var heading = 1;

    navRules = navRules.replaceAll('R', ' R ').replaceAll('L', ' L ');
    var nr = navRules.split(' ');
    for (var r in nr) {
      if (r == 'L' || r == 'R') {
        heading = (heading + ((r == 'R') ? 1 : -1)) % headings.length;
        continue;
      }

      var step = int.parse(r);

      while (step > 0) {
        var np = pos + headings[heading];

        if (np.x < face.origin.x ||
            np.x >= face.origin.x + faceSize ||
            np.y < face.origin.y ||
            np.y >= face.origin.y + faceSize) {
          var tf = transforms[face.name]![(heading - face.orientation) % 4]!;
          var nf = faces[tf.name]!;

          var tnp = Point(np.x % faceSize, np.y % faceSize);
          var relOrient = (nf.orientation - face.orientation - tf.rotation) % 4;
          var theading = (heading + relOrient) % 4;
          if (relOrient == 0) {
          } else if (relOrient == 1) {
            tnp = Point(faceSize - 1 - tnp.y, tnp.x);
          } else if (relOrient == 2) {
            tnp = Point(faceSize - 1 - tnp.x, faceSize - 1 - tnp.y);
          } else if (relOrient == 3) {
            tnp = Point(tnp.y, faceSize - 1 - tnp.x);
          }

          tnp = tnp + nf.origin;

          if (grid[tnp.y][tnp.x] == '#') break;

          face = faces[tf.name]!;
          np = tnp;
          heading = theading;
        }

        if (grid[np.y][np.x] == '#') break;

        grid[pos.y][pos.x] = arrows[heading];
        pos = np;
        step -= 1;
      }
    }

    return 1000 * (pos.y + 1) + 4 * (pos.x + 1) + ((heading - 1) % 4);
  }

  static Map<String, Face> _buildFaces(
    int x,
    int faceSize,
    int width,
    int height,
    List<List<String>> grid,
  ) {
    var queue = [Face('T', 0, Point(x, 0))];
    var faces = <String, Face>{};
    var dirs = [Point(0, -1), Point(1, 0), Point(0, 1), Point(-1, 0)];
    while (queue.isNotEmpty) {
      var face = queue.removeAt(0);
      if (faces.containsKey(face.name)) continue;
      faces[face.name] = face;
      for (var n in [1, 2, 3]) {
        var d = face.origin + dirs[n] * faceSize;
        if (d.x < 0 || d.x + faceSize > width || d.y + faceSize > height) {
          continue;
        }
        if (grid[d.y][d.x] != ' ') {
          var nextFace = transforms[face.name]![(n - face.orientation) % 4]!;
          var nextName = nextFace.name;
          var nextOrient = (nextFace.rotation + face.orientation) % 4;
          var nextOrigin = d;
          queue.add(Face(nextName, nextOrient, nextOrigin));
        }
      }
    }
    return faces;
  }

  const Day22._();
}

class Face extends Equatable {
  final String name;
  final int orientation;
  final Point<int> origin;

  @override
  List<Object?> get props => [name, orientation, origin];

  Face(this.name, this.orientation, this.origin);
}

class Tf {
  final String name;
  final int rotation;

  Tf(this.name, this.rotation);
}
