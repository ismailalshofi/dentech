import 'package:dentech/core/data/new_remote/http_network_service.dart';
import 'package:dentech/core/data/new_remote/network_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dentech/core/app_store/app_store.dart';
import 'data/local_data/local_data_source.dart';

final getIt = GetIt.instance;

Future<void> configureInjection() async {
  /// data sources
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final AppStore appStore = AppStore();

  getIt.registerLazySingleton<NetworkService>(()=>HttpNetworkService());

  getIt.registerLazySingleton<SharedPreferences>(()=>sharedPreferences);
  getIt.registerLazySingleton<LocalDataSource>(()=>LocalDataSourceSharedPreferences(getIt()));

  getIt.registerLazySingleton<AppStore>(()=>appStore);

}
