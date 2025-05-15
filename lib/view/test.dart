import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  Location location = Location();

  String _location = 'Unknown';

  Future<void> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    // Check if location service is enabled
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        setState(() {
          _location = 'Location service disabled';
        });
        return;
      }
    }

    // Check permission
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        setState(() {
          _location = 'Location permission denied';
        });
        return;
      }
    }

    // Get location
    _locationData = await location.getLocation();

    setState(() {
      _location =
          'Lat: ${_locationData.latitude}, Lon: ${_locationData.longitude}';
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Location Example')),
      body: Center(child: Text(_location)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.my_location),
        onPressed: _getLocation,
      ),
    );
  }
}
