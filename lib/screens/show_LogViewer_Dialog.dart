import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<void> showLogViewerDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return FutureBuilder<String>(
        future: _loadLogFile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AlertDialog(
              title: Text('View Logs'),
              content: SizedBox(
                height: 100,
                child: Center(child: CircularProgressIndicator()),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text('Close'),
                ),
              ],
            );
          } else {
            final logContent = snapshot.data ?? 'No logs available.';
            return AlertDialog(
              title: Text('View Logs'),
              content: SizedBox(
                width: double.maxFinite,
                height: 400,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: SelectableText(
                      logContent,
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text('Close'),
                ),
              ],
            );
          }
        },
      );
    },
  );
}

Future<String> _loadLogFile() async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/daggerheart.log');
    if (!await file.exists()) {
      String msg = 'Log file not found.';
      debugPrint('${DateTime.now()}: $msg');
      return msg;
    }
    return await file.readAsString();
  } catch (e) {
    String msg = 'Failed to load log: $e';
    debugPrint('${DateTime.now()}: $msg');
    return msg;
  }
}
