import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tiện ích'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: 4, // Number of items in the grid
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.75, // Adjusts the item height relative to width
          ),
          itemBuilder: (context, index) {
            return ServiceCard(
              imageUrl: index % 2 == 0
                  ? 'https://f1e425bd6cd9ac6.cmccloud.com.vn/cms-tool/post/images/314/img_card.png?v=11' // Example image URL
                  : 'https://f1e425bd6cd9ac6.cmccloud.com.vn/cms-tool/post/images/314/img_card.png?v=11', // Example image URL
              title: index % 2 == 0 ? 'Vé xe rẻ' : 'Btaskee',
            );
          },
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const ServiceCard({
    required this.imageUrl,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 150, // Set the desired height for the image
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Define button action
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.shade100,
                    minimumSize: const Size(80, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Đặt vé',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}