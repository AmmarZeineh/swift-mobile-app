import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/features/client/order/domain/entities/order_entity.dart';
import 'package:swift_mobile_app/features/client/order/presentation/cubits/cubit/order_cubit.dart';
import 'package:swift_mobile_app/features/client/order/presentation/views/order_items_view.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order, required this.userId});

  final OrderEntity order;
  final String userId;

  Color _getStatusColor(String state) {
    switch (state.toLowerCase()) {
      case 'معلق':
        return Colors.orange;
      case 'مكتمل':
        return Colors.green;
      case 'ملغي':
        return Colors.red;
      case 'قيد التنفيذ':
        return AppColors.secondaryColor;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String state) {
    switch (state.toLowerCase()) {
      case 'معلق':
        return Icons.access_time_rounded;
      case 'مكتمل':
        return Icons.check_circle_rounded;
      case 'ملغي':
        return Icons.cancel_rounded;
      case 'قيد التنفيذ':
        return Icons.refresh_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(order.state);
    final statusIcon = _getStatusIcon(order.state);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return GestureDetector(
      onTap:
          () => Navigator.pushNamed(
            context,
            OrderItemsView.routeName,
            arguments: [order.items, order],
          ),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12.w : 16.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              spreadRadius: 0,
              blurRadius: 12,
              offset: Offset(0, 4.h),
            ),
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.all(isSmallScreen ? 16.w : 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with order number and status
                Flex(
                  direction: isSmallScreen ? Axis.vertical : Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:
                      isSmallScreen
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        'طلب #${order.id}',
                        style: AppTextStyles.w600_14.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    if (isSmallScreen) SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(statusIcon, color: statusColor, size: 14.sp),
                          SizedBox(width: 4.w),
                          Text(
                            order.state,
                            style: AppTextStyles.w600_14.copyWith(
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                if (isSmallScreen) ...[
                  // Small screen: vertical layout
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Address
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: Colors.grey[600],
                            size: 16.sp,
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              order.address,
                              style: AppTextStyles.w400_14.copyWith(
                                color: Colors.grey[700],
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8.h),

                      // Date
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.grey[600],
                            size: 16.sp,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            order.createdAt.toString().split(' ')[0],
                            style: AppTextStyles.w400_14.copyWith(
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.primaryColor.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              '${order.totalAmount.toStringAsFixed(2)}  ل.س',
                              style: AppTextStyles.w700_16.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),

                          if (order.state == 'معلق')
                            GestureDetector(
                              onTap: () async {
                                await context.read<OrdersCubit>().cancelOrder(
                                  order.id,
                                );
                                await context
                                    .read<OrdersCubit>()
                                    .loadUserOrders(userId);
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Icon(
                                  Icons.close_rounded,
                                  color: Colors.red,
                                  size: 18.sp,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ] else ...[
                  // Large screen: horizontal layout
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Address
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  color: AppColors.primaryColor,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 6.w),
                                Expanded(
                                  child: Text(
                                    order.address,
                                    style: AppTextStyles.w400_14.copyWith(
                                      color: Colors.grey[700],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 8.h),

                            // Date
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_rounded,
                                  color: AppColors.primaryColor,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  order.createdAt.toString().split(' ')[0],
                                  style: AppTextStyles.w400_14.copyWith(
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 12.w),

                      // Total amount and cancel button
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.primaryColor.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              '${order.totalAmount.toStringAsFixed(2)} ر.س',
                              style: AppTextStyles.w700_16.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),

                          if (order.state == 'معلق') ...[
                            SizedBox(height: 12.h),
                            GestureDetector(
                              onTap: () async {
                                await context.read<OrdersCubit>().cancelOrder(
                                  order.id,
                                );
                                await context
                                    .read<OrdersCubit>()
                                    .loadUserOrders(userId);
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Icon(
                                  Icons.close_rounded,
                                  color: Colors.red,
                                  size: 18.sp,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ],

                SizedBox(height: 12.h),

                // Tap to view items hint
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.touch_app_rounded,
                        color: AppColors.backgroundColor,
                        size: 14.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'اضغط لعرض تفاصيل الطلب',
                        style: AppTextStyles.w400_12.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
