
import 'dart:io';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marker/redux/actions/ThoughtAction.dart';
import 'package:marker/redux/actions/navigator_actions.dart';
import 'package:marker/redux/models/Drawing.dart';
import 'package:marker/redux/models/app_state.dart';
import 'package:marker/redux/routes/routes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  File _image;
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, dynamic>>(
      converter: (store) {
        final Map<String, dynamic> args = {
          "isLoading": store.state.isLoading,
          "drawings": store.state.drawings,
          "fn": (File file, String name) {
            store.dispatch(AddDrawingAction(file:file , name:name));
          },
          "navigate": (navTo, index) {
            store.dispatch(SelectedDrawingAction(index:index));
            return store.dispatch(NavigatorPushAction(navTo));
          },
        };
        return args;
      },
      builder: (context, args) {
        final List<Drawing> drawings = args["drawings"];
        final Function fn = args["fn"];
        final Function navigate = args["navigate"];
        
        
        // print(drawings.toString());

        return Scaffold(
            appBar: AppBar(
              title: Text('Home Paga'),
            ),
            body: Column(
              // drawings
              children: [
                Container(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final picker = ImagePicker();
                          final PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
                          
                          setState(() {
                            if (pickedFile != null) {
                              _image = File(pickedFile.path);
                            } else {
                              // print('No image selected.');
                            }
                          });
                        },
                        child: _image != null ? 
                        Image.file(_image) :  
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color: Colors.pink
                          ),
                          child: Text('Select Drawing',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      SizedBox(height:20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                                              child: TextFormField(
                          style: Theme.of(context).textTheme.subtitle2,
                          controller: _nameController,
                          decoration: InputDecoration(
                            filled: true,
                            // fillColor: Colors.white,
                            errorStyle: TextStyle(color: Colors.black),
                            hintText: "Drawing's Name",
                            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(35.0)),
                              // borderSide: BorderSide(width: 2,color: Colors.white)
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(35.0)),
                              // borderSide: BorderSide(width: 2,color: Colors.white)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(35.0)),
                              // borderSide: BorderSide(width: 2,color: Colors.white)
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(35.0)),
                              // borderSide: BorderSide(width: 1,color: Colors.white)
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(35.0)),
                              borderSide: BorderSide(width: 1,color: Colors.white)
                            ),
                            // focusedErrorBorder: ,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            // focusColor: Colors.white,
                            
                          ),
                          validator: (value){
                            if (value.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height:20),
                      GestureDetector(
                        onTap: () async {
                          if(_nameController.text == ''){
                            // 
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  // title: Text("My title"),
                                  content: Text("drawing needs a name"),
                                  actions: [
                                    FlatButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          else if(_image == null){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  // title: Text("My title"),
                                  content: Text("need to select a drawing"),
                                  actions: [
                                    FlatButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          else{
                            fn(_image, _nameController.text);
                            setState(() {
                              _image = null;
                              _nameController.text = '';
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.amberAccent
                          ),
                          child: Text('Submit')
                        ),
                      ),
                      

                    ],
                  ),
                  
                )
                ,
                Expanded(
                  child: drawings.isEmpty ? 
                      ListTile(
                        title: Text('No Drawing yet'),
                      )
                      : ListView.builder(
                        itemCount: drawings.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        contentPadding: EdgeInsets.all(7),
                        onTap: (){
                          navigate(AppRoutes.markers, drawings[index].id);
                        },
                        leading: Container(width: 100, height: 100, clipBehavior: Clip.none,  child: Image.file(File(drawings[index].thumbnail)),), //CircleAvatar(child: Image.file(File(drawings[index].thumbnail))),),
                        title: Text(drawings[index].name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(DateFormat('yyyy-MM-dd – kk:mm').format(drawings[index].time).toString()),
                            Text(timeago.format(drawings[index].time)),
                            Text('Markers : ' + drawings[index].markers.length.toString()),
                          ],
                        )

                      ) ;
                    }
                  )
                )
              ],
            )
          );
      },
    );
  }
}

