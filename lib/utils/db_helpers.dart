import 'package:get_storage/get_storage.dart';

class DbHelpers {
  
  static void saveSearchHistory(Map<String, dynamic> data){
    var oldHistory = getAllHistory();
    oldHistory.add(data);
    GetStorage().write('search_history', oldHistory);
  }

  static List<Map<String,dynamic>> getAllHistory(){
    
    var history = GetStorage().read('search_history') as List? ?? [];
    return history.map((e)=> Map<String,dynamic>.from(e)).toList();
    
  }
}