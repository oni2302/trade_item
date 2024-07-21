import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:trade_item/common/APIService.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final List<String> _imageUrls = ['', '', '', ''];
  final List<File?> _imageFiles = [null, null, null, null];

  Future<void> _pickImage(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      setState(() {
        _imageFiles[index] = imageFile;
      });
      await _uploadImage(imageFile, index);
    }
  }

  Future<void> _uploadImage(File imageFile, int index) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/$fileName');
    final uploadTask = firebaseStorageRef.putFile(imageFile);
    final taskSnapshot = await uploadTask.whenComplete(() => null);
    final downloadUrl = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      _imageUrls[index] = downloadUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              Map<String, dynamic> result = HashMap();
              APIService api = APIService();
              var newID = Random().nextInt(2147483647);

              var cateID = Random().nextInt(2147483647);
              var productID = Random().nextInt(2147483647);
              await api.createNews({
                'id': newID,
                'title': _titleController.text,
                'description': _descriptionController.text,
              });

              await api.createCate(
                  {'id': cateID, 'nameCategory': _categoryController.text});

              Box box = await Hive.openBox('user');
              var userID = box.get('info')['id'];
              await api.createProduct({
                'id': productID,
                'categoryID': cateID,
                'nameProduct': _nameController.text,
                'pricesProduct': _priceController.text,
                'status': 'Còn hàng',
                'imgProduct': (_imageUrls[0].isNotEmpty)
                    ? _imageUrls[0]
                    : 'https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg',
                'imgSlide1': (_imageUrls[1].isNotEmpty)
                    ? _imageUrls[1]
                    : 'https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg',
                'imgSlide2': (_imageUrls[2].isNotEmpty)
                    ? _imageUrls[2]
                    : 'https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg',
                'imgSlide3': (_imageUrls[3].isNotEmpty)
                    ? _imageUrls[3]
                    : 'https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg',
              });
              var pnID = Random().nextInt(2147483647);
              api.createProductNews({
                'id': pnID,
                'newsID': newID,
                'productID': productID,
                'userID': userID
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              SizedBox(height: 10),
              Text('Product Images:'),
              ...List.generate(4, (index) {
                return Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _pickImage(index),
                        child: Text('Select Image ${index + 1}'),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: (_imageFiles[index] != null)
                          ? Image.file(
                              _imageFiles[index]!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset('assets/images/no_image.jpg',
                              fit: BoxFit.cover),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
