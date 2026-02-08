import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/helper_classes/date_helper.dart';

import '../../../../../../core/entities/review_entity.dart';

class ReviewItemWidget extends StatelessWidget {
  final ReviewEntity review;

  const ReviewItemWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      review.userName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      DateHelper.getFormattedDateArabic(review.date),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey.shade200,
                child: Icon(
                  Icons.person,
                  color: Colors.grey.shade600,
                  size: 28,
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // التعليق
          if (review.comment.isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                review.comment,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),

          SizedBox(height: 12),

          // التقييم بالنجوم
          Row(
            children: [
              ...List.generate(5, (index) {
                return Icon(
                  index < review.rate ? Icons.star : Icons.star_outline,
                  color: Colors.amber,
                  size: 20,
                );
              }),
              SizedBox(width: 8),
              Text(
                '${review.rate}/5',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              Spacer(),
              Text(
                ':التقييم',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
