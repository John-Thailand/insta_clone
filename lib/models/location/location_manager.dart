import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;
import 'package:insta_clone/data_models/location.dart';

class LocationManager {
  Future<Location> getCurrentLocation() async {
    // 位置情報がオンになっているかチェック
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('位置情報サービスがオフになっています');
    }

    // ユーザーのパーミッションのチェック
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('位置情報へのアクセスをユーザーに拒否されました');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('位置情報へのアクセスが永久に拒否されており、リクエストすらできません');
    }

    // ユーザーの位置情報を取得
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    // 場所の詳細情報を取得
    final placeMarks = await geoCoding.placemarkFromCoordinates(
        position.latitude, position.longitude);
    final placeMark = placeMarks.first;
    return Future.value(
        convert(placeMark, position.latitude, position.longitude));
  }

  Future<Location> updateLocation(double latitude, double longitude) async {
    final placeMarks =
        await geoCoding.placemarkFromCoordinates(latitude, longitude);
    final placeMark = placeMarks.first;
    return Future.value(convert(placeMark, latitude, longitude));
  }

  // Locationクラスに変換
  Location convert(
      geoCoding.Placemark placeMark, double latitude, double longitude) {
    return Location(
      latitude: latitude,
      longitude: longitude,
      country: placeMark.country ?? "",
      state: placeMark.administrativeArea ?? "",
      city: placeMark.locality ?? "",
    );
  }
}
