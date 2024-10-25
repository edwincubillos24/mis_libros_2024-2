import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailStorePage extends StatefulWidget {
  var store;

  DetailStorePage(this.store);

  @override
  State<DetailStorePage> createState() => _DetailStorePageState(store);
}

class _DetailStorePageState extends State<DetailStorePage> {
  var store;

  _DetailStorePageState(this.store);

  final Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = Set<Marker>();

  void _showMarkers(){
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(store['name']),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(store['latitude'], store['longitude']),
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: LatLng(store['latitude'],store['longitude']), zoom: 14.5),
        markers: _markers,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
          _showMarkers();
        },
      )
    );
  }
}
