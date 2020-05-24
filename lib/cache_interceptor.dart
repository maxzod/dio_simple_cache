import 'dart:math';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheInterceptor extends Interceptor {
  @override
  Future onResponse(Response response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      // success
      // cache the result then return newest data
      if (prefs.containsKey('cache')) {
        List<String> cacheList = prefs.getStringList('cache')
          ..add(response.data);
        prefs.setStringList('cache', cacheList);
      } else {
        List<String> cacheList = []..add(response.data);
        prefs.setStringList('cache', cacheList);
      }
      return super.onResponse(response);
    } else if (prefs.containsKey('cache')) {
      // if cache exists send random one from it
      List<String> cacheList = prefs.getStringList('cache');
      return super.onResponse(Response(
          data:
              cacheList[Random.secure().nextInt(cacheList.length + 1) * 100]));
    } else {
      return super.onResponse(Response(data: 'no Internet && no cached data'));
    }
  }
}
