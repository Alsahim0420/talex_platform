class DnaPreset {
  const DnaPreset(this.type, this.key, this.es, this.en);
  final String type, key, es, en;
}

abstract final class DnaCatalogType {
  static const values = 'values';
  static const culture = 'culture';
  static const standout = 'standout';
  static const area = 'area';
}

const dnaValuePresets = <DnaPreset>[
  DnaPreset(DnaCatalogType.values, 'integrity', 'Integridad', 'Integrity'),
  DnaPreset(DnaCatalogType.values, 'respect', 'Respeto', 'Respect'),
  DnaPreset(DnaCatalogType.values, 'collaboration', 'Colaboración', 'Collaboration'),
  DnaPreset(DnaCatalogType.values, 'innovation', 'Innovación', 'Innovation'),
  DnaPreset(DnaCatalogType.values, 'excellence', 'Excelencia', 'Excellence'),
  DnaPreset(DnaCatalogType.values, 'empathy', 'Empatía', 'Empathy'),
  DnaPreset(DnaCatalogType.values, 'responsibility', 'Responsabilidad', 'Responsibility'),
  DnaPreset(DnaCatalogType.values, 'transparency', 'Transparencia', 'Transparency'),
  DnaPreset(DnaCatalogType.values, 'trust', 'Confianza', 'Trust'),
  DnaPreset(DnaCatalogType.values, 'inclusion', 'Inclusión', 'Inclusion'),
  DnaPreset(DnaCatalogType.values, 'service', 'Servicio', 'Service'),
  DnaPreset(DnaCatalogType.values, 'quality', 'Calidad', 'Quality'),
  DnaPreset(DnaCatalogType.values, 'sustainability', 'Sostenibilidad', 'Sustainability'),
  DnaPreset(DnaCatalogType.values, 'learning', 'Aprendizaje', 'Learning'),
  DnaPreset(DnaCatalogType.values, 'commitment', 'Compromiso', 'Commitment'),
];

const dnaCulturePresets = <DnaPreset>[
  DnaPreset(DnaCatalogType.culture, 'close', 'Cercana y humana', 'Close and human'),
  DnaPreset(DnaCatalogType.culture, 'formal', 'Formal y estructurada', 'Formal and structured'),
  DnaPreset(DnaCatalogType.culture, 'learning', 'Aprendizaje continuo', 'Continuous learning'),
  DnaPreset(DnaCatalogType.culture, 'agile', 'Ágil', 'Agile'),
  DnaPreset(DnaCatalogType.culture, 'autonomous', 'Autónoma', 'Autonomous'),
  DnaPreset(DnaCatalogType.culture, 'collaborative', 'Colaborativa', 'Collaborative'),
  DnaPreset(DnaCatalogType.culture, 'results', 'Orientada a resultados', 'Results-oriented'),
  DnaPreset(DnaCatalogType.culture, 'innovation', 'Innovadora', 'Innovative'),
  DnaPreset(DnaCatalogType.culture, 'customer', 'Centrada en el cliente', 'Customer-centered'),
  DnaPreset(DnaCatalogType.culture, 'flexible', 'Flexible', 'Flexible'),
  DnaPreset(DnaCatalogType.culture, 'data', 'Basada en datos', 'Data-driven'),
  DnaPreset(DnaCatalogType.culture, 'remote', 'Remota o híbrida', 'Remote or hybrid'),
];

const dnaStandoutPresets = <DnaPreset>[
  DnaPreset(DnaCatalogType.standout, 'ownership', 'Sentido de dueño', 'Ownership'),
  DnaPreset(DnaCatalogType.standout, 'communication', 'Comunicación clara', 'Clear communication'),
  DnaPreset(DnaCatalogType.standout, 'adaptability', 'Adaptabilidad', 'Adaptability'),
  DnaPreset(DnaCatalogType.standout, 'initiative', 'Iniciativa', 'Initiative'),
  DnaPreset(DnaCatalogType.standout, 'teamwork', 'Trabajo en equipo', 'Teamwork'),
  DnaPreset(DnaCatalogType.standout, 'leadership', 'Liderazgo', 'Leadership'),
  DnaPreset(DnaCatalogType.standout, 'problem_solving', 'Resolución de problemas', 'Problem solving'),
  DnaPreset(DnaCatalogType.standout, 'empathy', 'Empatía con el cliente', 'Customer empathy'),
  DnaPreset(DnaCatalogType.standout, 'accountability', 'Cumplimiento', 'Accountability'),
  DnaPreset(DnaCatalogType.standout, 'curiosity', 'Curiosidad', 'Curiosity'),
  DnaPreset(DnaCatalogType.standout, 'resilience', 'Resiliencia', 'Resilience'),
  DnaPreset(DnaCatalogType.standout, 'teaching', 'Capacidad de enseñar', 'Ability to teach'),
];

const allDnaPresets = <DnaPreset>[
  ...dnaValuePresets,
  ...dnaCulturePresets,
  ...dnaStandoutPresets,
];

String dnaCatalogLabel(DnaPreset preset, String languageCode) =>
    languageCode == 'en' ? preset.en : preset.es;

String dnaNormalize(String value) {
  var normalized = value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  const from = 'áéíóúüñ';
  const to = 'aeiouun';
  for (var i = 0; i < from.length; i++) {
    normalized = normalized.replaceAll(from[i], to[i]);
  }
  return normalized;
}

String dnaCatalogDocId(String type, String labelOrKey) {
  final raw = dnaNormalize(labelOrKey).replaceAll(RegExp('[^a-z0-9]+'), '_');
  final compact = raw.replaceAll(RegExp('_+'), '_').replaceAll(RegExp(r'^_|_$'), '');
  return '${type}_$compact';
}

List<String> parseDnaList(String? raw) {
  if (raw == null || raw.trim().isEmpty) return const [];
  return uniqueDnaLabels(
    raw.split(RegExp(r'\s*[·|,;]\s*|\n+')),
  );
}

String joinDnaList(Iterable<String> values) =>
    uniqueDnaLabels(values).join(' · ');

bool isDnaPresetLabel(String type, String label) {
  return allDnaPresets.any(
    (item) =>
        item.type == type &&
        (dnaNormalize(item.es) == dnaNormalize(label) ||
            dnaNormalize(item.en) == dnaNormalize(label)),
  );
}

List<String> uniqueDnaLabels(Iterable<String> values) {
  final seen = <String>{};
  final result = <String>[];
  for (final value in values) {
    final key = value.trim();
    if (key.isEmpty) continue;
    if (seen.add(dnaNormalize(key))) result.add(key);
  }
  return result;
}
