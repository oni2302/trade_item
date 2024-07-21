import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:trade_item/common/APIService.dart';
import '../widget/post/PostDetail.dart';
import '../widget/post/PostWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

bool _skeleton = true;

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Map<String, dynamic>>> getPost() async {
    APIService api = APIService();
    var res = await api.getAllProductNews();

    List<Map<String, dynamic>> result =
        List<Map<String, dynamic>>.from(res.data['result']);
    return search(result, searchQuery);
  }

  List<Map<String, dynamic>> search(
      List<Map<String, dynamic>> datas, String search) {
    return datas.where((data) {
      return data['News']['title']
              .toLowerCase()
              .contains(search.toLowerCase()) ||
          data['News']['title'].toLowerCase().contains(search.toLowerCase());
    }).toList();
  }

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter posts to exclude those with productQuantity == 0 and apply search query

    List<Map<String, dynamic>> filterPost;

    return Scaffold(
        appBar: AppBar(title: const Text('Rao vặt')),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: (searchQuery.isEmpty)
                    ? 'Tìm kiếm bài đăng...'
                    : searchQuery,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
              ),
              onSubmitted: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: getPost(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Skeletonizer(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          constraints: BoxConstraints(
                            minHeight: 200, // Minimum height for the card
                            maxHeight: 500, // Maximum height for the card
                            minWidth: 200, // Minimum width for the card
                            maxWidth: 500, // Maximum width for the card
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'fasdfasdf',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Row(
                                              children: List.generate(
                                                5,
                                                (index) => Icon(
                                                  Icons.star,
                                                  size: 10,
                                                  color: index < 5
                                                      ? Colors.orange
                                                      : Colors.grey,
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
                                              ),
                                              onPressed: () {},
                                            ),
                                            Text('Kho: 2354'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Image.asset('assets/images/login_dark.png',
                                        fit: BoxFit.cover,
                                        height: 200,
                                        width: 250),
                                    SizedBox(height: 10),
                                    Expanded(
                                      child: Text(
                                        'asdfasdfasdfasdfasdfasdfasdf',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines:
                                            5, // Ensure the text doesn't overflow the square card
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: List.generate(
                                            5,
                                            (index) => Icon(
                                              Icons.star,
                                              color: index < 5
                                                  ? Colors.orange
                                                  : Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text('Tạm thời chưa có bài đăng nào'));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PostDetail(
                                    post: snapshot.data![index],
                                  ),
                                ),
                              );
                            },
                            child: PostWidget(
                              post: snapshot.data![index],
                            ),
                          );
                        },
                      );
                    }
                  }))
        ]));
  }
}
