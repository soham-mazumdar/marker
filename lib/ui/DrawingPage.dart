import 'dart:io';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:marker/redux/actions/ThoughtAction.dart';
import 'package:marker/redux/actions/navigator_actions.dart';
import 'package:marker/redux/models/Drawing.dart';
import 'package:marker/redux/models/app_state.dart';
import 'package:marker/ui/DrawGestureDetector.dart';
import 'package:marker/util/ui_constants.dart';

class DrawingPage extends StatefulWidget {
  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  // double _posX, _posY;
  bool addMarker = false;
  // TextEditingController _markerNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, dynamic>>(
      converter: (store) {
        final Map<String, dynamic> args = {
          "isLoading": store.state.isLoading,
          "selectedDrawing": store.state.selectedDrawing,
          "drawings": store.state.drawings,
          "selectedMarker": store.state.selectedMarker,
          "fn": (File file, String name) {
            store.dispatch(AddDrawingAction(file: file, name: name));
          },
          "navigate": (navTo, index) {
            store.dispatch(SelectedDrawingAction(index: index));
            return store.dispatch(NavigatorPushAction(navTo));
          },
          "selectMarker": (int _marker) {
            store.dispatch(SelectedMarkerIndexAction(_marker));
          },
        };
        return args;
      },
      builder: (context, args) {
        final int selectedDrawing = args["selectedDrawing"];
        final List<Drawing> drawings = args["drawings"];
        final int selectedMarker = args["selectedMarker"];
        final Function selectMarker = args["selectMarker"];
        Drawing drawing =
            drawings.singleWhere((element) => element.id == selectedDrawing);

        return Scaffold(
            appBar: AppBar(
              title: Text('Drawing Page'),
            ),
            body: Column(
              // drawings
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        child: DrawGestureDetector(
                          addMarker: addMarker,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: ButtonBar(
                          children: [
                            RaisedButton(
                              onPressed: () {
                                setState(() {
                                  addMarker = !addMarker;
                                });
                              },
                              color: AppColors.primary,
                              child: addMarker
                                  ? Text('Done')
                                  : Text('Add Markers'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      color: Colors.white,
                      child: drawing.markers.isEmpty
                          ? ListTile(
                              title: Text('No Markers Yes'),
                            )
                          : ListView.builder(
                              itemCount: drawing.markers.length,
                              itemBuilder: (context, index) {
                                
                                return ListTile(
                                  onTap: () {
                                    selectMarker(index);
                                  },
                                  tileColor: selectedMarker == index
                                      ? AppColors.primary
                                      : Colors.white,
                                  title: Text(drawing.markers[index].title),
                                  subtitle: Text(
                                    timeago.format(drawing.markers[index].time)
                                  )
                                    // DateFormat('yyyy-MM-dd – kk:mm').format(drawings[index].time).toString())
                                      // drawing.markers[index].time.toString()),
                                  // trailing: Text(
                                  //     drawing.markers[index].posY.toString()),
                                );
                              })),
                )
              ],
            ));
      },
    );
  }
}
