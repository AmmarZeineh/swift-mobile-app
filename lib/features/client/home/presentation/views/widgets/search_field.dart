import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/features/client/home/presentation/cubits/search_product_cubit/search_product_cubit.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.selectedCategoryId,
  });

  final TextEditingController controller;
  final int? selectedCategoryId;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _search() {
    if (widget.controller.text.isNotEmpty) {
      context.read<SearchProductCubit>().searchProducts(
        keyword: widget.controller.text,
        categoryId: widget.selectedCategoryId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _isFocused ? AppColors.primaryColor : Colors.black,
            blurRadius: _isFocused ? 8 : 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        textDirection: TextDirection.rtl,
        style: TextStyle(fontSize: 16, color: theme.textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          hintText: 'ابحث عن منتج...',
          hintStyle: TextStyle(color: theme.hintColor, fontSize: 16),
          filled: true,
          fillColor:
              _isFocused
                  ? (isDark ? Colors.grey[800] : Colors.white)
                  : (isDark ? Colors.grey[850] : Colors.grey[50]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.primaryColor, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(Icons.search_rounded, color: Colors.white, size: 22),
              onPressed: _search,
            ),
          ),
          suffixIcon:
              widget.controller.text.isNotEmpty
                  ? IconButton(
                    icon: Icon(
                      Icons.clear_rounded,
                      color: theme.hintColor,
                      size: 20,
                    ),
                    onPressed: () {
                      widget.controller.clear();
                      setState(() {});
                    },
                  )
                  : null,
        ),
        onSubmitted: (value) => _search(),
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }
}
