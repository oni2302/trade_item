import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  final List<File> _imageFiles = [File(''), File(''), File(''), File('')];

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
    final firebaseStorageRef = FirebaseStorage.instance.ref().child('images/$fileName');
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
            onPressed: () async{
              final newPost = {
                'postId': DateTime.now().millisecondsSinceEpoch,
                'title': _titleController.text,
                'description': _descriptionController.text,
                'category': _categoryController.text,
                'name': _nameController.text,
                'price': _priceController.text,
                'imageUrl': _imageUrls.firstWhere((url) => url.isNotEmpty, orElse: () => ''),
                'imageUrls': _imageUrls.where((url) => url.isNotEmpty).toList(),
              };

              Navigator.pop(context, newPost);
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
                      child: Image.file(
                        _imageFiles[index],
                        fit: BoxFit.cover,
                      ),
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
