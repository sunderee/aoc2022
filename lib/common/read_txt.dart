import 'dart:io';

import 'package:path/path.dart';

Future<String> readTXT(String relativePath) async {
  final filePath = join(Directory.current.path, relativePath);
  final file = File(filePath);

  return file.readAsString();
}
