String foldLocationQuery(String input) {
  final mapped = input.toLowerCase().replaceAllMapped(
    RegExp(r'[áàäâãéèëêíìïîóòöôõúùüûñç]'),
    (match) {
      final char = match.group(0)!;
      return switch (char) {
        'á' || 'à' || 'ä' || 'â' || 'ã' => 'a',
        'é' || 'è' || 'ë' || 'ê' => 'e',
        'í' || 'ì' || 'ï' || 'î' => 'i',
        'ó' || 'ò' || 'ö' || 'ô' || 'õ' => 'o',
        'ú' || 'ù' || 'ü' || 'û' => 'u',
        'ñ' => 'n',
        'ç' => 'c',
        _ => char,
      };
    },
  );
  return mapped;
}

bool locationQueryMatches(String value, String query) {
  final needle = foldLocationQuery(query.trim());
  if (needle.isEmpty) return true;
  return foldLocationQuery(value).contains(needle);
}

enum AdminDivisionKind { department, state, community, region }

AdminDivisionKind divisionKindForCountry(String? iso) => switch (iso) {
  'CO' => AdminDivisionKind.department,
  'US' || 'MX' || 'BR' || 'AU' || 'IN' || 'CA' || 'AR' => AdminDivisionKind.state,
  'ES' || 'IT' => AdminDivisionKind.community,
  _ => AdminDivisionKind.region,
};
