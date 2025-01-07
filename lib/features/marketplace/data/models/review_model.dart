import '../../domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel({
    required super.reviewId,
    required super.productId,
    required super.userId,
    super.reviewContent,
    required super.date,
    required super.reviewValue,
    super.reviewImages,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewId: json['reviewId'],
      productId: json['productId'],
      userId: json['userId'],
      reviewContent: json.containsKey('reviewContent') ? json['reviewContent'] : null,
      reviewImages: json.containsKey('reviewImages') ? (json['reviewImages'] as List).cast() : null,
      date: DateTime.parse(json['reviewDate']),
      reviewValue: json['reviewValue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviewId': reviewId,
      'productId': productId,
      'userId': userId,
      if (reviewImages != null) 'reviewImages': reviewImages,
      if (reviewContent != null) 'reviewContent': reviewContent,
      'reviewDate': date.toString(),
      'reviewValue': reviewValue,
    };
  }
}
