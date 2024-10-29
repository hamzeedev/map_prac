import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_prac/controllers/maps_screen_controller.dart';
import 'package:map_prac/customs/my_text_field.dart';
import 'package:map_prac/extensions/extensions.dart';
import 'package:map_prac/searchs_history_screen.dart';
import 'package:map_prac/utils/db_helpers.dart';

class MapScreen extends StatelessWidget {
  GoogleMapController? mMapController;

  MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MapsScreenController());

    var loading = false.obs;
    Rx<Set<Marker>> markers = Rx({});

    return Scaffold(
      appBar: AppBar(
        title: const Text("Map Screen"),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => const SearchScreenHistory(),
              );
            },
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: Stack(
        children: [
          Obx(() {
            return GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(
                  33.69488136129598,
                  72.95837932471515,
                ),
                zoom: 12,
              ),
              onMapCreated: (mapController) {
                mMapController = mapController;
              },
              markers: markers.value,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
            );
          }),
          Obx(() {
            return MyTextField(
              hint: 'Address here..',
              onFieldSubmitted: (data) async {
                loading.value = true;
                var points = await controller.fetchGeoPoints(data);
                loading.value = false;

                if (points.isEmpty) {
                  context.showSnackBar("No locations found");
                } else if (points.length == 1) {
                  var address = points.first;

                  markers.value = {
                    ...markers.value,
                    Marker(
                      markerId: MarkerId(address.latitude.toString()),
                      infoWindow: InfoWindow(
                        title: "Current Location",
                        snippet: data,
                      ),
                      position: LatLng(address.latitude, address.longitude),
                    ),
                  };
                  await moveMap(address, query: data, results: points);
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Select a location"),
                      content: SingleChildScrollView(
                        child: Column(
                          children: points
                              .map(
                                (e) => ListTile(
                                  title: Text("${e.latitude}, ${e.longitude}"),
                                  onTap: () async {
                                    var address = e;
                                    Navigator.pop(context);
                                    await moveMap(e,
                                        query: data, results: points);
                                    markers.value = {
                                      ...markers.value,
                                      Marker(
                                        markerId: MarkerId(
                                            address.latitude.toString()),
                                        infoWindow: InfoWindow(
                                          title: "Current Location",
                                          snippet: data,
                                        ),
                                        position: LatLng(address.latitude,
                                            address.longitude),
                                      ),
                                    };
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  );
                }
              },
              suffixIcon: loading.value
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1.5,
                      ),
                    )
                  : null,
            ).marginAll(20);
          })
        ],
      ),
    );
  }

  Future<void> moveMap(Location address,
      {required String query, required List<Location> results}) async {
    var history = {
      "id": address.timestamp.millisecondsSinceEpoch,
      "query": query,
      "results": results.map((e) => e.toJson()).toList(),
      "clicked": address.toJson(),
    };

    DbHelpers.saveSearchHistory(history);

    await mMapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
          LatLng(
            address.latitude,
            address.longitude,
          ),
          17),
    );
  }
}
