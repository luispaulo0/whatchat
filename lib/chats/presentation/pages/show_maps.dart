import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ShowMaps extends StatefulWidget {
  final double latitude;
  final double longitude;

  ShowMaps({required this.latitude, required this.longitude});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<ShowMaps> {
  GoogleMapController? _controller;
  late LocationData _currentLocation;
  Location _location = Location();
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _addMarker();
  }

  void _addMarker() {
    LatLng posicion = LatLng(widget.latitude, widget.longitude);
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('Marcador'),
          position: posicion,
          infoWindow: InfoWindow(title: 'Marcador'),
        ),
      );
    });
  }

  void _getCurrentLocation() async {
    try {
      final LocationData locationData = await _location.getLocation();
      setState(() {
        _currentLocation = locationData;
      });
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(widget.latitude, widget.longitude),
            zoom: 14.0,
          ),
        ),
      );

      // saveLocationToFirebase(locationData.latitude!, locationData.longitude!);
    } catch (e) {
      print("Error al obtener la ubicación: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Maps'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            _controller = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 12.0,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: _markers,
      ),
    );
  }
}
