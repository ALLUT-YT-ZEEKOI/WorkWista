import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class LocationProvider with ChangeNotifier {
  bool _isLoadingLocation = true;
  String _cityName = 'not found';
  String _coordinates = 'Unknown';
  String _errorMessage = '';
  final loc.Location _location = loc.Location();
  bool _permissionRequested = false;

  bool get isLoadingLocation => _isLoadingLocation;
  String get cityName => _cityName;
  String get coordinates => _coordinates;
  String get errorMessage => _errorMessage;

  Future<void> getCurrentLocationAndCity() async {
    if (!_isLoadingLocation && _cityName != 'not found') return;

    setState(() {
      _isLoadingLocation = true;
      _errorMessage = '';
    });

    try {
      bool serviceEnabled;
      loc.PermissionStatus permissionGranted;
      loc.LocationData locationData;

      // Check if location service is enabled
      serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        _permissionRequested = true;
        serviceEnabled = await _location.requestService();
        
        if (!serviceEnabled) {
          setState(() {
            _errorMessage = 'Location service is disabled';
            _isLoadingLocation = false;
            _permissionRequested = false;
          });
          return;
        } else {
          _permissionRequested = false;
          await Future.delayed(const Duration(milliseconds: 1000));
        }
      }

      // Check permission
      permissionGranted = await _location.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        _permissionRequested = true;
        permissionGranted = await _location.requestPermission();
        
        if (permissionGranted == loc.PermissionStatus.granted) {
          _permissionRequested = false;
          await Future.delayed(const Duration(milliseconds: 1000));
        } else {
          setState(() {
            _errorMessage = 'Location permission denied';
            _isLoadingLocation = false;
            _permissionRequested = false;
          });
          return;
        }
      }

      // Get location with timeout
      locationData = await _location.getLocation().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Location request timed out');
        },
      );

      if (locationData.latitude == null || locationData.longitude == null) {
        throw Exception('Invalid location data received');
      }

      // Get city name from coordinates
      await _getCityFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );

      setState(() {
        _coordinates = 'Lat: ${locationData.latitude!.toStringAsFixed(4)}, '
            'Lon: ${locationData.longitude!.toStringAsFixed(4)}';
        _isLoadingLocation = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error getting location: $e';
        _isLoadingLocation = false;
      });
    }
  }

  Future<void> _getCityFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String cityName = place.locality ?? 
                         place.subAdministrativeArea ?? 
                         place.administrativeArea ?? 
                         'Unknown City';
        
        setState(() {
          _cityName = cityName;
        });
      }
    } catch (e) {
      setState(() {
        _cityName = 'not found';
      });
    }
  }

  void setState(VoidCallback fn) {
    fn();
    notifyListeners();
  }
}