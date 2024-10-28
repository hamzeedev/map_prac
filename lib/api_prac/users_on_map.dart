import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UsersOnMap extends StatefulWidget {
  final List<dynamic> data;

  const UsersOnMap({super.key, required this.data});

  @override
  State<UsersOnMap> createState() => _UsersOnMapState();
}

class _UsersOnMapState extends State<UsersOnMap> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    markers = widget.data.map((user) {
      double lat = double.parse(user['address']['geo']['lat']);
      double lng = double.parse(user['address']['geo']['lng']);
      return Marker(
        markerId: MarkerId(user['id'].toString()),
        position: LatLng(lat, lng),
        infoWindow:InfoWindow(title: user['name'], snippet: user['address']['street']),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users on Map Screen'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(
            33.69488136129598,
            72.95837932471515,
          ),
          zoom: 2,
        ),
        onMapCreated: (controller) => mapController = controller,
        markers: markers,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
      ),
    );
  }
}
