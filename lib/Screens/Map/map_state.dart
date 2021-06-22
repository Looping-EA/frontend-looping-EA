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
import '../../Models/location.dart';


class MapState extends State<MapScreen>{
  final User user;
  MapState(this.user);
  MapController mapController = MapController();

  latlong.LatLng initialCenter = latlong.LatLng(41.27566856627529, 1.9866797924085564);
  double currentZoom = 10.0;

  var ihaveapoint = 0;
  var onlyonepoint = 0;
  var updateallowed = 0;
  var state = 0;
  
  String mylatitude = "";
  String mylongitude = "";

  String latitudestring = "";
  String longitudestring = "";

  List<Location> loc = [];
  
  @override
  void initState() {
    super.initState();
    // try {
    getLocations().then((result) {
      setState(() {
        loc = result;
        print("Hola");
        print(loc);
      });
    });
    // } catch (e) {
    //   print(e);
  }


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
      builder: (ctx) => Icon(Icons.pin_drop, size: 40.0, color: Colors.black),
    )
  ];
 

  @override
  Widget build(BuildContext context) {

    _initialisemarkers();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Where are the other loopers located?", textAlign: TextAlign.center),
      ),
      drawer: SideMenu(user: this.user),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: initialCenter,
          zoom: currentZoom,
          onTap: (pos){
            print(pos);
            if(ihaveapoint==0 && onlyonepoint==0){
              _setmarker(pos);
              _stringposition(pos);
              _createLocation();
              onlyonepoint=1;
            }
            if(updateallowed==1){
              _setmarker(pos);
            }
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
            tooltip: 'Zoom In',
            child: Icon(Icons.add_circle_outline_rounded),
            backgroundColor: Colors.blueGrey
          ),
          FloatingActionButton(
            onPressed: _zoomout,
            tooltip: 'Zoom Out',
            child: Icon(Icons.remove_circle_outline_rounded),
            backgroundColor: Colors.blueGrey
          ),
          FloatingActionButton(
            onPressed: _updatepoint,
            tooltip: 'Update Location',
            child: Icon(Icons.upgrade_rounded),
            backgroundColor: Colors.blueGrey
          ),
          FloatingActionButton(
            onPressed: _deletepoint,
            tooltip: 'Delete Location',
            child: Icon(Icons.highlight_remove_rounded),
            backgroundColor: Colors.blueGrey
          ),
        ],
      ),

    );
  }

  //////////////////// FUNCTIONS
  
  void _updatepoint(){
    updateallowed = 1;
  }
  
  void _deletepoint(){
    for(int i=0; i < loc.length; i++) {
      if(user.uname == loc[i].uname){
        print(user.uname);
        print(loc[i].uname);
        for(int j=0; i < markers.length; j++){
          if(loc[i].latitude==markers[j].point.latitude.toString() && loc[i].longitude==markers[j].point.longitude.toString()){
            print(j);
            print(markers[j].point.longitude.toString());
            markers.removeAt(j);
            loc.removeAt(i);
            setState(() {
              int i = (markers.length/2).round();
              markers.removeRange(i, markers.length);
              markers = List.from(markers);
              state++;
            });
            break;
          }
        }
      }
    }
    deleteLocation(user.uname);
    ihaveapoint=0;
    onlyonepoint=0;

  }

  void _zoomin() {
    currentZoom = currentZoom + 0.5;
    var currentCenter = latlong.LatLng(mapController.center.latitude, mapController.center.longitude);
    mapController.move(currentCenter, currentZoom);
  }

  void _zoomout() {
    currentZoom = currentZoom - 0.5;
    var currentCenter = latlong.LatLng(mapController.center.latitude, mapController.center.longitude);
    mapController.move(currentCenter, currentZoom);
  }

  void _setmarker(pos){
    
    if(updateallowed==1){
      for(int i=0; i < loc.length; i++){
        if(user.uname == loc[i].uname){
          Marker mark = Marker(
            anchorPos: AnchorPos.align(AnchorAlign.center),
            height: 40,
            width: 40,
            point: latlong.LatLng(pos.latitude, pos.longitude),
            builder: (ctx) => Icon(Icons.pin_drop, size: 40.0, color: Colors.black),
          );
          for(int j=0; j < markers.length; j++){
            if(loc[i].latitude==markers[j].point.latitude.toString() && loc[i].longitude==markers[j].point.longitude.toString()){
              markers[j]=mark;
              loc[i].latitude=mark.point.latitude.toString();
              loc[i].longitude=mark.point.longitude.toString();
              updateallowed = 0;
              mylatitude = mark.point.latitude.toString();
              mylongitude = mark.point.longitude.toString();
              _updateLocation();
              break;
            }
          }  
        }
      }
      setState(() {
        int i = (markers.length/2).round();
        markers.removeRange(i, markers.length);
        markers = List.from(markers);
        state++;
        print(markers.length);
      });
    }
    else{
      Marker mark = Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 40,
        width: 40,
        point: latlong.LatLng(pos.latitude, pos.longitude),
        builder: (ctx) => Icon(Icons.pin_drop, size: 40.0, color: Colors.black),
      );
      markers.add(mark);
      setState((){
        markers = List.from(markers);
        state++;
        print(markers.length);
      });
    }
  }

  void _setinitialmarkers(pos){
    Marker mark = Marker(
      anchorPos: AnchorPos.align(AnchorAlign.center),
      height: 40,
      width: 40,
      point: latlong.LatLng(pos.latitude, pos.longitude),
      builder: (ctx) => Icon(Icons.pin_drop, size: 40.0, color: Colors.black),
    );
    markers.add(mark);
    setState((){
      markers = List.from(markers);
      state++;
    });
  }

  void _stringposition(pos){
    latitudestring = pos.latitude.toString();
    longitudestring = pos.longitude.toString();
    mylatitude = latitudestring;
    mylongitude = longitudestring;
    print(latitudestring);
    print(longitudestring);
  }



  void _initialisemarkers(){

    for(int i=0; i < loc.length; i++) {

      if(user.uname == loc[i].uname){
        ihaveapoint = 1;
        mylatitude = loc[i].latitude;
        mylongitude = loc[i].longitude;
      }

      var dlatitude = double.parse(loc[i].latitude);
      var dlongitude = double.parse(loc[i].longitude);
      assert(dlatitude is double);
      assert(dlongitude is double);
      latlong.LatLng coordinates = latlong.LatLng(dlatitude,dlongitude);
      _setinitialmarkers(coordinates);
    }

  }

  ///////////////////// SERVICES
  Future<String> deleteLocation(uname) async {
  String? token;
  try {
    await getTokenFromSharedPrefs().then((value) => token = value);
    print(token);
  } catch (err) {
    print(err);
  }
  String exito = "deleted";
  String fail = "failed";
  final body = {
    "uname": uname,
  };
  final bodyParsed = json.encode(body);
  final response = await http.delete(
      Uri.parse('http://localhost:8080/api/location/delete'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: bodyParsed);

  print(response.statusCode);
  if (response.statusCode == 201) {
    return exito;
  } else
    return fail;
  }

  Future<List<Location>> getLocations() async {
    List<Location> locations = [];
    String? token;
    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
      print(token);
      print("token printed above");
    } catch (err) {
      print(err);
    }

    final response = await http
        .get(Uri.parse('http://localhost:8080/api/location/'), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 201) {
      var locationsJson = json.decode(response.body);
      try {
        for (var locationJson in locationsJson) {
          /*List<User> ownerslist = [];
          for (int i = 0; i < locationJson["owners"].length; i++) {
            User u = new User(locationJson["owners"][i]["uname"], "", "", "");
            ownerslist.add(u);
            print(u.uname);
          }*/
      
          locations.add(Location(
              locationJson["uname"],
              locationJson["latitude"],
              locationJson["longitude"],
              ));
        }
      } catch (e) {
        print(e);
      }
    }

    return locations;
  }

  Future<Location> _createLocation() async {
    Location location = new Location("", "", "");

    String? token;
    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
      print(token);
      print("token printed above");
    } catch (err) {
      print(err);
    }

    // create JSON object
    final body = {
      "uname": user.uname,
      "latitude": mylatitude,
      "longitude": mylongitude,
    };
    final bodyParsed = json.encode(body);


    // finally the POST HTTP operation
    return await http
        .post(Uri.parse("http://localhost:8080/api/location/add"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
            body: bodyParsed)
        .then((http.Response response) {
      if (response.statusCode == 201) {
        return Location.fromJson(json.decode(response.body));
      } else {
        return new Location("", "", "");
      }
    });
  }

  Future<Location> _updateLocation() async {
    Location location = new Location("", "", "");

    String? token;
    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
      print(token);
      print("token printed above");
    } catch (err) {
      print(err);
    }

    // create JSON object
    final body = {
      "uname": user.uname,
      "latitude": mylatitude,
      "longitude": mylongitude,
    };
    final bodyParsed = json.encode(body);


    // finally the PUT HTTP operation
    return await http
        .put(Uri.parse("http://localhost:8080/api/location/update"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
            body: bodyParsed)
        .then((http.Response response) {
      if (response.statusCode == 201) {
        return Location.fromJson(json.decode(response.body));
      } else {
        return new Location("", "", "");
      }
    });
  }
}