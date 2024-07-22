import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trade_item/common/APIService.dart';
import '../post/EditPostPage.dart';

class PostDetailScreen extends StatefulWidget {
  final Map<String, dynamic> post;

  PostDetailScreen({required this.post});

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  TextEditingController commentController = TextEditingController();
  List<Map<String, dynamic>> comments = [];
  var userID;

  Future<List<Map<String, dynamic>>> getComments() async {
    var box = await Hive.openBox('user');
    var id = await box.get('info')['id'];

    APIService api = APIService();
    var res = await api.getAllComments();
    List<Map<String, dynamic>> result =
    List<Map<String, dynamic>>.from(res.data['result']);
    comments = result;
    if(comments == null)
      print(comments[1]);
    return result;
  }

  List<Map<String, dynamic>> filter(
      List<Map<String, dynamic>> datas, String search) {
    return datas.where((data) {
      return data['News']['title']
          .toLowerCase()
          .contains(search.toLowerCase()) ||
          data['News']['title'].toLowerCase().contains(search.toLowerCase());
    }).toList();
  }
  Future<void> _initializeUser() async {
    Box box = await Hive.openBox('user');
    setState(() {
      userID = box.get('info')['id'];
    });
  }
  @override
  void initState(){
    super.initState();
    _initializeUser();
  }

  void _addComment() async {
    if (commentController.text.isNotEmpty) {
      APIService api = APIService();
      var box = await Hive.openBox('user');
      var id = await box.get('info')['id'];
      var name = await box.get('info')['nameUser'];
      api.createComment({
        'newsID': widget.post['News']['id'],
        'userID': id,
        'contentComment': commentController.text
      });
      setState(() {
        comments.add({
          'User': {'userName': name}, // replace with actual user id
          'contentComment': commentController.text,
        });
        commentController.clear();
      });
    }
  }

  void _showEditCommentDialog(int index) {
    final TextEditingController editController =
    TextEditingController(text: comments[index]['comment']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sửa bình luận'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(hintText: 'Sửa bình luận ở đây'),
          ),
          actions: [
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cập nhật'),
              onPressed: () async {
                if (editController.text.isNotEmpty) {
                  APIService api = APIService();
                  await api.updateComment(comments[index]['id'],
                      {'contentComment': editController.text});
                  setState(() {
                    comments[index]['comment'] = editController.text;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteComment(int index) async {
    APIService api = APIService();
    await api.deleteComment(comments[index]['id']);
    setState(() {
      comments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết bài đăng'),
        actions: (userID == widget.post['User']['id'])?[
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'Edit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPostPage(
                      post: widget.post,
                    ),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Edit',
                child: Text('Edit'),
              ),
            ],
          ),
        ]:null,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post['User']['nameUser'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Row(
              children: List.generate(
                5,
                    (index) => Icon(
                  Icons.star,
                  color: index < 5 ? Colors.orange : Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 10),
            Image.network(widget.post['Product']['imgProduct'],
                fit: BoxFit.cover),
            SizedBox(height: 10),
            Text(widget.post['News']['title'] +
                "\n" +
                widget.post['News']['description']),
            SizedBox(height: 10),
            Text('Tình trạng: ${widget.post['Product']['status']}'),
            SizedBox(height: 10),
            Text('Comments'),
            Flexible(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: getComments(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No comments available'));
                  } else {

                    return ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: ListTile(
                            title: Text(comments[index]['contentComment']),
                            subtitle: Text(
                                'User: ${comments[index]['User']['nameUser'] ?? "unknown"}'),
                            trailing:(userID==comments[index]['User']['id'])? TextButton(
                              child: Icon(Icons.more_vert),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.edit),
                                          title: Text('Edit'),
                                          onTap: () {
                                            Navigator.pop(context);
                                            _showEditCommentDialog(index);
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.delete),
                                          title: Text('Delete'),
                                          onTap: () {
                                            Navigator.pop(context);
                                            _deleteComment(index);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ):null,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                labelText: 'Để lại bình luận',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}
