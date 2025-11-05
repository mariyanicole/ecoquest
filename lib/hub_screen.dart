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
    final isWindows = Theme.of(context).platform == TargetPlatform.windows;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Recycling Hubs', style: theme.appBarTheme.titleTextStyle),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
        iconTheme: theme.appBarTheme.iconTheme,
      ),
      body: Column(
        children: [
          Container(
            height: 260,
            margin: const EdgeInsets.only(bottom: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: isWindows
                  ? Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            'https://maps.googleapis.com/maps/api/staticmap?center=7.1907,125.4553&zoom=12&size=600x300&maptype=roadmap&markers=color:green%7C7.1907,125.4553',
                            fit: BoxFit.cover,
                            // Graceful fallback if the static map request fails (e.g. 403 without API key)
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade200,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.map, size: 48, color: Colors.grey.shade700),
                                        const SizedBox(height: 12),
                                        Text(
                                          'Map preview not available.\nSee list of hubs below.',
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey.shade800),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          color: const Color.fromRGBO(0, 0, 0, 0.4),
                          child: Center(
                            child: Text(
                              'Google Maps is not supported on Windows. Showing static map.',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontFamily: theme.textTheme.displayLarge?.fontFamily ?? 'Inter',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    )
                  : GoogleMap(
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
                  color: theme.cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hub['name'] as String,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontSize: 18,
                            fontFamily: theme.textTheme.displayLarge?.fontFamily ?? 'Inter',
                            color: theme.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(PhosphorIcons.mapPin(), size: 16, color: theme.primaryColor),
                            const SizedBox(width: 8),
                            Text(
                              hub['address'] as String,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontFamily: theme.textTheme.displayLarge?.fontFamily ?? 'Inter',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: (hub['accepts'] as List<String>).map((item) => Chip(
                            label: Text(
                              item,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: theme.textTheme.displayLarge?.fontFamily ?? 'Inter',
                              ),
                            ),
                            backgroundColor: theme.primaryColor.withAlpha((0.1 * 255).round()),
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
