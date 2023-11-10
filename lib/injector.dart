

import 'package:flutter_ticket/core/helpers/helpers.dart';
import 'package:flutter_ticket/repositories/app_repository.dart';
import 'package:flutter_ticket/repositories/location_repository.dart';
import 'package:flutter_ticket/repositories/task_repository.dart';
import 'package:get_it/get_it.dart';

class Injector {
  Injector._();

  static void init() {
    // Repositories
    GetIt.I.registerFactory(() => FirestoreCollections());
    GetIt.I.registerFactory(() => LocationRepository());
    GetIt.I.registerFactory(() => AppRepository(collections: GetIt.I()));
    GetIt.I.registerFactory(() => TicketRepository(collections: GetIt.I()));

  }
}
