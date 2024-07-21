import 'package:flutter/material.dart';

class PostCardWidget extends StatelessWidget {
  final Map<String, dynamic> post;

  PostCardWidget({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post['title'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(post['description']),
            SizedBox(height: 10),
            Image.network(post['imageUrl'], height: 100, width: double.infinity, fit: BoxFit.cover),
            SizedBox(height: 10),
            Text('Price: \$${post['price']}'),
            SizedBox(height: 5),
            Text('Category: ${post['category']}'),
          ],
        ),
      ),
    );
  }
}
