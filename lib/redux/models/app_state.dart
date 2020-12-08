import 'package:marker/redux/models/Drawing.dart';
import 'package:marker/redux/routes/routes.dart';

class AppState {
  final bool isLoading;
  final List<String> routes;
  final List<Drawing> drawings;
  final int selectedDrawing;
  final int selectedMarker;
  

  AppState({
    this.isLoading,
    this.routes,
    this.drawings,
    this.selectedDrawing,
    this.selectedMarker
  });

  factory AppState.initial(){
    return AppState(
      isLoading: true,
      routes: [AppRoutes.home],
      drawings: [],
      selectedDrawing: null,
      selectedMarker: null
    );
  }

  AppState copyWith({
    bool newIsLoading,
    List<String> newRoutes,
    List<Drawing> newDrawings,
    int newSelectedDrawing,
    int newSelectedMarker
  })
  {
    return AppState(
      isLoading: newIsLoading ?? this.isLoading,
      routes: newRoutes ?? this.routes,
      drawings: newDrawings ?? this.drawings,
      selectedDrawing: newSelectedDrawing ?? this.selectedDrawing,
      selectedMarker: newSelectedMarker ?? this.selectedMarker
    );
  }
}