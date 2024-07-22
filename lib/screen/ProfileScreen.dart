import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../common/APIService.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late var _user;
  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
  final APIService _apiService = APIService();

  @override
  void initState() {
    _fetchUserData();
    super.initState();
  }

  Future<void> _fetchUserData() async {
    try {
      var box = await Hive.openBox('user');
      var data = box.get('info');
      setState(() {
        _user = data;
        _isLoading=false;
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  void _saveUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _apiService.updateUser(_user['id'], {'nameUser':_user['nameUser'],'phoneUser':_user['phoneUser'],'emailUser':_user['emailUser']});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cập nhật thông tin thành công')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi khi cập nhật' + e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Cá nhân')),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _user['nameUser'],
                decoration: InputDecoration(labelText: 'Tên'),
                onSaved: (value) => _user['nameUser'] = value,
                validator: (value) => value!.isEmpty ? 'Bắt buộc nhập tên' : null,
              ),
              TextFormField(
                initialValue: _user['emailUser'],
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => _user['emailUser'] = value,
                validator: (value) => value!.isEmpty ? 'Bắt buộc nhập email' : null,
              ),
              TextFormField(
                initialValue: _user['phoneUser'],
                decoration: InputDecoration(labelText: 'Số điện thoại'),
                onSaved: (value) => _user['phoneUser'] = value,
              ),
              TextFormField(
                initialValue: _user['avatarUser'],
                decoration: InputDecoration(labelText: 'Hình đại diện'),
                onSaved: (value) => _user['avatarUser'] = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveUser,
                child: Text('Lưu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
