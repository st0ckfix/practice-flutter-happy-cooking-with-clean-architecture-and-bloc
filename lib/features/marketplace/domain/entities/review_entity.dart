import 'package:intl/intl.dart';

DateFormat formattedDate2 = DateFormat.yMd();

class ReviewEntity {
  final String reviewId;
  final String productId;
  final String userId;
  final int reviewValue;
  final String? reviewContent;
  final List<String>? reviewImages;
  final DateTime date;

  ReviewEntity({
    required this.reviewId,
    required this.productId,
    required this.userId,
    required this.reviewValue,
    this.reviewContent,
    this.reviewImages,
    required this.date,
  });

  String get getDateLabel {
    return formattedDate2.format(date);
  }

  int get getImagesLength {
    return reviewImages?.length ?? 0;
  }

  @override
  String toString() {
    return '[reviewId]-$reviewId, [productId]-$productId, [userId]-$userId, [reviewContent]-$reviewContent';
  }
}
