import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/category_card_entity.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/widgets/category_card.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    super.key,
    required this.categories,
    this.onCategorySelected,
  });

  final List<CategoryCardEntity> categories;
  final Function(int?)? onCategorySelected;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int? selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 20.w),
      itemCount: widget.categories.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: 25.w),
          child: CategreyCard(
            categoryCardEntity: widget.categories[index],
            isSelected: selectedIndex == index,
            onTap: () {
              setState(() {
                selectedIndex = index;
              });

              if (index == 0) {
                widget.onCategorySelected?.call(null);
              } else {
                widget.onCategorySelected?.call(widget.categories[index].id);
              }
            },
          ),
        );
      },
    );
  }
}
