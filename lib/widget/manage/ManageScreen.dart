import 'package:flutter/material.dart';
import 'package:trade_item/common/APIService.dart';
import '../post/AddPostPage.dart';
import 'PostDetailScreen.dart';

class ManageScreen extends StatefulWidget {
  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  List<Map<String,dynamic>> categories = [
  ];

  List<Map<String, dynamic>> posts = [
  ];

  Future<void> _loadCategoryAndPost() async{
    APIService api = APIService();
    var cate = List<Map<String, dynamic>>.from( (await api.getAllCate()).data['result']);
    var p = List<Map<String, dynamic>>.from( (await api.getAllProductNews()).data['result']);
    setState(() {
      categories= cate;
      posts = p;
    });
  }
  @override
  void initState() {
    _loadCategoryAndPost();
    super.initState();
  }
  String selectedCategory = 'All';
  int selectCateID = -1;
  void _showAddPostPage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPostPage()),
    ).then((newPost) async{
      await _loadCategoryAndPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredPosts = selectedCategory == 'All'
        ? posts
        : posts.where((post) => post['Product']['categoryID'] == selectCateID).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Screen'),
        actions: [
          IconButton(
            icon: Row(children: [Icon(Icons.add),SizedBox(width: 5,),Text('Tạo bài viết')]),
            onPressed: _showAddPostPage,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = categories[index]['nameCategory'];
                      selectCateID = categories[index]['id'];
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 0),
                    decoration: BoxDecoration(
                      color: selectedCategory == categories[index]['nameCategory']
                          ? Colors.blue
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(100000),
                    ),
                    child: Center(
                      child: Text(
                        categories[index]['nameCategory'],
                        style: TextStyle(
                          color: selectedCategory == categories[index]['nameCategory']
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
                    leading: Image.network(post['Product']['imgProduct']),
                    title: Text(post['News']['title']),
                    subtitle: Text(post['News']['description']),
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
