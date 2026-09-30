import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:talex_platform/core/location/colombia_data.dart';
import 'package:talex_platform/core/location/countries_data.dart';

class LocationCatalog {
  LocationCatalog({http.Client? client}) : _client = client ?? http.Client();

  static const _base = 'https://countriesnow.space/api/v0.1';
  final http.Client _client;

  Map<String, String>? _countriesEs;
  Map<String, String>? _countriesEn;
  List<Map<String, dynamic>>? _colombia;
  final _subdivisionApi = <String, String>{};

  String _key(String country, String subdivision) =>
      '${country.trim().toLowerCase()}|${subdivision.trim().toLowerCase()}';

  void _ensureCountries() {
    _countriesEs ??= countriesEs;
    _countriesEn ??= countriesEn;
  }

  void _ensureColombia() {
    _colombia ??= [
      for (final item in colombiaDepartments)
        {
          'departamento': item['departamento'],
          'ciudades': List<String>.from(item['ciudades']! as List),
        },
    ];
  }

  Future<List<String>> countries({required String locale}) async {
    _ensureCountries();
    final source = locale == 'en' ? _countriesEn! : _countriesEs!;
    final names = source.values.toList()..sort((a, b) => a.compareTo(b));
    const colombiaEs = 'Colombia';
    final colombia = names.firstWhere(
      (item) => item.toLowerCase() == 'colombia',
      orElse: () => colombiaEs,
    );
    names.removeWhere((item) => item.toLowerCase() == 'colombia');
    names.insert(0, colombia);
    return names;
  }

  String? isoForCountry(String country, {required String locale}) {
    _ensureCountries();
    final source = locale == 'en' ? _countriesEn : _countriesEs;
    if (source == null) return null;
    for (final entry in source.entries) {
      if (entry.value.toLowerCase() == country.toLowerCase()) return entry.key;
    }
    final other = locale == 'en' ? _countriesEs : _countriesEn;
    for (final entry in (other ?? {}).entries) {
      if (entry.value.toLowerCase() == country.toLowerCase()) return entry.key;
    }
    return null;
  }

  bool isColombia(String country) => country.trim().toLowerCase() == 'colombia';


  Future<List<String>> subdivisions(String country, {required String locale}) async {
    if (isColombia(country)) {
      _ensureColombia();
      final names = _colombia!
          .map((item) => item['departamento'] as String)
          .toList()
        ..sort((a, b) => a.compareTo(b));
      return names;
    }
    final english = _englishCountryName(country, locale);
    final response = await _client.post(
      Uri.parse('$_base/countries/states'),
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({'country': english}),
    );
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final data = body['data'];
    final names = <String>[];
    if (data is Map && data['states'] is List) {
      for (final item in data['states'] as List) {
        if (item is Map && item['name'] is String) {
          final original = item['name'] as String;
          final display = _tidySubdivision(original);
          names.add(display);
          _subdivisionApi[_key(country, display)] = original;
        }
      }
    }
    names.sort((a, b) => a.compareTo(b));
    return names;
  }

  Future<List<String>> cities(
    String country,
    String subdivision, {
    required String locale,
  }) async {
    if (isColombia(country)) {
      _ensureColombia();
      final match = _colombia!.where(
        (item) =>
            (item['departamento'] as String).toLowerCase() ==
            subdivision.toLowerCase(),
      );
      final cities = match.isEmpty ? null : match.first['ciudades'];
      if (cities is List) {
        return [
          for (final item in cities)
            if (item is String && item.trim().isNotEmpty) item,
        ]..sort((a, b) => a.compareTo(b));
      }
      return const [];
    }
    final english = _englishCountryName(country, locale);
    final response = await _client.post(
      Uri.parse('$_base/countries/state/cities'),
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({
        'country': english,
        'state': _subdivisionApi[_key(country, subdivision)] ?? subdivision,
      }),
    );
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final data = body['data'];
    final names = <String>[];
    if (data is List) {
      for (final item in data) {
        if (item is String && item.trim().isNotEmpty) names.add(item);
      }
    }
    names.sort((a, b) => a.compareTo(b));
    return names;
  }

  Future<List<String>> citiesByCountry(String country, {required String locale}) async {
    if (isColombia(country)) return const [];
    final english = _englishCountryName(country, locale);
    final response = await _client.post(
      Uri.parse('$_base/countries/cities'),
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({'country': english}),
    );
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final data = body['data'];
    final names = <String>[];
    if (data is List) {
      for (final item in data) {
        if (item is String && item.trim().isNotEmpty) names.add(item);
      }
    }
    names.sort((a, b) => a.compareTo(b));
    return names;
  }

  String _englishCountryName(String country, String locale) {
    final iso = isoForCountry(country, locale: locale);
    if (iso != null && _countriesEn != null) {
      return _countriesEn![iso] ?? country;
    }
    return country;
  }

  String _tidySubdivision(String name) {
    return name
        .replaceAll(RegExp(r'\s+Department$', caseSensitive: false), '')
        .replaceAll(RegExp(r'\s+Province$', caseSensitive: false), '')
        .replaceAll(RegExp(r'\s+Region$', caseSensitive: false), '')
        .replaceAll(RegExp(r'\s+State$', caseSensitive: false), '')
        .replaceAll(RegExp(r'\s+District$', caseSensitive: false), '')
        .trim();
  }
}
