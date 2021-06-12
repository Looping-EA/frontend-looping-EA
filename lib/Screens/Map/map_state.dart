import 'dart:math';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Screens/Map/map_screen.dart';
import 'package:frontend_looping_ea/Screens/feed/feed_proyectos.dart';
import 'package:frontend_looping_ea/Shared/side_menu.dart';
import 'package:frontend_looping_ea/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend_looping_ea/Models/project.dart';
import 'package:frontend_looping_ea/Screens/CreateProject/createproject_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Models/project.dart';
import 'package:intl/intl.dart';

import '../../Shared/shared_preferences.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;


class MapState extends State<MapScreen>{
  final User user;
  MapState(this.user);
  MapController mapController = MapController();

  latlong.LatLng currentCenter = latlong.LatLng(41.27566856627529, 1.9866797924085564);
  double currentZoom = 10.0;

  List<Marker> markers = [
    Marker(
      anchorPos: AnchorPos.align(AnchorAlign.center),
      height: 40,
      width: 40,
      point: latlong.LatLng(41.37977373448749, 2.1118357902301097),
      builder: (ctx) => Icon(Icons.pin_drop, size: 40.0, color: Colors.black),
      ),
    Marker(
      anchorPos: AnchorPos.align(AnchorAlign.center),
      height: 40,
      width: 40,
      point: latlong.LatLng(41.37977373448749, 2.1624357902301097),
      builder: (ctx) => Icon(Icons.pin_drop, size: 40.0, color: Colors.blue),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Where are the other loopers located?", textAlign: TextAlign.center),
      ),
      drawer: SideMenu(user: this.user),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: currentCenter,
          zoom: currentZoom,
          onTap: (pos){
            print(pos);
            _setmarker(pos);
          }
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']
          ),
          MarkerLayerOptions(
            rotateAlignment: Alignment.center,            
            markers: markers,
          )
        ]
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _zoomin,
            tooltip: 'Zoom',
            child: Icon(Icons.add_circle_outline_rounded),
          ),
          FloatingActionButton(
            onPressed: _zoomout,
            tooltip: 'Zoom',
            child: Icon(Icons.remove_circle_outline_rounded),
          ),
        ],
      ),

    );
  }
  
  void _zoomin() {
    currentZoom = currentZoom + 0.5;
    mapController.move(currentCenter, currentZoom);
  }

  void _zoomout() {
    currentZoom = currentZoom - 0.5;
    mapController.move(currentCenter, currentZoom);
  }

  void _setmarker(pos){
    Marker mark = Marker(
      anchorPos: AnchorPos.align(AnchorAlign.center),
      height: 40,
      width: 40,
      point: latlong.LatLng(pos.latitude, pos.longitude),
      builder: (ctx) => Icon(Icons.pin_drop, size: 40.0, color: Colors.red),
    );
    markers.add(mark);
    setState((){
      markers = List.from(markers);
    });
  }

}



/*          MarkerLayerOptions(
            markers: [
              Marker(
                width: 20.0,
                height: 20.0,
                point: latlong.LatLng(41.37977373448749, 2.1218357902301097),
                builder: (ctx) =>
                Container(
                  child: Text(this.user.uname, style: TextStyle(fontSize: 10.0, color: Colors.white))
                ),
              ),
            ],
          )*/

     /*     MarkerClusterLayerOptions(
            builder: (context, markers){
              return FloatingActionButton(
                child: Text(markers.length.toString()),
                onPressed: null,
              );
            },
            maxClusterRadius: 120,
            size: Size(40, 40),
            fitBoundsOptions: FitBoundsOptions(padding: EdgeInsets.all(50)),
            markers: markers,
            polygonOptions: PolygonOptions(
              borderColor: Colors.blueAccent,
              color: Colors.black12,
              borderStrokeWidth: 3),
          ),*/