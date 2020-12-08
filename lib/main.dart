import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:marker/ui/DrawingPage.dart';
import 'package:marker/ui/HomePage.dart';
import 'package:path/path.dart';
import 'package:redux/redux.dart';
import 'package:marker/redux/actions/action.dart';
import 'package:marker/redux/middleware/middleware.dart';
import 'package:marker/redux/models/app_state.dart';
import 'package:marker/redux/reducers/base_reducer.dart';
import 'package:marker/redux/routes/routes.dart';
import 'package:marker/util/ui_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Future<Database> database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'draw.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        "CREATE TABLE draw(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, time TEXT, thumbnail TEXT, markers TEXT)",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  final Database db = await database;
  
  final Store<AppState> store = Store<AppState>(
    baseReducer,
    initialState: AppState.initial(),
    
    middleware: createMiddleWare(
      navigatorKey,
      // WPService(),
      db
    )
  );
  store.dispatch(InitAppAction());
  return runApp(HindApp(store));
}

class HindApp extends StatelessWidget {
  
  final Store<AppState> store;

  HindApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner : false,
        navigatorKey:navigatorKey,
        navigatorObservers: [routeObserver],
        theme: getThemeData(),
        onGenerateRoute: (RouteSettings settings) => _resolveRoute(settings),
      ),
    );
  }

  MaterialPageRoute _resolveRoute(RouteSettings settings)
	{
		switch(settings.name)
		{
			case AppRoutes.markers:
		   	return FabRoute(DrawingPage(), settings: settings, duration: 400);//, direction: 'right');
      default :
        return MainRoute(HomePage(), settings : settings,);
		}
	}
}

