import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:map_prac/api_prac_with_model/models/product.dart';

class MakeupHomeController extends GetxController {
  //! without model -- below one..
  // RxList<Map<String, dynamic>> products = RxList([]);
  //? with model -- below one..
  RxList<Product> productsList = RxList([]);
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
    //! without model -- below one..
    // products.value = (response.data as List? ?? []).map((e)=> Map<String,dynamic>.from(e)).toList();
    //? with model -- below one..
    productsList.value = (response.data as List? ?? []).map((e)=> Product.fromMap(Map<String,dynamic>.from(e))).toList();
    loading.value  = false;

  }
  
}