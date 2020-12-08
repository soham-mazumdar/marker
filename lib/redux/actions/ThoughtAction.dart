import 'dart:io';

import 'package:marker/redux/actions/action.dart';
import 'package:marker/redux/models/Drawing.dart';
import 'package:marker/redux/models/Marker.dart';

class IsLoadingAction extends AppAction{
  final bool isLoading;
  IsLoadingAction(this.isLoading);

  @override String toString() => "IsLoadingAction{$isLoading}";
}

class AddDrawingAction extends AppAction{

  final File file;
  final String name;  
  AddDrawingAction({this.file, this.name});

  @override String toString() => "IsLoadingAction{$file, $name}";
}


class SaveDrawingAction extends AppAction{

  final Drawing drawing;
  // final int id;  
  SaveDrawingAction(this.drawing);

  @override String toString() => "IsLoadingAction{$drawing}";
}

class SaveAllDrawingsAction extends AppAction{

  final List<Drawing> drawings;
  // final int id;  
  SaveAllDrawingsAction(this.drawings);

  @override String toString() => "IsLoadingAction{$drawings}";
}



class SelectedDrawingAction extends AppAction{
  
  final int index;
  
  SelectedDrawingAction({this.index});

  @override String toString() => "SelectedDrawingAction{$index}";
}


class AddMarkerAction extends AppAction{
  
  final Marker marker;
  final Drawing drawing;
  
  AddMarkerAction({this.marker, this.drawing});

  @override String toString() => "SelectedDrawingAction{$marker, $drawing}";
}


class SelectedMarkerIndexAction extends AppAction{
  
  final int markerIndex;
  
  SelectedMarkerIndexAction(this.markerIndex);

  @override String toString() => "SelectedDrawingAction{$markerIndex}";
}