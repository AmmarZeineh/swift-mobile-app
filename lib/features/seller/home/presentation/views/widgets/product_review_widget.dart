import 'package:flutter/material.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/widgets/review_item_widget.dart';

import '../../../../../../core/entities/review_entity.dart';

class ProductReviewsWidget extends StatefulWidget {
  final List<ReviewEntity> reviews;

  const ProductReviewsWidget({super.key, required this.reviews});

  @override
  State<ProductReviewsWidget> createState() => _ProductReviewsWidgetState();
}

class _ProductReviewsWidgetState extends State<ProductReviewsWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),

        // زر عرض التقييمات
        GestureDetector(
          onTap: _toggleExpansion,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      AnimatedRotation(
                        turns: _isExpanded ? 0.5 : 0,
                        duration: Duration(milliseconds: 300),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 8),
                      Text(
                        _isExpanded
                            ? 'إخفاء التقييمات'
                            : 'عرض التقييمات (${widget.reviews.length})',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // قائمة التقييمات
        SizeTransition(
          sizeFactor: _animation,
          child: Column(
            children: [
              SizedBox(height: 16),
              if (widget.reviews.isEmpty)
                Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.rate_review_outlined,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'لا توجد تقييمات حتى الآن',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.reviews.length,
                  separatorBuilder:
                      (context, index) =>
                          Divider(color: Colors.grey.shade300, thickness: 1),
                  itemBuilder: (context, index) {
                    final review = widget.reviews[index];
                    return ReviewItemWidget(review: review);
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
