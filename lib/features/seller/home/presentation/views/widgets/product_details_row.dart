import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';

class ProductDetailsRow extends StatefulWidget {
  const ProductDetailsRow({
    super.key,
    required this.title,
    required this.value,
    required this.onPressed,
    this.maxLinesCollapsed = 2,
  });

  final String title;
  final String value;
  final void Function() onPressed;
  final int maxLinesCollapsed;

  @override
  State<ProductDetailsRow> createState() => _ProductDetailsRowState();
}

class _ProductDetailsRowState extends State<ProductDetailsRow> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: widget.onPressed,
            icon: Icon(Icons.edit),
            constraints: BoxConstraints(minWidth: 40, minHeight: 40),
            padding: EdgeInsets.all(8),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ': ${widget.title}',
                  style: AppTextStyles.w400_16,
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Text(
                    widget.value,
                    style: AppTextStyles.w400_16.copyWith(color: Colors.grey),
                    textAlign: TextAlign.right,
                    maxLines: isExpanded ? null : widget.maxLinesCollapsed,
                    overflow:
                        isExpanded
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                  ),
                ),
                if (_isTextOverflowing())
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        isExpanded ? 'عرض أقل' : 'عرض المزيد',
                        style: AppTextStyles.w400_16.copyWith(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isTextOverflowing() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: widget.value,
        style: AppTextStyles.w400_16.copyWith(color: Colors.grey),
      ),
      maxLines: widget.maxLinesCollapsed,
      textDirection: TextDirection.rtl,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width - 100);
    return textPainter.didExceedMaxLines;
  }
}
