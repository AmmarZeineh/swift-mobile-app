import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/features/client/home/presentation/cubits/fetch_product_cubit/fetch_products_cubit.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/widgets/client_product_card.dart';

import '../../../../../../core/entities/product_entity.dart';

class ProductsGridView extends StatefulWidget {
  const ProductsGridView({super.key, required this.products});
  final List<ProductEntity> products;

  @override
  State<ProductsGridView> createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final cubit = context.read<FetchProductsCubit>();
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          cubit.state is FetchProductsSuccess &&
          (cubit.state as FetchProductsSuccess).hasMore) {
        cubit.loadMoreProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.h,
          mainAxisSpacing: 10.w,
          childAspectRatio: 0.65,
        ),
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          return ClientProductCard(productEntity: widget.products[index]);
        },
      ),
    );
  }
}
