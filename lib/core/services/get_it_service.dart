import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:swift_mobile_app/core/services/database_service.dart';
import 'package:swift_mobile_app/core/services/supabase_auth_service.dart';
import 'package:swift_mobile_app/core/services/supabase_database_service.dart';
import 'package:swift_mobile_app/features/client/auth/data/repos/client_auth_repo_imp.dart';
import 'package:swift_mobile_app/features/client/auth/domain/repos/client_auth_repo.dart';
import 'package:swift_mobile_app/features/client/cart/data/repos/cart_repo_imp.dart';
import 'package:swift_mobile_app/features/client/cart/domain/repos/cart_repo.dart';
import 'package:swift_mobile_app/features/client/home/data/repos/home_repo_impl.dart';
import 'package:swift_mobile_app/features/client/home/domain/repos/home_repo.dart';
import 'package:swift_mobile_app/features/client/order/data/repo/order_repo_imp.dart';
import 'package:swift_mobile_app/features/client/order/domain/repo/order_repo.dart';
import 'package:swift_mobile_app/features/client/product_details/data/repo/product_details_repo_imp.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/repo/product_details_repo.dart';
import 'package:swift_mobile_app/features/client/profile/data/repos/client_profile_repo_impl.dart';
import 'package:swift_mobile_app/features/client/profile/domain/repos/client_profile_repo.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<SupabaseAuthService>(SupabaseAuthService());
  getIt.registerLazySingleton(() => Supabase.instance.client);
  getIt.registerSingleton<DataBaseService>(SupabaseDatabaseService());
  getIt.registerSingleton<HomeRepo>(
    HomeRepoImpl(
      getIt.get<DataBaseService>(),
      supabaseClient: getIt.get<SupabaseClient>(),
    ),
  );
  getIt.registerSingleton<ProductDetailsRepo>(
    ProductDetailsRepoImp(getIt.get<DataBaseService>()),
  );
  getIt.registerSingleton<ClientAuthRepo>(
    ClientAuthRepoImp(
      getIt.get<DataBaseService>(),
      getIt.get<SupabaseAuthService>(),
    ),
  );
  getIt.registerLazySingleton<UserCubit>(() => UserCubit());
  getIt.registerSingleton<CartRepo>(CartRepoImp(getIt.get<DataBaseService>()));

  getIt.registerSingleton<OrdersRepo>(
    OrdersRepoImp(
      getIt.get<DataBaseService>(),
      supabaseClient: getIt.get<SupabaseClient>(),
    ),
  );
  getIt.registerSingleton<CLientProfileRepo>(
    ClientProfileRepoImpl(getIt.get<DataBaseService>()),
  );
  // getIt.registerSingleton<CitiesRepo>(
  //   CitiesRepoImpl(getIt.get<DataBaseService>()),
  // );
  // getIt.registerSingleton<CategoriesRepo>(
  //   CategoriesRepoImpl(getIt.get<DataBaseService>()),
  // );
  // getIt.registerSingleton<StorageService>(SupabaseStorageService());

  // getIt.registerSingleton<ImageRepo>(
  //   ImageRepoImpl(getIt.get<StorageService>()),
  // );
}
