import 'dart:convert';

import 'package:marker/redux/actions/ThoughtAction.dart';
import 'package:marker/redux/models/Drawing.dart';
import 'package:marker/redux/models/Marker.dart';
import 'package:path/path.dart';
import 'package:redux/redux.dart';
import 'package:marker/redux/actions/action.dart';
import 'package:marker/redux/models/app_state.dart';
import 'package:marker/redux/services/WPService.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

List<Middleware<AppState>> initMiddleware(
  Database db,
){
	return[
    TypedMiddleware<AppState, InitAppAction>(_init(db)),
    TypedMiddleware<AppState, AddDrawingAction>(_addDrawingAction(db)),
    TypedMiddleware<AppState, AddMarkerAction>(_addMarkerAction(db)),
    
    
	];
}

void Function(Store<AppState> store, InitAppAction action, NextDispatcher next)
_init(Database db)
{
  return (store, action, next) async {
    
    // final Future<Database> database = openDatabase(
    //   join(await getDatabasesPath(), 'draw.db'),
    //   version: 1,
    // );
    

    // final Database db = await database;

    
    await db.query(
      'draw',
    ).then((value){
      List<Drawing> _drawings = [];
      value.forEach((element) { 
        _drawings.add(Drawing.fromJson(element));
      });
      store.dispatch(SaveAllDrawingsAction(_drawings));
    });

    next(action);
  };
}


void Function(Store<AppState> store, AddDrawingAction action, NextDispatcher next)
_addDrawingAction(Database db)
{
  return (store, action, next) async {
    
    // final Future<Database> database = openDatabase(
    //   join(await getDatabasesPath(), 'draw.db'),
    //   // onCreate: (db, version) {
    //   //   return db.execute(
    //   //     "CREATE TABLE draw(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, time TEXT, thumbnail TEXT, markers TEXT)",
    //   //   );
    //   // },
    //   version: 1,
    // );

    // final Database db = await database;

    Drawing drawing = Drawing(name: action.name, thumbnail: action.file.path, time: DateTime.now(), markers: []);

    
    await db.insert(
      'draw',
      drawing.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    ).then((value){
      drawing.id = value;
      store.dispatch(SaveDrawingAction(drawing));
      
      List<Drawing> _dr = store.state.drawings;
      _dr.add(drawing);


      store.dispatch(SaveAllDrawingsAction(_dr));
    });
    next(action);
  };
}


void Function(Store<AppState> store, AddMarkerAction action, NextDispatcher next)
_addMarkerAction(Database db)
{
  return (store, action, next) async {
    
    
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'draw.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE draw(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, time TEXT, thumbnail TEXT, markers TEXT)",
        );
      },
      version: 1,
    );

    

    final Database db = await database;
    List<Marker> _markers = [];
    action.drawing.markers.forEach((element) {
      _markers.add(element);
    });
    
    Drawing drawing = Drawing(id: action.drawing.id, name: action.drawing.name, thumbnail: action.drawing.thumbnail, time: action.drawing.time, markers: _markers);

    
    await db.rawUpdate('''
    UPDATE draw 
    SET name = ?, thumbnail = ?, time = ?, markers = ?
    WHERE id = ?
    ''', 
    [drawing.name, drawing.thumbnail, drawing.time.toIso8601String(), jsonEncode(drawing.markers), drawing.id]).then((value){
      store.dispatch(SaveDrawingAction(drawing));
    }).catchError((onError){
      print('2 : ' + onError.toString());
    });
    next(action);
  };
}