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
          _header(context),
          const UploadCard(),
        ],
      ),
    );
  }


  Widget _header(BuildContext context) => Container(
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
        ),
        const Spacer(),
        IconButton(
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context),
          ),
          icon: const Icon(
            Icons.info,
            color: theme.bgPrimaryColor,
            size: 24.0,
          ),
        ),
      ],
    ),
  );


  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: theme.borderRadius,
      ),
      backgroundColor: Colors.white,
      title: const Text(
        "About",
        style: TextStyle(
          color: theme.textColor,
          fontSize: 24.0,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          SelectionArea(
            child: Text(
              "This app is designed to make it easy to generate explanations and abstracts for legal documents and agreements.\nThe app is meant for internal use only in PwC.\n\nIf you have any questions or feedback, please feel free to reach out to viktor.jamrich@pwc.com",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "Close",
            style: TextStyle(
              color: theme.textColor,
            ),
          ),
        ),
      ],
    );
  }
}
