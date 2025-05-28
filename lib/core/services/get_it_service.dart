import 'package:get_it/get_it.dart';
import 'package:swift_mobile_app/core/repos/image_repo/image_repo.dart';
import 'package:swift_mobile_app/core/repos/image_repo/image_repo_impl.dart';
import 'package:swift_mobile_app/core/services/database_service.dart';
import 'package:swift_mobile_app/core/services/storage_service.dart';
import 'package:swift_mobile_app/core/services/supabase_auth_service.dart';
import 'package:swift_mobile_app/core/services/supabase_database_service.dart';
import 'package:swift_mobile_app/core/services/supabase_storage_service.dart';
import 'package:swift_mobile_app/features/seller/auth/data/repos/seller_auth_repo_impl.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/repos/seller_auth_repo.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<SupabaseAuthService>(SupabaseAuthService());
  getIt.registerSingleton<DataBaseService>(SupabaseDatabaseService());
  getIt.registerSingleton<StorageService>(SupabaseStorageService());
  getIt.registerSingleton<ImageRepo>(
    ImageRepoImpl(getIt.get<StorageService>()),
  );
  getIt.registerSingleton<SellerAuthRepo>(
    SellerAuthRepoImpl(
      getIt.get<SupabaseAuthService>(),
      getIt.get<DataBaseService>(),
      getIt.get<ImageRepo>(),
    ),
  );
}
