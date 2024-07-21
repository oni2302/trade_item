import 'package:flutter/material.dart';
import 'EditPostPage.dart';

class PostDetail extends StatefulWidget {
  final Map<String, dynamic> post;

  PostDetail({required this.post});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  TextEditingController commentController = TextEditingController();
  List<Map<String, dynamic>> comments = [];

  @override
  void initState() {
    super.initState();
    comments = List.from(widget.post['comments']);
  }

  void _addComment() {
    if (commentController.text.isNotEmpty) {
      setState(() {
        comments.add({
          'userId': 'current_user_id', // replace with actual user id
          'comment': commentController.text,
        });
        commentController.clear();
      });
    }
  }

  void _showEditCommentDialog(int index) {
    final TextEditingController editController = TextEditingController(text: comments[index]['comment']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Comment'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(hintText: 'Edit your comment here'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                if (editController.text.isNotEmpty) {
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

  void _deleteComment(int index) {
    setState(() {
      comments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Detail'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'Edit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPostPage( post: {},
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
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post['username'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Row(
              children: List.generate(
                5,
                    (index) => Icon(
                  Icons.star,
                  color: index < widget.post['userRating'] ? Colors.orange : Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 10),
            Image.network(widget.post['imageUrl'], fit: BoxFit.cover),
            SizedBox(height: 10),
            Text(widget.post['content']),
            SizedBox(height: 10),
            Text('Quantity: ${widget.post['productQuantity']}'),
            Row(
              children: List.generate(
                5,
                    (index) => Icon(
                  Icons.star,
                  color: index < widget.post['postRating'] ? Colors.orange : Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('Comments'),
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
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
                    child: ListTile(
                      title: Text(comments[index]['comment']),
                      subtitle: Text('User: ${comments[index]['userId']}'),
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                labelText: 'Write a comment',
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
