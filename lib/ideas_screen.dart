import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class IdeasScreen extends StatefulWidget {
  const IdeasScreen({super.key});

  @override
  @override
  State<IdeasScreen> createState() => _IdeasScreenState();
}

class _IdeasScreenState extends State<IdeasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F8),
      appBar: AppBar(
        title: const Text('My Ideas', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF58CC02),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildGeneratorCard(),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.04 * 255).round()),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your Idea Collection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey.shade800)),
                const SizedBox(height: 16),
                _buildFavoritesGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneratorCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.04 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Enter an item to upcycle', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'e.g., plastic bottle',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF58CC02),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(PhosphorIcons.magicWand(), color: Colors.white),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Generating new ideas... (demo)')),
                    );
                  },
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesGrid() {
    // Mock data
    final favoriteIdeas = [
      {
        'title': 'Bird Feeder',
        'image': 'https://images.unsplash.com/photo-1464983953574-0892a716854b?q=80&w=400',
        'materials': 'Plastic bottle, string, wooden spoon'
      },
      {
        'title': 'Candle Holder',
        'image': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?q=80&w=400',
        'materials': 'Glass jar, paint, candle'
      },
      {
        'title': 'Planter',
        'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=400',
        'materials': 'Tin can, soil, seeds'
      },
      {
        'title': 'Desk Organizer',
        'image': 'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?q=80&w=400',
        'materials': 'Cardboard tubes, glue, colored paper'
      },
      {
        'title': 'Wall Art',
        'image': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?q=80&w=400',
        'materials': 'Old magazines, canvas, glue'
      },
      {
        'title': 'Bottle Lamp',
        'image': 'https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?q=80&w=400',
        'materials': 'Glass bottle, lamp kit, paint'
      },
    ];

    if (favoriteIdeas.isEmpty) {
      return const Center(child: Text('Your saved ideas will appear here!')); 
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        childAspectRatio: 0.95,
      ),
      itemCount: favoriteIdeas.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.04 * 255).round()),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  child: Image.network(
                    favoriteIdeas[index]['image']!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Text(
                  favoriteIdeas[index]['title']!,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                child: Text(
                  'Materials: ${favoriteIdeas[index]['materials']}',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}