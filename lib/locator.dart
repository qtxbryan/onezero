import 'package:get_it/get_it.dart';
import './core/Services/Database.dart';
import './core/Model/CRUDModel.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => Database('listing'));
  locator.registerLazySingleton(() => CRUDModel());
}
