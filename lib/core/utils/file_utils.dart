import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_template/core/utils/string_extensions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

Future<File> downloadFile(String url) async {
  Uuid uuid = const Uuid();
  Dio dio = Dio();

  String fileName = url.fileName;
  Directory directory = await getTemporaryDirectory();
  String directoryPath = "${directory.path}/${uuid.v1()}/$fileName";

  await dio.download(url, directoryPath);

  File file = File(directoryPath);
  return file;
}
