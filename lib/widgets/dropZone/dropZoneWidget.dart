import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:document_summary_bot/widgets/dropZone/model/fileDataModel.dart';
import 'package:document_summary_bot/utils/theme.dart' as theme;


class DropZoneWidget extends StatefulWidget {

  final ValueChanged<FileDataModel> onDroppedFile;

  const DropZoneWidget({Key? key,required this.onDroppedFile}):super(key: key);
  @override
  State<DropZoneWidget> createState() => _DropZoneWidgetState();
}


class _DropZoneWidgetState extends State<DropZoneWidget> {

  late DropzoneViewController controller;
  bool highlight = false;
  FileDataModel? fileDataModel;

  @override
  Widget build(BuildContext context) {

    return buildDecoration(

      child: Stack(
        children: <Widget>[
          DropzoneView(
            onCreated: (controller) => this.controller = controller,
            onDrop: uploadedFile,
            mime: const <String>["application/pdf"],
            onHover:() => setState(() => highlight = true),
            onLeave: ()=> setState(() => highlight = false),
            onError: (e) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Error uploading file",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: theme.bgPrimaryColor,
                  ),
                ),
              ),
            ),
            onLoaded: () => setState(() => highlight = false),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 12.0),
                Icon(
                  fileDataModel != null ? Icons.cloud_done_outlined : Icons.cloud_upload_outlined,
                  size: 38,
                  color: theme.textColor,
                ),
                Text(
                  fileDataModel != null ? fileDataModel!.name : "Start by adding your PDF",
                  style: const TextStyle(
                    color: theme.textColor,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 12.0),
                _button(),
                const SizedBox(height: 12.0),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Future uploadedFile(dynamic event) async {
    final name = event.name;

    final String mime = await controller.getFileMIME(event);
    final int size = await controller.getFileSize(event);
    final String url = await controller.createFileUrl(event);
    final Uint8List data = await controller.getFileData(event);

    debugPrint('Name : $name');
    debugPrint('Mime: $mime');

    debugPrint('Size : ${size / (1024 * 1024)}');
    debugPrint('URL: $url');

    setState(() {
      fileDataModel = FileDataModel(
        name: name,
        mime: mime,
        getSize: size,
        url: url,
        data: data,
      );
      highlight = false;
      widget.onDroppedFile(fileDataModel!);
    });

    if(mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "File uploaded successfully",
            style: TextStyle(
              fontSize: 16.0,
              color: theme.bgPrimaryColor,
            ),
          ),
        ),
      );
    }
  }


  Widget _button() => Material(
    color: Colors.transparent,
    child: Ink(
      height: 38.0,
      width: 130.0,
      decoration: BoxDecoration(
        color: theme.greyColor,
        borderRadius: theme.borderRadius,
      ),
      child: InkWell(
        borderRadius: theme.borderRadius,
        splashColor: theme.bgPrimaryColor.withOpacity(0.1),
        hoverColor: theme.bgPrimaryColor.withOpacity(0.05),
        onTap: () async {
          final events = await controller.pickFiles(mime: <String>["application/pdf"]);
          if(events.isEmpty) return;
          uploadedFile(events.first);
        },
        child: const Center(
          child: Text(
            "Choose File",
            style: TextStyle(
              color: theme.textColor,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    ),
  );


  Widget buildDecoration({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: highlight ? theme.bgSecondaryColor : theme.bgPrimaryColor,
        child: DottedBorder(
            borderType: BorderType.RRect,
            color: theme.greyColor,
            strokeWidth: 2,
            dashPattern: const [5,5],
            radius: Radius.circular(theme.borderRadius.bottomLeft.x),
            padding: EdgeInsets.zero,
            child: child
        ),
      ),
    );
  }
}
