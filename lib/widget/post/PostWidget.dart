import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final Map<String, dynamic> post;

  PostWidget({required this.post});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isStarred = false;

  void _showCommentDialog() {
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bình luận'),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(hintText: 'Để lại bình luận'),
          ),
          actions: [
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Đăng'),
              onPressed: () {
                if (commentController.text.isNotEmpty) {
                  setState(() {
                    widget.post['comments'].add({
                      'userId': 'current_user_id', // replace with actual user id
                      'comment': commentController.text,
                    });
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      constraints: BoxConstraints(
        minHeight: 200, // Minimum height for the card
        maxHeight: 500, // Maximum height for the card
        minWidth: 200,  // Minimum width for the card
        maxWidth: 500,  // Maximum width for the card
      ),
      child: AspectRatio(
        aspectRatio: 1, // Maintain a square aspect ratio
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.post['username'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5,),
                        Row(
                          children: List.generate(
                            5,
                                (index) => Icon(
                              Icons.star,
                              size: 10,
                              color: index < widget.post['userRating'] ? Colors.orange : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.star,
                            color: isStarred ? Colors.yellow : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isStarred = !isStarred;
                            });
                          },
                        ),
                        Text('Kho: ${widget.post['productQuantity']}'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Image.network(widget.post['imageUrl'], fit: BoxFit.cover,height:200, width: 250),
                SizedBox(height: 10),
                Expanded(
                  child: Text(
                    widget.post['content'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5, // Ensure the text doesn't overflow the square card
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                        5,
                            (index) => Icon(
                          Icons.star,
                          color: index < widget.post['postRating'] ? Colors.orange : Colors.grey,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _showCommentDialog,
                      child: Row(
                        children: [
                          Icon(Icons.comment),
                          SizedBox(width: 5),
                          Text('${widget.post['comments'].length} bình luận.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
