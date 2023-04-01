import 'package:flutter/material.dart';

import 'package:document_summary_bot/widgets/uploadCard.dart';
import 'package:document_summary_bot/utils/theme.dart' as theme;


class UploadPage extends StatelessWidget {

  const UploadPage({
    Key? key
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.bgSecondaryColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _header(),
          const UploadCard(),
        ],
      ),
    );
  }


  Widget _header() => Container(
    height: 64.0,
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: theme.accentColor,
      boxShadow: theme.shadow,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset("assets/pwc_logo.png"),
        const SizedBox(width: 12.0),
        const Text(
          "Document Summary Bot",
          style: TextStyle(
            color: theme.bgPrimaryColor,
            fontSize: 20.0,
          ),
        )
      ],
    ),
  );
}
