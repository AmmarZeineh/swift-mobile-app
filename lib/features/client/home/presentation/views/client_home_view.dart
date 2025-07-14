import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/client/home/domain/repos/home_repo.dart';
import 'package:swift_mobile_app/features/client/home/presentation/cubits/fetch_categories_cubit/fetch_categories_cubit.dart';
import 'package:swift_mobile_app/features/client/home/presentation/cubits/fetch_product_cubit/fetch_products_cubit.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/widgets/client_home_view_body.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/widgets/nav_bar.dart';
import 'package:swift_mobile_app/features/client/order/presentation/views/order_view.dart';
import 'package:swift_mobile_app/features/client/profile/presentation/views/client_profile_view.dart';

class ClientHomeView extends StatefulWidget {
  const ClientHomeView({super.key});
  static const routeName = 'client-home-view';

  @override
  State<ClientHomeView> createState() => _ClientHomeViewState();
}

class _ClientHomeViewState extends State<ClientHomeView> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    ClientHomeViewBody(),
    OrderView(), // لاحقًا استبدلها بـ FavoritesView()
    ClientProfileView(), // لاحقًا استبدلها بـ ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => FetchCategoriesCubit(getIt.get<HomeRepo>()),
            ),
            BlocProvider(
              create: (context) => FetchProductsCubit(getIt.get<HomeRepo>()),
            ),
          ],
          child: IndexedStack(index: _selectedIndex, children: _screens),
        ),
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
