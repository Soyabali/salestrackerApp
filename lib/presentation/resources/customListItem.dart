import 'package:flutter/material.dart';

// class CustomList extends StatelessWidget {
//   final List<String> items = List.generate(20, (index) => "Item $index");
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: items.length,
//       itemBuilder: (context, index) {
//         return CustomListItem(
//           title: items[index],
//         );
//       },
//     );
//   }
// }

class CustomListItem extends StatelessWidget {
  final String title;

  CustomListItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // First part: ListTile taking 95% of the width
          Expanded(
            flex: 19, // Equivalent to 95% (since 19/(19+1) = 0.95)
            child: ListTile(
              title: Text(title),
              subtitle: Text('Subtitle'),
              leading: Icon(Icons.label),
            ),
          ),
          // Second part: Icons taking 5% of the width
          Expanded(
            flex: 1, // Equivalent to 5% (since 1/(19+1) = 0.05)
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.star, size: 16.0),
                Icon(Icons.more_vert, size: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}