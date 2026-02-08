import 'package:swift_mobile_app/core/entities/review_entity.dart';

class ReviewModel {
  final int id;
  final String userName;
  final int productId;
  final String comment;
  final num rate;
  final String date;

  ReviewModel({
    required this.id,
    required this.userName,
    required this.productId,
    required this.comment,
    required this.rate,
    required this.date,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    id: json['id'] as int,
    userName: json['user_name'] as String,
    productId: json['product_id'] as int,
    comment: json['comment'] as String,
    rate: json['rating'] as num,
    date: json['created_at'] as String,
  );
  ReviewEntity toEntity() => ReviewEntity(
    id: id,
    userName: userName,
    comment: comment,
    rate: rate.toDouble(),
    date: date,
    productId: productId,
  );
}
