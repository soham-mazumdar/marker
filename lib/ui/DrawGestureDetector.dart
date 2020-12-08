import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:marker/redux/actions/ThoughtAction.dart';
import 'package:marker/redux/actions/navigator_actions.dart';
import 'package:marker/redux/models/Drawing.dart';
import 'package:marker/redux/models/Marker.dart';
import 'package:marker/redux/models/app_state.dart';
import 'package:marker/util/ui_constants.dart';

class DrawGestureDetector extends StatefulWidget {
  const DrawGestureDetector({
    Key key,
    @required this.addMarker,
    // this.callback
  }) : super(key: key);

  // final StringCallback callback;
  final bool addMarker;

  @override
  _DrawGestureDetectorState createState() => _DrawGestureDetectorState();
}

class _DrawGestureDetectorState extends State<DrawGestureDetector> {
  // double _posX, _posY;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, dynamic>>(converter: (store) {
      final Map<String, dynamic> args = {
        "isLoading": store.state.isLoading,
        "selectedDrawing": store.state.selectedDrawing,
        "drawings": store.state.drawings,
        "selectedMarker": store.state.selectedMarker,
        "fn": (Drawing _drawing) {
          store.dispatch(AddMarkerAction(drawing: _drawing));
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
    }, builder: (context, args) {
      List<Drawing> drawings = args["drawings"];
      int selectedDrawing = args["selectedDrawing"];
      Drawing drawing =
          drawings.singleWhere((element) => element.id == selectedDrawing);
      int selectedMarker = args["selectedMarker"];
      final Function selectMarker = args["selectMarker"];
      Function fn = args["fn"];

      final _formKey = GlobalKey<FormState>();
      TextEditingController _markerNameController = TextEditingController();

      return widget.addMarker ?
        GestureDetector(
          onTapDown: (TapDownDetails details) {
            if (widget.addMarker) {
              final RenderBox referenceBox = context.findRenderObject();

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Positioned(
                            right: -40.0,
                            top: -40.0,
                            child: InkResponse(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.close),
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _markerNameController,
                                    decoration: InputDecoration(
                                      hintText: 'Marker Name (required)',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    child: Text("Submit"),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        drawing.markers.add(Marker(
                                            posX: referenceBox
                                                .globalToLocal(
                                                    details.globalPosition)
                                                .dx,
                                            posY: referenceBox
                                                .globalToLocal(
                                                    details.globalPosition)
                                                .dy,
                                            time: DateTime.now(),
                                            title: _markerNameController.text));
                                        fn(drawing);
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
          },
          child: Stack(
            children: [
              Image.file(File(drawing.thumbnail)),
              for (var i = 0; i < drawing.markers.length; i++)
                // for (var marker in drawing.markers)
                Positioned(
                    // height: 20,
                    // width: 20,
                    top: drawing.markers[i].posY - 20,
                    left: drawing.markers[i].posX - 10,
                    child: GestureDetector(
                      onTap: () {
                        selectMarker(i);
                      },
                      child: Container(
                          width: 20,
                          height: 20,
                          child: selectedMarker == i
                              ? Icon(Icons.arrow_downward_outlined,color: AppColors.primary,size: 20,)
                              : Icon(Icons.arrow_downward_outlined,color: Colors.blue,size: 20,)
                      )
                    )),
            ],
          )
        
        )
        : InteractiveViewer(
            panEnabled: true, // Set it to false to prevent panning.
            boundaryMargin: EdgeInsets.all(80),
            minScale: 0.5,
            maxScale: 4,
            constrained: true,
            child: Stack(
              children: [
                Image.file(File(drawing.thumbnail)),
                for (var i = 0; i < drawing.markers.length; i++)
                  // for (var marker in drawing.markers)
                  Positioned(
                      // height: 20,
                      // width: 20,
                      top: drawing.markers[i].posY - 20,
                      left: drawing.markers[i].posX - 10,
                      child: GestureDetector(
                        onTap: () {
                          selectMarker(i);
                        },
                        child: Container(
                            width: 20,
                            height: 20,
                            child: selectedMarker == i
                                ? Icon(Icons.arrow_downward_outlined,color: AppColors.primary,size: 20,)
                              : Icon(Icons.arrow_downward_outlined,color: Colors.blue,size: 20,)
                        ),
                      )),
              ],
            ),
          );
        
        
    });
  }
}
