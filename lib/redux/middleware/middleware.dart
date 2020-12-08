import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:marker/redux/middleware/InitMiddleware.dart';
import 'package:marker/redux/middleware/navigation_middleware.dart';
import 'package:marker/redux/models/app_state.dart';
import 'package:marker/redux/services/WPService.dart';
import 'package:sqflite/sqlite_api.dart';

List<Middleware<AppState>> createMiddleWare(
  GlobalKey<NavigatorState> navigatorKey,
  Database db,
  // Database database
  
  // GitaService gitaService,
  // // CalenderService calenderService,
  // FirebaseRtDbService firebaseRtDbService,
  // SharedPrefService sharedPrefService,
  // TimerService timerService,
)
{
  return [
    ...initMiddleware(db),
    ...createNavigationMiddleware(navigatorKey),
    
  ];
}