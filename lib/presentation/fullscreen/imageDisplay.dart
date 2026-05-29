import 'package:flutter/material.dart';

import '../../app/generalFunction.dart';

class FullScreenImages extends StatelessWidget {
  final String image;

  FullScreenImages({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarBack(context, 'IMAGES'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Hero(
                  tag: image,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10.0,
                          spreadRadius: 5.0,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(child: Text('Failed to load image'));
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 10,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
