import 'package:flutter/material.dart';
import '../post/AddPostPage.dart';
import 'PostDetailScreen.dart';

class ManageScreen extends StatefulWidget {
  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  final List<String> categories = [
    'All',
    'Electronics',
    'Fashion',
    'Home & Garden',
    'Sports',
    'Toys',
    'Automotive',
    'Books',
    'Health',
    'Beauty',
  ];

  final List<Map<String, dynamic>> posts = [
    {
      'postId': 1,
      'title': 'Smartphone XYZ',
      'description': 'Latest model with high performance.',
      'category': 'Electronics',
      'imageUrl': 'https://via.placeholder.com/50',
      'price': '499.99',
      'imageUrls': ['https://via.placeholder.com/50'],
      'comments': [],
    },
    // Add other posts here
  ];

  String selectedCategory = 'All';

  void _showAddPostPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPostPage()),
    ).then((newPost) {
      if (newPost != null) {
        setState(() {
          posts.add(newPost);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredPosts = selectedCategory == 'All'
        ? posts
        : posts.where((post) => post['category'] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box),
            onPressed: () {
              // Add Category functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddPostPage,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = categories[index];
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: selectedCategory == categories[index]
                          ? Colors.blue
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: selectedCategory == categories[index]
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                final post = filteredPosts[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.network(post['imageUrl']),
                    title: Text(post['title']),
                    subtitle: Text(post['description']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetailScreen(post: post),
                        ),
                      );
                    },
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
