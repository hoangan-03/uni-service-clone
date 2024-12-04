import 'package:intl/intl.dart';

class AppConstants {
  static final dateFormat = DateFormat('dd/MM/yyyy');
  static final timeFormat = DateFormat('HH:mm');
  static final dateTimeFormat = DateFormat('HH:mm - dd/MM/yyyy');
}

extension AppLinkConstants on AppConstants {
  static const termsOfService = 'https://google.com';
  static const privacyPolicy = 'https://google.com'; 
}

extension DurationConstants on AppConstants {
  static const defaultListGridTransitionDuration = Duration(milliseconds: 500);
  static const defaultEventTransfomDuration = Duration(milliseconds: 500);
  static const defaultGeneralDialogTransitionDuration =
      Duration(milliseconds: 200);
  static const defaultSnackBarDuration = Duration(seconds: 3);
  static const defaultErrorVisibleDuration = Duration(seconds: 3);
}

extension PagingConstants on AppConstants {
  static const initialPage = 1;
  static const itemsPerPage = 20;
  static const defaultInvisibleItemsThreshold = 3;
}
