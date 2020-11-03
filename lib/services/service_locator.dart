import 'package:get_it/get_it.dart';
import 'calls_messages.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerSingleton(CallsAndMessages());
}