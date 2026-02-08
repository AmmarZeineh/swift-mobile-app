import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';

// تعريف CategoryItem في ملف منفصل أو في أعلى الملف
class CategoryItem {
  final int? id;
  final String name;
  final IconData icon;

  const CategoryItem({
    required this.id,
    required this.name,
    required this.icon,
  });
}

// قائمة الفئات الثابتة لتجنب التكرار
class CategoryData {
  static const List<CategoryItem> categories = [
    CategoryItem(id: null, name: "الكل", icon: Icons.apps_rounded),
    CategoryItem(id: 1, name: "ملابس", icon: Icons.checkroom_rounded),
    CategoryItem(id: 2, name: "إلكترونيات", icon: Icons.devices_rounded),
    CategoryItem(id: 3, name: "إكسسوارات", icon: Icons.watch_rounded),
    CategoryItem(id: 5, name: "أحذية", icon: FontAwesomeIcons.shoePrints),
  ];

  static CategoryItem findCategoryById(int? id) {
    return categories.firstWhere(
      (cat) => cat.id == id,
      orElse: () => categories.first,
    );
  }
}

class ImprovedCategoryDropdown extends StatefulWidget {
  const ImprovedCategoryDropdown({
    super.key,
    required this.selectedCategoryId,
    required this.onChanged,
  });

  final int? selectedCategoryId;
  final Function(int?) onChanged;

  @override
  State<ImprovedCategoryDropdown> createState() =>
      _ImprovedCategoryDropdownState();
}

class _ImprovedCategoryDropdownState extends State<ImprovedCategoryDropdown> {
  bool _isExpanded = false;

  CategoryItem get selectedCategory =>
      CategoryData.findCategoryById(widget.selectedCategoryId);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: isDark ? Colors.grey[850] : AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _toggleDropdown,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    _isExpanded
                        ? AppColors.primaryColor
                        : (isDark ? Colors.grey[700]! : Colors.grey[300]!),
                width: _isExpanded ? 2 : 1,
              ),
            ),
            child: Column(
              children: [_buildHeader(isDark), _buildDropdownContent(isDark)],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleDropdown() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Widget _buildHeader(bool isDark) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            selectedCategory.icon,
            color: AppColors.primaryColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            selectedCategory.name,
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white : AppColors.secondaryColor,
            ),
          ),
        ),
        AnimatedRotation(
          turns: _isExpanded ? 0.5 : 0,
          duration: const Duration(milliseconds: 200),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.primaryColor,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownContent(bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: _isExpanded ? null : 0,
      child:
          _isExpanded
              ? Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    height: 1,
                    color: isDark ? Colors.grey[700] : Colors.grey[300],
                  ),
                  const SizedBox(height: 8),
                  ...CategoryData.categories.map((category) {
                    final isSelected = category.id == widget.selectedCategoryId;
                    return _buildCategoryItem(category, isSelected, isDark);
                  }),
                ],
              )
              : const SizedBox.shrink(),
    );
  }

  Widget _buildCategoryItem(
    CategoryItem category,
    bool isSelected,
    bool isDark,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _selectCategory(category.id),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                category.icon,
                color: _getItemIconColor(isSelected, isDark),
                size: 18,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 14,
                    color: _getItemTextColor(isSelected, isDark),
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_rounded,
                  color: AppColors.primaryColor,
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectCategory(int? categoryId) {
    widget.onChanged(categoryId);
    setState(() {
      _isExpanded = false;
    });
  }

  Color _getItemIconColor(bool isSelected, bool isDark) {
    if (isSelected) return AppColors.primaryColor;
    return isDark ? Colors.grey[400]! : AppColors.secondaryColor;
  }

  Color _getItemTextColor(bool isSelected, bool isDark) {
    if (isSelected) return AppColors.primaryColor;
    return isDark ? Colors.white : AppColors.secondaryColor;
  }
}

// Alternative: Modern Chip-style Dropdown
class ChipCategoryDropdown extends StatelessWidget {
  const ChipCategoryDropdown({
    super.key,
    required this.selectedCategoryId,
    required this.onChanged,
  });

  final int? selectedCategoryId;
  final Function(int?) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: CategoryData.categories.length,
        itemBuilder: (context, index) {
          final category = CategoryData.categories[index];
          final isSelected = category.id == selectedCategoryId;

          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    category.icon,
                    size: 16,
                    color:
                        isSelected
                            ? AppColors.primaryColor
                            : AppColors.secondaryColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    category.name,
                    style: TextStyle(
                      color:
                          isSelected
                              ? AppColors.primaryColor
                              : AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
              onSelected: (selected) => onChanged(category.id),
              selectedColor: AppColors.primaryColor,
              checkmarkColor: AppColors.primaryColor,
              side: BorderSide(
                color: isSelected ? AppColors.primaryColor : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}
