import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/services/app_update_service.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/features/seller/add_product/presentation/views/add_product_view.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/widgets/seller_home_view_body.dart';
import 'package:swift_mobile_app/features/seller/profile/presentation/views/seller_profile_view.dart';

class SellerHomeView extends StatefulWidget {
  const SellerHomeView({super.key});
  static const routeName = 'seller-home-view';

  @override
  State<SellerHomeView> createState() => _SellerHomeViewState();
}

class _SellerHomeViewState extends State<SellerHomeView> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    SellerHomeView(),
    AddProductView(),
    SellerProfileView(),
  ];
  @override
  void initState() {
    AppUpdateService.checkForUpdates(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 1,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.secondaryColor,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الصفحة الرئيسية',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'اضافة منتج'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'الملف الشخصي',
          ),
        ],
      ),
      body:
          selectedIndex == 0
              ? SafeArea(child: SellerHomeViewBody())
              : screens[selectedIndex],
    );
  }
}

// // باقي الكود يبقى نفسه
// class HomeViewBodyBlocConsumer extends StatelessWidget {
//   const HomeViewBodyBlocConsumer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FetchProductsCubit, FetchProductsState>(
//       builder: (context, state) {
//         if (state is FetchProductsFailure) {
//           errorSnackBar(context, state.errMessage);
//         }
//         if (state is FetchProductsSuccess) {
//           return SellerHomeViewBody(products: state.products);
//         }
//         return ModalProgressHUD(
//           inAsyncCall: state is FetchProductsLoading,
//           child: SellerHomeViewBody(products: []),
//         );
//       },
//     );
//   }
// }
