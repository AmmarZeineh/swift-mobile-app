import 'package:get_it/get_it.dart';
import 'package:swift_mobile_app/core/services/database_service.dart';
import 'package:swift_mobile_app/core/services/supabase_database_service.dart';
import 'package:swift_mobile_app/features/client/home/data/repos/home_repo_impl.dart';
import 'package:swift_mobile_app/features/client/home/domain/repos/home_repo.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<DataBaseService>(SupabaseDatabaseService());
  getIt.registerSingleton<HomeRepo>(HomeRepoImpl(getIt.get<DataBaseService>()));
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
