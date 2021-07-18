import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hero/src/constants/asset.dart';
import 'package:flutter_hero/src/constants/common.dart';
import 'package:flutter_hero/src/pages/map/widgets/custom_info_window.dart';
import 'package:flutter_hero/src/utils/helpers/device.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import 'dart:ui';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _controller = Completer<GoogleMapController>();
  final Set<Marker> _markers = {};
  StreamSubscription<LocationData>? _locationSubscription;
  final _locationService = Location();
  final _streamInfoController = StreamController<LatLng?>();

  @override
  void dispose() {
    _locationSubscription?.cancel();
    _streamInfoController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
        actions: [
          IconButton(
            onPressed: () => _oneTimeLocation(),
            icon: Icon(Icons.my_location_outlined),
          )
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(13.7465354, 100.532752),
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _dummyLocations();
            },
            zoomControlsEnabled: false,
            trafficEnabled: false,
            myLocationButtonEnabled: false,
            markers: _markers,
          ),
          StreamBuilder<LatLng?>(
            stream: _streamInfoController.stream,
            builder: (context, stream) {
              if (_locationSubscription != null || _markers.isEmpty) {
                return SizedBox();
              }
              return CustomInfoWindow(
                stream.data,
                top: 10,
                navigator: () => _launchMaps(
                  lat: stream.data!.latitude,
                  lng: stream.data!.longitude,
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: _buildTrackingButton(),
    );
  }

  Future<Uint8List> _getBytesFromAsset(
    String path, {
    required int width,
  }) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> _addMarker(
    LatLng position, {
    String title = 'none',
    String snippet = 'none',
    String pinAsset = Asset.pinBikerImage,
    bool isShowInfo = false,
  }) async {
    final Uint8List markerIcon = await _getBytesFromAsset(
      pinAsset,
      width: 150,
    );
    final BitmapDescriptor bitmap = BitmapDescriptor.fromBytes(markerIcon);

    _markers.add(
      Marker(
        // important. unique id
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: isShowInfo
            ? InfoWindow(
                title: title,
                snippet: snippet,
                onTap: () => _launchMaps(
                  lat: position.latitude,
                  lng: position.longitude,
                ),
              )
            : InfoWindow(),
        icon: bitmap,
        onTap: () async {
          _streamInfoController.sink.add(null);
          await Future.delayed(Duration(milliseconds: 200));
          _streamInfoController.sink
              .add(LatLng(position.latitude, position.longitude));
        },
      ),
    );
  }

  void _launchMaps({required double lat, required double lng}) async {
    // Set Google Maps URL Scheme for iOS in info.plist (comgooglemaps)

    /*
       - center: This is the map viewport center point. Formatted as a comma separated string of latitude,longitude.
       - mapmode: Sets the kind of map shown. Can be set to: standard or streetview.
         If not specified, the current application settings will be used.
       - views: Turns specific views on/off. Can be set to: satellite, traffic,
         or transit. Multiple values can be set using a comma-separator.
         If the parameter is specified with no value, then it will clear all views.
       - zoom: Specifies the zoom level of the map.
       - q: The query string for your search.

       more info: https://developers.google.com/maps/documentation/urls/ios-urlscheme
    */

    final parameter = '?z=16&q=$lat,$lng';

    if (Device.platform == Common.ios) {
      final googleMap = 'comgooglemaps://';
      final appleMap = 'https://maps.apple.com/';
      if (await canLaunch(googleMap)) {
        await launch(googleMap + parameter);
        return;
      }

      if (await canLaunch(appleMap)) {
        await launch(appleMap + parameter);
        return;
      }
    } else {
      final googleMapURL = 'https://maps.google.com/';
      if (await canLaunch(googleMapURL)) {
        await launch(googleMapURL + parameter);
        return;
      }
    }
    throw 'Could not launch url';
  }

  Future<void> _animateCamera(LatLng latLng) async {
    _controller.future.then((controller) {
      controller.animateCamera(CameraUpdate.newLatLngZoom(latLng, 16));
    });
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1 = 0;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }

  void _oneTimeLocation() async {
    try {
      final permissionGranted = await _checkPermission();
      if (!permissionGranted) {
        throw PlatformException(code: 'PERMISSION_DENIED');
      }
      final location = await Location().getLocation();
      _animateCamera(LatLng(location.latitude!, location.longitude!));
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
    }
  }

  Future<bool> _checkPermission() async {
    var permissionGranted = await _locationService.hasPermission();
    if (permissionGranted == PermissionStatus.granted) {
      return true;
    }
    permissionGranted = await _locationService.requestPermission();
    return permissionGranted == PermissionStatus.granted;
  }

  Future<bool> _checkServiceGPS() async {
    var serviceEnabled = await _locationService.serviceEnabled();
    if (serviceEnabled) {
      return true;
    }
    serviceEnabled = await _locationService.requestService();
    return serviceEnabled;
  }

  void _trackingLocation() async {
    if (_locationSubscription != null) {
      _locationSubscription?.cancel();
      _locationSubscription = null;
      _markers.clear();
      setState(() {});
      return;
    }

    try {
      final serviceEnabled = await _checkServiceGPS();
      if (!serviceEnabled) {
        throw PlatformException(code: 'SERVICE_STATUS_DENIED');
      }

      final permissionGranted = await _checkPermission();
      if (!permissionGranted) {
        throw PlatformException(code: 'PERMISSION_DENIED');
      }

      await _locationService.changeSettings(
        accuracy: LocationAccuracy.high,
        interval: 10000,
        distanceFilter: 100,
      ); // meters.

      _locationSubscription = _locationService.onLocationChanged.listen(
        (locationData) async {
          _markers.clear();
          final latLng = LatLng(
            locationData.latitude!,
            locationData.longitude!,
          );
          await _addMarker(
            latLng,
            pinAsset: Asset.pinCurrentImage,
          );
          _animateCamera(latLng);
          setState(() {});
        },
      );
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'PERMISSION_DENIED':
          //todo
          break;
        case 'SERVICE_STATUS_ERROR':
          //todo
          break;
        case 'SERVICE_STATUS_DENIED':
          //todo
          break;
        default:
        //todo
      }
    }
  }

  Future<void> _dummyLocations() async {
    await Future.delayed(Duration(seconds: 2));
    List<LatLng> data = [
      LatLng(13.7330609, 100.5290547),
      LatLng(13.7304786, 100.5322757),
      LatLng(13.7286446, 100.5326617),
      LatLng(13.731132, 100.523406),
      LatLng(13.734506, 100.519914),
      LatLng(13.737904, 100.521985),
      LatLng(13.724373, 100.524751),
    ];

    for (var latLng in data) {
      await _addMarker(
        latLng,
        title: 'Rider009',
        snippet: 'Cat Lover',
      );
    }

    _controller.future.then((controller) => controller.moveCamera(
        CameraUpdate.newLatLngBounds(_boundsFromLatLngList(data), 32)));
    setState(() {});
  }

  FloatingActionButton _buildTrackingButton() {
    final isTracking = _locationSubscription != null;
    return FloatingActionButton.extended(
      onPressed: () {
        //oneTimeLocation();
        _trackingLocation();
      },
      label: Text(isTracking ? 'Stop Tracking' : 'Start Tracking'),
      backgroundColor: isTracking ? Colors.red : Colors.blue,
      icon: FaIcon(isTracking ? FontAwesomeIcons.stop : FontAwesomeIcons.play),
    );
  }
}

