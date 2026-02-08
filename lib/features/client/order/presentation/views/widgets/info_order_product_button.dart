import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/features/client/order/domain/entities/order_item_entity.dart';

class InfoOrderProductButton extends StatelessWidget {
  const InfoOrderProductButton({super.key, required this.orderItemEntity});

  final OrderItemEntity orderItemEntity;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final selectedSummary = orderItemEntity.selectedAttribute;
        final attributeLines = selectedSummary.split('\n');

        showDialog(
          context: context,
          builder: (context) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Text(
                  "المواصفات المختارة",
                  style: AppTextStyles.w700_16.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                content: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        attributeLines.map((line) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Text(line, style: AppTextStyles.w300_14),
                          );
                        }).toList(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      "إغلاق",
                      style: AppTextStyles.w700_16.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      icon: Icon(Icons.info, color: AppColors.secondaryColor),
    );
  }
}
