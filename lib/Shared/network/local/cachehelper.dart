import 'package:shared_preferences/shared_preferences.dart';

class cashehelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance() as SharedPreferences;
    print("getinstane success");
  }
  //
  // static Future<bool> putboolean({
  //   required bool value,
  //   required String key
  // }) async {
  //   print("put data success");
  //   return await sharedPreferences.setBool(key, value);
  // }

  // static bool? getdata({required String key}) {
  //   print("get data success");
  //   return sharedPreferences.getBool(key);
  //
  // }

  static Future<bool> Savedata({
    required String key,
    required dynamic value,
  }) async {
    print("put data success");
    if(value is int){
      return await sharedPreferences.setInt(key, value);
    }if(value is String){
      return await sharedPreferences.setString(key, value);
    }if(value is bool){
      return await sharedPreferences.setBool(key, value);
    }
      return await sharedPreferences.setDouble(key, value);
    }

  static dynamic Getdata({
    required String key
  }) {
    // print("get data success");
    return sharedPreferences.get(key);

  }


  static Future<bool> RemoveData({
    required String key,
  }) async {
    print("RemoveData success");

    return await sharedPreferences.remove(key);
  }

}
