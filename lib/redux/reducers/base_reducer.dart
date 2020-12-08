
import 'package:marker/redux/models/app_state.dart';
import 'package:marker/redux/reducers/ThoughtReducers.dart';
import 'package:marker/redux/reducers/navigation_reducer.dart';

AppState baseReducer(AppState oldState, dynamic action)
{
  return oldState.copyWith(
    newIsLoading: isLoadingReducer(oldState.isLoading, action),
    newRoutes: navigationReducer(oldState.routes, action),
    newDrawings: addDrawingReducer(oldState.drawings, action),
    newSelectedDrawing : selectedDrawingReducer(oldState.selectedDrawing, action),
    newSelectedMarker:  selectedMarkerReducer(oldState.selectedMarker, action),
    
  );
}