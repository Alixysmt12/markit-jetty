import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:markit_jetty/controller/lat_long_controller.dart';
import 'package:markit_jetty/models/lat_long_field_map.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  //late List<GoogleLatLongField> _latLong;
  late List<Marker> _latLong;

  //var field = Get.find<LatLongController>();

  @override
  void initState() {
    super.initState();

    getLatLongData();

    //_latLong = getLatLongData();
    //_marker.addAll(_list);
    //_lateLongModel.addAll(field.latLongList);
    //_marker.addAll(_latLong);
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.269168019956247, 67.28434283492946),
    zoom: 8.4746,
  );

  List<Marker> _marker = [];
  List<Marker> _list = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(25.269168019956247, 67.28434283492946),
      infoWindow: InfoWindow(title: 'Karachi'),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(24.903506897987043, 67.03715045349361),
      infoWindow: InfoWindow(title: 'Frere Hall'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(_marker),
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }


  void getLatLongData(){
    setState(() {

    });

    var field = Get.find<LatLongController>();
    //field.mGetLatLong();
    print("Lat Long Inside Google Class " + field.latLongList.toString());
    field.latLongList.length;

    List<Marker> _markerList = [];
    if(field.latLongList.length > 0) {
      for (int i = 0; i < field.latLongList.length; i++) {
        _markerList.add(Marker(
          markerId: MarkerId(field.latLongList[i].lat),
          position: LatLng(double.parse(field.latLongList[i].lat),
              double.parse(field.latLongList[i].lng)),
        ));
      }
      _marker.addAll(_markerList);
    }
  }

/*  List<Marker> getLatLongData() {
    var field = Get.find<LatLongController>();
    field.mGetLatLong();
    print("Lat Long Inside Google Class " + field.latLongList.toString());
    field.latLongList.length;
    List<Marker> _markerList = [];
    for (int i = 0; i < field.latLongList.length; i++) {
      _markerList.add(Marker(
        markerId: MarkerId(field.latLongList[i].lat),
        position: LatLng(double.parse(field.latLongList[i].lat),
            double.parse(field.latLongList[i].lng)),
      ));
      *//*_markerList = [
        Marker(
          markerId: MarkerId(field.latLongList[i].lat),
          position: LatLng(double.parse(field.latLongList[i].lat),
              double.parse(field.latLongList[i].lng)),
        )
      ];*//*
    }

    return _markerList;
  }*/

/*  List<GoogleLatLongField> getLatLongData() {
    var field = Get.find<LatLongController>();
    field.mGetLatLong();
    print("Lat Long Inside Google Class " + field.latLongList.toString());
    field.latLongList.length;

    for (int i = 0; i < field.latLongList.length; i++) {
      List<Marker> _marker = [
        Marker(
          markerId: MarkerId(field.latLongList[i].lat),
          position: LatLng(double.parse(field.latLongList[i].lat),
              double.parse(field.latLongList[i].lng)),
        )
      ];
    }

    List<Marker> _marker = [];

    return field.latLongList;
  }*/
}
