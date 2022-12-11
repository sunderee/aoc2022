import 'package:aoc2022dart/common/data_structures/nary_tree/node.dart';
import 'package:aoc2022dart/common/data_structures/nary_tree/tree.dart';
import 'package:aoc2022dart/common/helpers/read_txt.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/also.dart';
import 'package:aoc2022dart/common/helpers/scope_functions/let.dart';

class Day7 {
  static Future<int?> runPart1({bool useTest = false}) async {
    final file = useTest ? 'lib/day7/test.input_7.txt' : 'lib/day7/input_7.txt';
    final input = await readTXT(file);

    final fileSystem = _fileSystemBuilder(input.split('\n').sublist(1));
    return fileSystem.rootNode
        ?.let((it) => fileSystem.inOrderTraversal(it))
        .map((item) {
          if (item.data.isDirectory) {
            final size = _calculateDirectorySize(item);
            return _FileSystemObject(
              name: item.data.name,
              isDirectory: true,
              size: size,
            );
          } else {
            return _FileSystemObject(
              name: item.data.name,
              isDirectory: false,
              size: item.data.fileSize ?? 0,
            );
          }
        })
        .where((item) => item.isDirectory)
        .where((item) => item.size <= 100000)
        .map((item) => item.size)
        .reduce((value, element) => value + element);
  }

  static Future<int?> runPart2({bool useTest = false}) async {
    final file = useTest ? 'lib/day7/test.input_7.txt' : 'lib/day7/input_7.txt';
    final input = await readTXT(file);

    final fileSystem = _fileSystemBuilder(input.split('\n').sublist(1));
    final directories = fileSystem.rootNode
        ?.let((it) => fileSystem.inOrderTraversal(it))
        .map((item) => item.data.isDirectory
            ? _FileSystemObject(
                name: item.data.name,
                isDirectory: true,
                size: _calculateDirectorySize(item),
              )
            : _FileSystemObject(
                name: item.data.name,
                isDirectory: false,
                size: item.data.fileSize ?? 0,
              ))
        .where((item) => item.isDirectory);

    const totalFileSystemSize = 70000000;
    const updateSize = 30000000;
    final freeSpace = directories
            ?.firstWhere((item) => item.name == '/')
            .size
            .let((it) => totalFileSystemSize - it) ??
        0;

    return directories
        ?.where((item) => item.size > updateSize - freeSpace)
        .toList()
        .also((it) => it.sort((a, b) => a.size.compareTo(b.size)))
        .first
        .size;
  }

  static Tree<_FileObject> _fileSystemBuilder(List<String> lines) {
    final rootDirectory = Node<_FileObject>(
      data: _FileObject(
        name: '/',
        isDirectory: true,
      ),
    );

    final tree = Tree<_FileObject>(root: rootDirectory);
    Node<_FileObject> currentWorkingDirectory = rootDirectory;

    for (var line in lines) {
      if (line.startsWith(r'$')) {
        if (line.contains('cd')) {
          if (line.contains('/')) {
            currentWorkingDirectory = rootDirectory;
            continue;
          } else if (line.contains('..')) {
            currentWorkingDirectory.parent?.let(
              (it) => currentWorkingDirectory = it,
            );
            continue;
          } else {
            currentWorkingDirectory = currentWorkingDirectory.children
                .firstWhere((item) =>
                    item.data.name == RegExp(r'(?<=cd )\w+').stringMatch(line));
          }
        }
      } else {
        if (line.startsWith('dir')) {
          currentWorkingDirectory.addChild(
            Node(
              data: _FileObject(
                name: RegExp(r'(?<=dir\s)\w+').stringMatch(line) ?? '',
                isDirectory: true,
              ),
            ),
          );
        } else {
          currentWorkingDirectory.addChild(
            Node(
              data: _FileObject(
                name: RegExp(r'(?<=\d )[a-z0-9\.]+', caseSensitive: false)
                        .stringMatch(line) ??
                    '',
                isDirectory: false,
                fileSize: RegExp(r'\d+')
                    .stringMatch(line)
                    ?.let((it) => int.parse(it)),
              ),
            ),
          );
        }
      }
    }

    return tree;
  }

  static int _calculateDirectorySize(Node<_FileObject> node) {
    int size = 0;
    for (var item in node.children) {
      if (!item.data.isDirectory && item.data.fileSize != null) {
        size += item.data.fileSize!;
      } else if (item.data.isDirectory) {
        size += _calculateDirectorySize(item);
      }
    }

    return size;
  }

  const Day7._();
}

class _FileObject {
  final String name;
  final bool isDirectory;
  final int? fileSize;

  const _FileObject({
    required this.name,
    required this.isDirectory,
    this.fileSize,
  });
}

class _FileSystemObject {
  final String name;
  final bool isDirectory;
  final int size;

  const _FileSystemObject({
    required this.name,
    required this.isDirectory,
    required this.size,
  });
}
