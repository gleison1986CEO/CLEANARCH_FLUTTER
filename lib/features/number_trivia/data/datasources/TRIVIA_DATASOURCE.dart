import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/TRIVIA_MODEL.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel>? getLastNumberTrivia();
  Future<void>? cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const CACHE_NUMEROS_API_TRIVIA = 'CACHE_NUMEROS_API_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<NumberTriviaModel>? getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHE_NUMEROS_API_TRIVIA);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(
        CACHE_NUMEROS_API_TRIVIA, json.encode(triviaToCache.toJson()));
  }
}
