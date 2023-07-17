import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatchat/chats/presentation/usecases.dart';

import '../../domain/entities/mensaje.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Maps extends StatefulWidget {
  final String emisorId;
  final String receptorId;
  final String uidM;
  final UseCases useCases;

  Maps({
    required this.emisorId,
    required this.receptorId,
    required this.uidM,
    required this.useCases,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<Maps> {
  GoogleMapController? _controller;
  late LocationData _currentLocation;
  Location _location = Location();
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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
            target: LatLng(locationData.latitude!, locationData.longitude!),
            zoom: 14.0,
          ),
        ),
      );
    } catch (e) {
      print("Error al obtener la ubicación: $e");
    }
  }

  void _addMarker(LatLng position, String markerId) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: position,
          infoWindow: InfoWindow(title: markerId),
        ),
      );
    });
  }

  void _enviarUbicacion(double latitude, double longitude) async {
    GeoPoint ubicacion = GeoPoint(latitude, longitude);
    print('enviar mensaje tipo ubicacion');
    await widget.useCases.enviarUbicacion!.execute(
      widget.uidM,
      widget.emisorId,
      widget.receptorId,
      ubicacion,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: GoogleMap(
              onMapCreated: (controller) {
                setState(() {
                  _controller = controller;
                });
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.7749, -122.4194),
                zoom: 12.0,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: _markers,
              onTap: (LatLng position) {
                _addMarker(position, 'Marcador');
              },
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                _enviarUbicacion(
                  _markers.first.position.latitude,
                  _markers.first.position.longitude,
                );
                Navigator.pop(context);
                setState(() {});
              },
              child: const Text('Enviar Ubicación'),
            ),
          ),
        ],
      ),
    );
  }
}
