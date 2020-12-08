

import 'package:marker/redux/models/Drawing.dart';
import 'package:redux/redux.dart';
import 'package:marker/redux/actions/ThoughtAction.dart';

final isLoadingReducer = combineReducers<bool>([TypedReducer<bool, IsLoadingAction>(_saveIsLoading)]);
bool _saveIsLoading(bool isLoading, IsLoadingAction action) => action.isLoading;



final addDrawingReducer = combineReducers<List<Drawing>>([
  // TypedReducer<List<Drawing>, AddDrawingAction>(_saveDrawing),
  TypedReducer<List<Drawing>, AddMarkerAction>(_saveMarkers),
  TypedReducer<List<Drawing>, SaveAllDrawingsAction>(_saveAllDrawings),
]);
// List<Drawing> _saveDrawing(List<Drawing> drawings, AddDrawingAction action){
//   drawings.add(
//     Drawing(
//       // id: action.,
//       name: action.name,
//       thumbnail: action.file.path,
//       markers: [],
//       time: DateTime.now()
//     )
//   );

//   return drawings;
// }


List<Drawing> _saveMarkers(List<Drawing> drawings, AddMarkerAction action){
  int index = drawings.indexWhere((element) => element.id == action.drawing.id);
  drawings[index] = action.drawing;
  return drawings;
}


List<Drawing> _saveAllDrawings(List<Drawing> drawings, SaveAllDrawingsAction action){
  // int index = drawings.indexWhere((element) => element.id == action.drawing.id);
  // drawings[index] = action.drawing;
  return action.drawings;
}

final selectedDrawingReducer = combineReducers<int>([TypedReducer<int, SelectedDrawingAction>(_saveSelectedDrawing)]);
int _saveSelectedDrawing(int isLoading, SelectedDrawingAction action) => action.index;



final selectedMarkerReducer = combineReducers<int>([TypedReducer<int, SelectedMarkerIndexAction>(_saveSelectedMarker)]);
int _saveSelectedMarker(int isLoading, SelectedMarkerIndexAction action) => action.markerIndex;