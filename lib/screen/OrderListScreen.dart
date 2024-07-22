





import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../common/APIService.dart';

class OrdereScreen extends StatefulWidget {
  const OrdereScreen({super.key});

  @override
  State<OrdereScreen> createState() => _OrdereScreenState();
}

class _OrdereScreenState extends State<OrdereScreen> {

  List<Map<String,dynamic>> _listOrder = List.empty(growable: true);
  var userID;
  Future<void> _initializeUser() async {
    Box box = await Hive.openBox('user');
    setState(() {
      userID = box.get('info')['id'];
    });
  }
  @override
  void initState() {
    _initOrder();
    super.initState();
  }
  Future<void> _initOrder()async{
      await _initializeUser();
      APIService api = APIService();
      var orders = List<Map<String, dynamic>>.from( (await api.getAllOrders()).data['result']);

      orders = orders.where((order) {
        return order['User']['id']==userID;
      }).toList();
      print(orders);
      setState(() {
        _listOrder = orders;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(child: Text('Danh sách đã mua'),),
          IconButton(onPressed: ()async{_initOrder();}, icon: Icon(Icons.refresh))
        ],
      )),
      body: ListView.builder(
        itemCount: _listOrder.length,
        itemBuilder: (context, index) {
          final order = _listOrder[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network(order['Product']['imgProduct']),
              title: Text(order['Product']['nameProduct']),
              subtitle: Text(order['Product']['pricesProduct']),

            ),
          );
        },
      ),
    );
  }
}
