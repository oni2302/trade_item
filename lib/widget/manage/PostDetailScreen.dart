import 'package:flutter/material.dart';

import '../post/EditPostPage.dart';

class PostDetailScreen extends StatelessWidget {
  final Map<String, dynamic> post;

  PostDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    final comments = post['comments'] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to the Edit Post page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPostPage(post: post),
                ),
              ).then((updatedPost) {
                if (updatedPost != null) {
                  // Handle the updated post
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(post['imageUrl']),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                post['title'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(post['description']),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Category: ${post['category']}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Price: \$${post['price']}'),
            ),
            if (post['imageUrls'] != null)
              Column(
                children: post['imageUrls'].map<Widget>((url) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(url),
                  );
                }).toList(),
              ),
            SizedBox(height: 20),
            Text('Comments:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...comments.map<Widget>((comment) {
              return ListTile(
                title: Text(comment['userId']),
                subtitle: Text(comment['comment']),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Handle comment edit
                  },
                ),
              );
            }).toList(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Add a comment',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (comment) {
                  // Handle new comment
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
