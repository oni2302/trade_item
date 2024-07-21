import 'package:dio/dio.dart';

class APIService {
  // Base URL
  final String _baseUrl = "http://10.0.2.2:9000/api";
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:9000/api"));



  // User APIs
  Future<Response> createUser(Map<String, dynamic> data) async {
    return await _dio.post('/auth/createUser', data: data);
  }

  Future<Response> getAllUsers() async {
    return await _dio.get('/auth/userAPI');
  }

  Future<Response> loginUser(Map<String, dynamic> data) async {
    return await _dio.post('/auth/login', data: data);
  }

  Future<Response> deleteUser(int id) async {
    return await _dio.delete('/auth/deleteUser/$id');
  }

  // UserPermission APIs
  Future<Response> createUserPermission(Map<String, dynamic> data) async {
    return await _dio.post('/userPermission/createUserPer', data: data);
  }

  Future<Response> getAllUserPermissions() async {
    return await _dio.get('/userPermission/userPerAPI');
  }

  Future<Response> updateUserPermission(int id, Map<String, dynamic> data) async {
    return await _dio.put('/userPermission/updateUserPer/$id', data: data);
  }

  Future<Response> deleteUserPermission(int id) async {
    return await _dio.delete('/userPermission/deleteUserPer/$id');
  }

  // Rate APIs
  Future<Response> createRate(Map<String, dynamic> data) async {
    return await _dio.post('/rate/createRate', data: data);
  }

  Future<Response> getAllRates() async {
    return await _dio.get('/rate/rateAPI');
  }

  Future<Response> updateRate(int id, Map<String, dynamic> data) async {
    return await _dio.put('/rate/updateRate/$id', data: data);
  }

  Future<Response> deleteRate(int id) async {
    return await _dio.delete('/rate/deleteRate/$id');
  }

  // Add more methods for other routes similarly...

  // Product APIs
  Future<Response> createProduct(Map<String, dynamic> data) async {
    return await _dio.post('/prod/createProd', data: data);
  }

  Future<Response> getAllProducts() async {
    return await _dio.get('/prod/prodAPI');
  }

  Future<Response> updateProduct(int id, Map<String, dynamic> data) async {
    return await _dio.put('/prod/updateProd/$id', data: data);
  }

  Future<Response> deleteProduct(int id) async {
    return await _dio.delete('/prod/deleteProd/$id');
  }

  // ProductNews APIs
  Future<Response> createProductNews(Map<String, dynamic> data) async {
    return await _dio.post('/prodNews/createProdNews', data: data);
  }

  Future<Response> getAllProductNews() async {
    return await _dio.get('/prodNews/prodNewsAPI');
  }

  Future<Response> updateProductNews(int id, Map<String, dynamic> data) async {
    return await _dio.put('/prodNews/updateProdNews/$id', data: data);
  }

  Future<Response> deleteProductNews(int id) async {
    return await _dio.delete('/prodNews/deleteProdNews/$id');
  }

  // News APIs
  Future<Response> createNews(Map<String, dynamic> data) async {
    return await _dio.post('/news/createNews', data: data);
  }

  Future<Response> getAllNews() async {
    return await _dio.get('/news/newsAPI');
  }

  Future<Response> updateNews(int id, Map<String, dynamic> data) async {
    return await _dio.put('/news/updateNews/$id', data: data);
  }

  Future<Response> deleteNews(int id) async {
    return await _dio.delete('/news/deleteNews/$id');
  }

  // Comments APIs
  Future<Response> createComment(Map<String, dynamic> data) async {
    return await _dio.post('/comment/createComment', data: data);
  }

  Future<Response> getAllComments() async {
    return await _dio.get('/comment/commentAPI');
  }

  Future<Response> updateComment(int id, Map<String, dynamic> data) async {
    return await _dio.put('/comment/updateComment/$id', data: data);
  }

  Future<Response> deleteComment(int id) async {
    return await _dio.delete('/comment/deleteComment/$id');
  }

  // Orders APIs
  Future<Response> createOrder(Map<String, dynamic> data) async {
    return await _dio.post('/order/createOrder', data: data);
  }

  Future<Response> getAllOrders() async {
    return await _dio.get('/order/orderAPI');
  }

  Future<Response> updateOrder(int id, Map<String, dynamic> data) async {
    return await _dio.put('/order/updateOrder/$id', data: data);
  }

  Future<Response> deleteOrder(int id) async {
    return await _dio.delete('/order/deleteOrder/$id');
  }

  // Permissions APIs
  Future<Response> getAllPermissions() async {
    return await _dio.get('/permission/perAPI');
  }

  Future<Response> createPermission(Map<String, dynamic> data) async {
    return await _dio.post('/permission/createPer', data: data);
  }

  Future<Response> updatePermission(int id, Map<String, dynamic> data) async {
    return await _dio.put('/permission/updatePer/$id', data: data);
  }

  Future<Response> deletePermission(int id) async {
    return await _dio.delete('/permission/deletePer/$id');
  }
}
