import 'dart:convert';

import 'package:marker/redux/models/Marker.dart';

class Drawing {
  int id;
  final String name;
  final DateTime time;
  final String thumbnail;
  final List<Marker> markers;
  
  Drawing({
    this.id,
    this.name,
    this.time,
    this.thumbnail,
    this.markers,
  });

  factory Drawing.fromJson(Map<String, dynamic> json) {
    var markers = json['markers'] == null ? [] : jsonDecode(json['markers']) ;
    List<Marker> _markers = [];
    if(markers != null)
    markers.forEach((element) { 
        _markers.add(Marker.fromJson(element));
        
    });
    // print('likes : ' + likes);
    return Drawing(
      id: json['id'],
      name: json['name'],
      time: DateTime.parse(json['time']),
      thumbnail: json['thumbnail'],
      markers: _markers
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'time': time.toIso8601String(),
      'thumbnail': thumbnail,
      "markers": jsonEncode(markers)// markers.asMap() // != null ? markers.asMap() : null
    };
  }
  
}