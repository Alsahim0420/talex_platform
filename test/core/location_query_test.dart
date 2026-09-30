import 'package:flutter_test/flutter_test.dart';
import 'package:talex_platform/core/location/location_catalog.dart';
import 'package:talex_platform/core/location/location_query.dart';

void main() {
  test('bogota without accent matches Bogotá', () {
    expect(locationQueryMatches('Bogotá', 'bogota'), isTrue);
    expect(locationQueryMatches('Bogotá', 'BOG'), isTrue);
    expect(locationQueryMatches('Medellín', 'medellin'), isTrue);
    expect(locationQueryMatches('Cundinamarca', 'xyz'), isFalse);
  });

  test('country iso maps to the right administrative label kind', () {
    expect(divisionKindForCountry('CO'), AdminDivisionKind.department);
    expect(divisionKindForCountry('US'), AdminDivisionKind.state);
    expect(divisionKindForCountry('MX'), AdminDivisionKind.state);
    expect(divisionKindForCountry('ES'), AdminDivisionKind.community);
  });

  test('catalog loads countries and Colombia departments without assets', () async {
    final catalog = LocationCatalog();
    final countries = await catalog.countries(locale: 'es');
    expect(countries.first, 'Colombia');
    expect(countries, contains('México'));
    expect(countries.length, greaterThan(100));
    final departments = await catalog.subdivisions('Colombia', locale: 'es');
    expect(departments, hasLength(32));
    expect(departments, contains('Cundinamarca'));
    final cities = await catalog.cities('Colombia', 'Cundinamarca', locale: 'es');
    expect(cities, contains('Bogotá'));
  });
}
