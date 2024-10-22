import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
class L {
  static final LogServiceImpl _logService = Get.find();

  static void trace(dynamic message) {
    _logService.logger.t(message);
  }

  static void debug(dynamic message) {
    _logService.logger.d(message);
  }

  static void info(dynamic message) {
    _logService.logger.i(message);
  }

  static void warning(dynamic message) {
    _logService.logger.w(message);
  }

  static void error(dynamic message) {
    _logService.logger.e(message);
  }

  static void fatal(dynamic message) {
    _logService.logger.f(message);
  }
}

class LogServiceImpl extends GetxService {
  final logger = Logger(
    printer: MyPrinter(),
  );
}

class MyPrinter extends LogPrinter {
  static final levelEmojis = {
    Level.trace: '🙂',
    Level.debug: '🐛',
    Level.info: '💡',
    Level.warning: '❓',
    Level.error: '⛔',
    Level.fatal: '🖕',
  };

  @override
  List<String> log(LogEvent event) {
    final icon = levelEmojis[event.level]!;
    final msg = event.message;
    final time = DateFormat('h:mm:ss a').format(DateTime.now());



    return ['[$time] $icon $msg'];
  }
}
