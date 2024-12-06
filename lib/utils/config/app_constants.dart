import 'package:intl/intl.dart';

class AppConstants {
  static final dateFormat = DateFormat('dd/MM/yyyy');
  static final timeFormat = DateFormat('HH:mm');
  static final dateTimeFormat = DateFormat('HH:mm - dd/MM/yyyy');
}

extension DefaultConstants on AppConstants {
  static const defaultBranchName = 'Uni Service BK';
  static const defaultImageUrl = 'defaultImageUrl';
  static const defaultBranch = 'defaultBranch';
  static const defaultDescription = 'defaultDescription';
  static const defaultName = 'defaultName';
  static const defaultRecipientName = 'defaultRecipientName';
  static const defaultRecipientId= 'defaultRecipientId';
  static const defaultPhone = 'defaultPhone';

}
extension AppLinkConstants on AppConstants {
  static const termsOfService = 'https://google.com';
  static const privacyPolicy = 'https://google.com'; 
}

extension AppImageConstants on AppConstants {
  static const defaultAvatar =  'https://img.freepik.com/free-vector/young-man-orange-hoodie_1308-175788.jpg?t=st=1729744242~exp=1729747842~hmac=5c6a50bb08d559044f0891ec88a4086c66abaa381f0922a63d75773caf9a534a&w=360';
  static const scan = "assets/images/scan.png";
  static const vexereurl = "https://storage.googleapis.com/blogvxr-uploads/2022/08/PO-6.png";
  static const btaskeeurl = "https://employer.jobsgo.vn/uploads/media/img/201911/pictures_library_19108_20191118143305_8696.png";
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
