import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:swift_mobile_app/core/entities/review_entity.dart';
import 'package:swift_mobile_app/core/helper_functions/snack_bars.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/features/client/order/domain/entities/order_item_entity.dart';
import 'package:swift_mobile_app/features/client/order/presentation/cubits/rating_cubit/rating_cubit.dart';
import 'package:swift_mobile_app/features/client/order/presentation/views/widgets/info_order_product_button.dart';

class CustomOrderItem extends StatefulWidget {
  const CustomOrderItem({
    super.key,
    required this.orderItemEntity,
    required this.isOrderCompleted,
  });
  final OrderItemEntity orderItemEntity;
  final bool isOrderCompleted;

  @override
  State<CustomOrderItem> createState() => _CustomOrderItemState();
}

class _CustomOrderItemState extends State<CustomOrderItem> {
  int _currentRating = 0;
  bool _isRated = false;
  final TextEditingController _commentController = TextEditingController();
  String _userComment = '';

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Widget _buildRatingSection() {
    if (!widget.isOrderCompleted) {
      return SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.amber.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'تقييم المنتج:',
            style: AppTextStyles.w600_14.copyWith(color: Colors.grey[700]),
          ),
          if (_isRated) ...[
            Row(
              children: [
                ...List.generate(5, (index) {
                  return Icon(
                    index < _currentRating
                        ? Icons.star_rounded
                        : Icons.star_border_rounded,
                    color: Colors.amber,
                    size: 16.sp,
                  );
                }),
                SizedBox(width: 8.w),
                Text(
                  'تم التقييم',
                  style: AppTextStyles.w400_12.copyWith(
                    color: Colors.amber[700],
                  ),
                ),
              ],
            ),
          ] else ...[
            GestureDetector(
              onTap: () => _showRatingDialog(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_border_rounded,
                      color: Colors.amber,
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'قيم المنتج',
                      style: AppTextStyles.w400_12.copyWith(
                        color: Colors.amber[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showRatingDialog() {
    int tempRating = 0;
    String tempComment = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Center(
              child: SingleChildScrollView(
                child: AlertDialog(
                  title: Text(
                    'تقييم المنتج',
                    style: AppTextStyles.w600_18,
                    textAlign: TextAlign.center,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Product info
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              widget.orderItemEntity.productImage!,
                              height: 40.h,
                              width: 40.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              widget.orderItemEntity.productName!,
                              style: AppTextStyles.w400_14,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'كيف تقيم هذا المنتج؟',
                        style: AppTextStyles.w400_14.copyWith(
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {
                              setDialogState(() {
                                tempRating = index + 1;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: Icon(
                                index < tempRating
                                    ? Icons.star_rounded
                                    : Icons.star_border_rounded,
                                color: Colors.amber,
                                size: 32.sp,
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        _getRatingText(tempRating),
                        style: AppTextStyles.w400_14.copyWith(
                          color: Colors.amber[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      // Comment section
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ':التعليق',
                          style: AppTextStyles.w400_14.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                          controller: _commentController,
                          maxLines: 3,
                          textDirection: TextDirection.rtl,

                          onChanged: (value) {
                            setDialogState(() {
                              tempComment = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'اكتب تعليقك عن هذا المنتج',
                            hintStyle: AppTextStyles.w400_12.copyWith(
                              color: Colors.grey[500],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: Colors.amber,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                          ),
                          style: AppTextStyles.w400_14,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'إلغاء',
                        style: AppTextStyles.w400_14.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed:
                          tempRating > 0 && tempComment.trim().isNotEmpty
                              ? () async {
                                _currentRating = tempRating;
                                _commentController.text = tempComment;
                                _submitRating();
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: BlocBuilder<RatingCubit, RatingState>(
                        builder: (context, state) {
                          if (state is RatingLoading) {
                            return CircularProgressIndicator();
                          } else if (state is RatingFailure) {
                            return Text(
                              state.errMessage,
                              style: AppTextStyles.w400_14.copyWith(
                                color: Colors.white,
                              ),
                            );
                          }
                          return Text(
                            'إرسال التقييم',
                            style: AppTextStyles.w400_14.copyWith(
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return 'سيء جداً';
      case 2:
        return 'سيء';
      case 3:
        return 'جيد';
      case 4:
        return 'جيد جداً';
      case 5:
        return 'ممتاز';
      default:
        return 'اختر تقييمك';
    }
  }

  void _submitRating() async {
    setState(() {
      _isRated = true;
      _userComment = _commentController.text.trim();
    });
    await context.read<RatingCubit>().rateProduct(
      context.read<UserCubit>().currentUser!,
      ReviewEntity(
        id: 0,
        userName: context.read<UserCubit>().currentUser!.userName,
        productId: int.parse(widget.orderItemEntity.productId),
        comment: _userComment,
        rate: _currentRating,
        date: '',
      ),
    );
    Navigator.of(context).pop();
    // إظهار رسالة تأكيد
    showSuccessMessage('تم تقييم المنتج بنجاح', context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h, left: 8, right: 8),
      child: SizedBox(
        width: 334.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: widget.orderItemEntity.productImage!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.orderItemEntity.productName!,
                        style: AppTextStyles.w400_16,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Text(' ل.س', style: AppTextStyles.w700_16),
                          SizedBox(width: 4),
                          Text(
                            '${widget.orderItemEntity.price}',
                            style: AppTextStyles.w700_16,
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "الكمية: ${widget.orderItemEntity.quantity.toString()}",
                        style: AppTextStyles.w400_14.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30),
                InfoOrderProductButton(orderItemEntity: widget.orderItemEntity),
              ],
            ),
            // Rating section
            _buildRatingSection(),
            SizedBox(height: 12.h),
            SizedBox(
              width: 300.w,
              child: Divider(thickness: 1, color: Colors.grey.shade300),
            ),
          ],
        ),
      ),
    );
  }
}
