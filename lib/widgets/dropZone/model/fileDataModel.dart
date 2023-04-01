import 'package:flutter/services.dart';

class FileDataModel{

  final String name;
  final String mime;
  final int getSize;
  final String url;
  final Uint8List data;

  FileDataModel({
    required this.name,
    required this.mime,
    required this.getSize,
    required this.url,
    required this.data,
  });

  String size() {
    final kb = getSize / 1024;
    final mb = kb / 1024;

    return mb > 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
  }
}
