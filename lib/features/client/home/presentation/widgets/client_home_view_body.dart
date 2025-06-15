import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/widgets/custom_app_bar.dart';
import 'package:swift_mobile_app/features/client/home/presentation/cubits/fetch_categories_cubit/fetch_categories_cubit.dart';
import 'package:swift_mobile_app/features/client/home/presentation/cubits/fetch_product_cubit/fetch_products_cubit.dart';
import 'package:swift_mobile_app/features/client/home/presentation/widgets/category_list.dart';
import 'package:swift_mobile_app/features/client/home/presentation/widgets/nav_bar.dart';
import 'package:swift_mobile_app/features/client/home/presentation/widgets/products_grid_view.dart';

class ClientHomeViewBody extends StatefulWidget {
  const ClientHomeViewBody({super.key});

  @override
  State<ClientHomeViewBody> createState() => _ClientHomeViewBodyState();
}

class _ClientHomeViewBodyState extends State<ClientHomeViewBody> {
  @override
  void initState() {
    context.read<FetchCategoriesCubit>().fetchCategories();
    context.read<FetchProductsCubit>().fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(),
          SizedBox(height: 20.h),
          SizedBox(
            height: 100.h,
            child: BlocBuilder<FetchCategoriesCubit, FetchCategoriesState>(
              builder: (context, state) {
                if (state is FetchCategoriesFailure) {
                  return Text('حدث خطأ ${state.errMessage}');
                } else if (state is FetchCategoriesSuccess) {
                  return CategoryList(categories: state.categories);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<FetchProductsCubit, FetchProductsState>(
              builder: (context, state) {
                if (state is FetchProductsFailure) {
                  return Text('حدث خطأ ${state.errMessage}');
                } else if (state is FetchProductsSuccess) {
                  return ProductsGridView(products: state.products);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          NavBar(),
        ],
      ),
    );
  }
}
