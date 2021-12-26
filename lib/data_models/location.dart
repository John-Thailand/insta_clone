import 'dart:convert';

class Location {
  final double latitude;
  final double longitude;
  final String country;
  final String state;
  final String city;
  Location({
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.state,
    required this.city,
  });

  Location copyWith({
    double? latitude,
    double? longitude,
    String? country,
    String? state,
    String? city,
  }) {
    return Location(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'country': country,
      'state': state,
      'city': city,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      country: map['country'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Location(latitude: $latitude, longitude: $longitude, country: $country, state: $state, city: $city)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Location &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.country == country &&
        other.state == state &&
        other.city == city;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^
        longitude.hashCode ^
        country.hashCode ^
        state.hashCode ^
        city.hashCode;
  }
}
