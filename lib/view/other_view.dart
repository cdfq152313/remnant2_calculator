import 'dart:typed_data';

import 'package:download/download.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remnant2_calculator/repository/repository_pack.dart';

class OtherView extends StatelessWidget {
  const OtherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            final pack = context.read<RepositoryPack>();
            final stream = Stream.fromIterable(pack.export());
            download(stream, 'remnant2.json');
          },
          child: const Text('匯出'),
        ),
        TextButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['json'],
              );
              if (result != null && context.mounted) {
                final pack = context.read<RepositoryPack>();
                pack.import(result.files.single.bytes ?? Uint8List(0));
              }
            },
            child: const Text('匯入')),
      ],
    );
  }
}
