import 'dart:math';
import 'package:dio/dio.dart';
import 'package:diosamples/cache_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repo {
  Future<String> getRandomDate() async {
    try {
      Dio dio = Dio();
      dio.interceptors.add(CacheInterceptor());
      Response res = await dio.get('http://numbersapi.com/random/date');
      return res.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.DEFAULT) {
        return await getCachedData();
      }
      return Future.error(e.message);
    }
  }

  Future<String> getCachedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('cache')) {
      List<String> cacheList = prefs.getStringList('cache');
      return cacheList[Random().nextInt(cacheList.length )];
    } else {
      return 'no Internet && no cached data';
    }
  }
}
