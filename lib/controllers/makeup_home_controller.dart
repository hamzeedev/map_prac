import 'package:dio/dio.dart';
import 'package:get/get.dart';

class MakeupHomeController extends GetxController {

  RxList<Map<String, dynamic>> products = RxList([]);
  var baseUrl = "https://makeup-api.herokuapp.com/api/v1/";
  var loading = true.obs;

  @override
  void onInit() {
    fetchAllProducts({});
    super.onInit();
  }

  Future<void> fetchAllProducts(Map<String, dynamic> params) async {
    var dio = Dio();
    loading.value  = true;
    var response   = await dio.get("$baseUrl/products.json?", queryParameters: params);
    products.value = (response.data as List? ?? []).map((e)=> Map<String,dynamic>.from(e)).toList();
    loading.value  = false;

  }
  
}