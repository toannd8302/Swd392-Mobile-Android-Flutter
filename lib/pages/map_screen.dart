import 'dart:async';

import 'package:fltter_30days/service/location_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  TextEditingController _searchController = TextEditingController();
  static final CameraPosition _kLake = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 19.151926040649414,
  );

  static final Marker _kLakeMarker = Marker(
    markerId: MarkerId('_kLakeMarker'),
    position: LatLng(37.43296265331129, -122.08832357078792),
    infoWindow: InfoWindow(title: 'Lake'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("グーグルマップ", style: TextStyle(color: Colors.white, fontSize: 20,)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(children: [
        Row(
          children: [
            Expanded(
                child: TextFormField(
              controller: _searchController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: "Search by City",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                print(value);
              },
            )),
            IconButton(
              onPressed: () async {
               var place = await locationService().getPlace(_searchController.text);
                _goToThePlace(place);
              },
              icon: Icon(Icons.search),
            )
          ],
        ),
        Expanded(
            child: GoogleMap(
          mapType: MapType.hybrid,
          markers: {
            _kLakeMarker,
          },
          initialCameraPosition: _kLake,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        )),
      ]),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }



  Future<void> _goToThePlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(lat, lng),
        zoom: 16,
      ),
    ));
  }
}
