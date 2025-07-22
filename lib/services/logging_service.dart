import 'dart:io';
import 'package:daggerheart/utils/debug_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

class LoggingService {
  static final LoggingService _instance = LoggingService._internal();

  factory LoggingService() => _instance;

  late Logger rootLogger;
  IOSink? _logFileSink;

  LoggingService._internal();

  Future<void> setup({Level level = Level.ALL}) async {
    Logger.root.level = level;

    // Setup file for logging
    final logFile = await _initLogFile();
    _logFileSink = logFile.openWrite(mode: FileMode.append);

    Logger.root.onRecord.listen((record) {
      final logMessage =
        '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}';

      // Print to console
      debugLog('LoggingService: $logMessage');

      // Write to log file
      _logFileSink?.writeln(logMessage);
    });

    rootLogger = Logger('Root');

    rootLogger.info('${DateTime.now()} LoggingService initialised and log file: ${logFile.path}');
  }

  Logger getLogger(String name) => Logger(name);

  // Convenience methods for logging at root level
  void info(String message) => rootLogger.info(message);
  void warning(String message) => rootLogger.warning(message);
  void severe(String message) => rootLogger.severe(message);

  Future<void> close() async {
    await _logFileSink?.flush();
    await _logFileSink?.close();
  }

  Future<File> _initLogFile() async {
    Directory directory;

    if (Platform.isAndroid || Platform.isIOS) {
      directory = await getTemporaryDirectory(); // cache directory
    } else if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      directory = await getApplicationDocumentsDirectory(); // persistent directory
    } else {
      debugPrint("LoggingService: Unsupported platform");
      throw UnsupportedError("Unsupported platform");
    }

    //final directory = await getApplicationDocumentsDirectory(); // Or use a specific directory if desired
    final logFile = File('${directory.path}/daggerheart.log');

    if (!await logFile.exists()) {
      await logFile.create(recursive: true);
    }

    return logFile;
  }

}
