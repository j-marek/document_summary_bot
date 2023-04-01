import 'package:document_summary_bot/net/summarize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'package:document_summary_bot/widgets/dropZone/dropZoneWidget.dart';
import 'package:document_summary_bot/widgets/dropZone/model/fileDataModel.dart';
import 'package:document_summary_bot/utils/theme.dart' as theme;


class UploadCard extends StatefulWidget {

  const UploadCard({
    Key? key
  }) : super(key: key);

  @override
  State<UploadCard> createState() => _UploadCardState();
}


class _UploadCardState extends State<UploadCard> {

  String? inputText;
  String type = "Summarize";
  String style = "Professional";


  Widget _type() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    decoration: BoxDecoration(
      color: theme.greyColor,
      borderRadius: theme.borderRadius,
    ),
    child: DropdownButton(
      value: type,
      dropdownColor: theme.bgPrimaryColor,
      underline: const SizedBox(),
      isExpanded: true,
      items: <String>["Summarize", "Abstract"].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        if(value != null) {
          setState(() {
            type = value;
          });
        }
      },
    ),
  );


  Widget _style() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    decoration: BoxDecoration(
      color: theme.greyColor,
      borderRadius: theme.borderRadius,
    ),
    child: DropdownButton(
      value: style,
      dropdownColor: theme.bgPrimaryColor,
      underline: const SizedBox(),
      isExpanded: true,
      items: <String>["Professional", "Plain", "Simple"].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        if(value != null) {
          setState(() {
            style = value;
          });
        }
      },
    ),
  );


  bool isLoading = false;
  Widget _button() => Material(
    color: Colors.transparent,
    child: Ink(
      height: 48.0,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: theme.accentColor,
        borderRadius: theme.borderRadius,
      ),
      child: InkWell(
        borderRadius: theme.borderRadius,
        splashColor: theme.bgPrimaryColor.withOpacity(0.1),
        hoverColor: theme.bgPrimaryColor.withOpacity(0.05),
        onTap: () async {
          if(inputText != null) {
            setState(() {
              isLoading = true;
            });

            final String output = await summarize(inputText: inputText!, type: type, style: style);
            if(mounted) {
              showDialog(
                context: context,
                builder: (BuildContext context) => _buildPopupDialog(context, output),
              );
            }

            setState(() {
              isLoading = false;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "No file uploaded",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: theme.bgPrimaryColor,
                  ),
                ),
              ),
            );
          }
        },
        child: Center(
          child: !isLoading ? const Text(
            "Generate",
            style: TextStyle(
              color: theme.bgPrimaryColor,
              fontSize: 24.0,
            ),
          ) : const SpinKitThreeBounce(
            size: 24.0,
            color: theme.bgPrimaryColor,
          ),
        ),
      ),
    ),
  );


  Widget _buildPopupDialog(BuildContext context, String text) {
    return AlertDialog(
      backgroundColor: theme.bgPrimaryColor,
      title: const Text(
        "Summary",
        style: TextStyle(
          color: theme.textColor,
          fontSize: 24.0,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SelectionArea(
            child: Text(
              text,
              style: const TextStyle(
                color: theme.textColor,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: text));
            if(mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Output copied to clipboard",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              );
            }
          },
          child: const Text(
            "Copy",
            style: TextStyle(
              color: theme.textColor,
            ),
          ),
        ),
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


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 500.0,
        margin: const EdgeInsets.all(48.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: theme.bgPrimaryColor,
          border: Border.all(
            color: theme.greyColor,
            width: 1.0,
          ),
          borderRadius: theme.borderRadius,
        ),
        child: Column(
          // shrinkWrap: true,
          // scrollDirection: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text("Type"),
            _type(),
            const SizedBox(height: 12.0),

            const Text("Style"),
            _style(),
            const SizedBox(height: 12.0),

            Expanded(
              child: DropZoneWidget(
                onDroppedFile: (FileDataModel file) {
                  final PdfDocument document = PdfDocument(inputBytes: file.data);
                  final String text = PdfTextExtractor(document).extractText();
                  document.dispose();

                  inputText = text;
                },
              ),
            ),
            const SizedBox(height: 12.0),

            _button(),
          ],
        ),
      ),
    );
  }
}
