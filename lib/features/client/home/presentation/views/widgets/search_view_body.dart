import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/widgets/secondry_custom_app_bar.dart';
import 'package:swift_mobile_app/features/client/home/presentation/cubits/search_product_cubit/search_product_cubit.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/widgets/Search_field.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/widgets/category_drop_down.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/widgets/products_grid_view.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  final TextEditingController _controller = TextEditingController();
  int? selectedCategoryId;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      // RTL دعم
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: CustomAppBar(text: "البحث"),
            ),
            SearchField(
              controller: _controller,
              selectedCategoryId: selectedCategoryId,
            ),

            const SizedBox(height: 12),

            ImprovedCategoryDropdown(
              selectedCategoryId: selectedCategoryId,
              onChanged: (value) {
                setState(() => selectedCategoryId = value);
              },
            ),

            const SizedBox(height: 12),

            // النتائج
            Expanded(
              child: BlocBuilder<SearchProductCubit, SearchProductState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoaded) {
                    if (state.products.isEmpty) {
                      return const Center(child: Text('لا توجد نتائج'));
                    }

                    return ProductsGridView(products: state.products);
                  } else if (state is SearchError) {
                    return Center(child: Text(state.message));
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
