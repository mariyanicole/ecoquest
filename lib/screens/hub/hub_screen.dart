import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class HubScreen extends StatefulWidget {
  const HubScreen({super.key});

  @override
  State<HubScreen> createState() => _HubScreenState();
}

class _HubScreenState extends State<HubScreen> {
  late GoogleMapController mapController;
  final LatLng davaoCenter = const LatLng(7.1907, 125.4553);

  final List<Map<String, dynamic>> recyclingHubs = [
    {
      "name": "Eco Center Davao",
      "address": "San Pedro St, Davao City",
      "accepts": ["Batteries", "Phones", "Laptops"],
      "location": LatLng(7.0731, 125.6131),
    },
    {
      "name": "Davao City MRF",
      "address": "Quirino Ave, Davao City",
      "accepts": ["Cables", "Appliances"],
      "location": LatLng(7.0855, 125.6097),
    },
    {
      "name": "GreenTech Recyclers",
      "address": "Matina, Davao City",
      "accepts": ["All E-Waste"],
      "location": LatLng(7.0636, 125.6017),
    },
  ];

  Set<Marker> get hubMarkers {
    return recyclingHubs.map((hub) {
      return Marker(
        markerId: MarkerId(hub['name']),
        position: hub['location'],
        infoWindow: InfoWindow(title: hub['name'], snippet: hub['address']),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recycling Hubs', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          Container(
            height: 260,
            margin: const EdgeInsets.only(bottom: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: GoogleMap(
                onMapCreated: (controller) => mapController = controller,
                initialCameraPosition: CameraPosition(
                  target: davaoCenter,
                  zoom: 12.5,
                ),
                markers: hubMarkers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: recyclingHubs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final hub = recyclingHubs[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(hub['name'] as String, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(PhosphorIcons.mapPin(), size: 16, color: Colors.grey.shade600),
                            const SizedBox(width: 8),
                            Text(hub['address'] as String, style: TextStyle(color: Colors.grey.shade700)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: (hub['accepts'] as List<String>).map((item) => Chip(
                            label: Text(item),
                            backgroundColor: Theme.of(context).primaryColor.withAlpha((0.1 * 255).round()),
                            labelStyle: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                          )).toList(),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
