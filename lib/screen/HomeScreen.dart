import 'package:flutter/material.dart';
import '../widget/post/PostDetail.dart';
import '../widget/post/PostWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> posts = [
    {
      'postId': 1,
      'username': 'User1',
      'userRating': 4,
      'content': 'This is the content of the first post.',
      'productQuantity': 3,
      'postRating': 3,
      'imageUrl': 'https://via.placeholder.com/150',
      'comments': [
        {'userId': '1', 'comment': 'Nice post!'},
        {'userId': '2', 'comment': 'Great!'}
      ],
    },
    {
      'postId': 2,
      'username': 'User2',
      'userRating': 5,
      'content': 'This is the content of the second post.',
      'productQuantity': 0,  // This post should not be displayed
      'postRating': 4,
      'imageUrl': 'https://via.placeholder.com/150',
      'comments': [],
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter posts to exclude those with productQuantity == 0 and apply search query
    final filteredPosts = posts.where((post) {
      return post['productQuantity'] > 0 &&
          post['content'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Rao vặt')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Tìm kiếm bài đăng...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetail(
                          post: filteredPosts[index],
                        ),
                      ),
                    ).then((value) {
                      setState(() {
                        if (value != null) {
                          filteredPosts[index]['comments'] = value;
                        }
                      });
                    });
                  },
                  child: PostWidget(
                    post: filteredPosts[index],
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
