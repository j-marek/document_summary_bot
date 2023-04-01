import 'package:flutter/material.dart';

import 'package:document_summary_bot/views/uploadPage.dart';
import 'package:document_summary_bot/utils/theme.dart' as theme;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Document Summary Bot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: theme.accentColor),
        useMaterial3: true,
      ),
      home: const UploadPage(),
    );
  }
}
