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
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
          child: const Text('匯入'),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('更新日誌:', style: Theme.of(context).textTheme.headlineMedium),
              const Text('12/1: 初版'),
              const Text('12/7: 顯示加總數字'),
            ],
          ),
        )
      ],
    );
  }
}
