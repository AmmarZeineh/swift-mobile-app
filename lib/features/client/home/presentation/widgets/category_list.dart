import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/category_card_entity.dart';
import 'package:swift_mobile_app/features/client/home/presentation/widgets/category_card.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key, required this.categories});
  final List<CategoryCardEntity> categories;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int? selectedIndex;

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
            },
          ),
        );
      },
    );
  }
}
