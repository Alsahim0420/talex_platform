/// Catálogo del instrumento de evaluación del encuestado.
///
/// El bloque (`AssessmentBlock`) y las dimensiones son internos: nunca se
/// muestran al encuestado, solo se usan para puntuar.
enum AssessmentBlock { workValues, needs, capabilities }

enum AssessmentFormat {
  /// Dos frases enfrentadas; 1 = claramente la A, 5 = claramente la B.
  pair,

  /// Una frase de experiencia; 1 = nunca, 5 = siempre.
  experience,
}

class AssessmentText {
  const AssessmentText(this.es, this.en);
  final String es, en;
  String of(String languageCode) => languageCode == 'en' ? en : es;
}

class AssessmentItem {
  const AssessmentItem({
    required this.id,
    required this.block,
    required this.format,
    required this.dimensionA,
    required this.statementA,
    this.dimensionB,
    this.statementB,
    this.timeLimitSeconds,
  });
  final String id;
  final AssessmentBlock block;
  final AssessmentFormat format;
  final String dimensionA;
  final String? dimensionB;
  final AssessmentText statementA;
  final AssessmentText? statementB;
  final int? timeLimitSeconds;
  bool get isPair => format == AssessmentFormat.pair;
}

abstract final class AssessmentDimension {
  static const stability = 'stability';
  static const teamwork = 'teamwork';
  static const results = 'results';
  static const competitiveness = 'competitiveness';
  static const innovation = 'innovation';
  static const respect = 'respect';
  static const detail = 'detail';

  static const performancePay = 'performance_pay';
  static const jobSecurity = 'job_security';
  static const peers = 'peer_relationships';
  static const recognition = 'recognition';
  static const growth = 'professional_growth';
  static const workload = 'sustainable_workload';
  static const autonomy = 'autonomy';
  static const feedback = 'feedback';
  static const roleClarity = 'role_clarity';
  static const purpose = 'purpose';
  static const training = 'training';
  static const flexibility = 'flexibility';

  static const technical = 'technical_knowledge';
  static const comparable = 'comparable_experience';
  static const pace = 'pace_and_volume';
  static const analytical = 'analytical_complexity';
  static const communication = 'communication';
  static const coordination = 'coordination';
  static const physical = 'physical_or_travel';
  static const tools = 'tools_and_languages';
}

typedef _D = AssessmentDimension;
typedef _T = AssessmentText;

AssessmentItem _value(String id, String a, String b, _T sa, _T sb) =>
    AssessmentItem(
      id: id,
      block: AssessmentBlock.workValues,
      format: AssessmentFormat.pair,
      dimensionA: a,
      dimensionB: b,
      statementA: sa,
      statementB: sb,
      timeLimitSeconds: 20,
    );

AssessmentItem _need(String id, String a, String b, _T sa, _T sb) =>
    AssessmentItem(
      id: id,
      block: AssessmentBlock.needs,
      format: AssessmentFormat.pair,
      dimensionA: a,
      dimensionB: b,
      statementA: sa,
      statementB: sb,
      timeLimitSeconds: 20,
    );

AssessmentItem _capability(String id, String dimension, _T statement) =>
    AssessmentItem(
      id: id,
      block: AssessmentBlock.capabilities,
      format: AssessmentFormat.experience,
      dimensionA: dimension,
      statementA: statement,
    );

abstract final class AssessmentCatalog {
  static final items = <AssessmentItem>[
    _value(
      'V01',
      _D.stability,
      _D.teamwork,
      _T(
        'Rindo mejor cuando las prioridades se mantienen en el tiempo',
        'I perform best when priorities stay consistent over time',
      ),
      _T(
        'Obtengo mis mejores resultados trabajando en colaboración',
        'I get my best results working collaboratively',
      ),
    ),
    _value(
      'V02',
      _D.results,
      _D.competitiveness,
      _T(
        'Prefiero que se me evalúe por lo que logro y no por las horas que dedico',
        'I prefer to be judged by what I achieve, not by the hours I put in',
      ),
      _T(
        'Me motiva saber cómo se compara mi desempeño con el de otros',
        'I am motivated by knowing how my performance compares with others',
      ),
    ),
    _value(
      'V03',
      _D.innovation,
      _D.respect,
      _T(
        'Me motiva replantear procesos que otros ya dan por resueltos',
        'I am motivated by rethinking processes others consider settled',
      ),
      _T(
        'Me importa que las decisiones que afectan a las personas se expliquen',
        'It matters to me that decisions affecting people are explained',
      ),
    ),
    _value(
      'V04',
      _D.detail,
      _D.stability,
      _T(
        'Reviso mi trabajo con rigor antes de darlo por terminado',
        'I review my work rigorously before considering it done',
      ),
      _T(
        'Me da tranquilidad contar con procedimientos claros',
        'Having clear procedures gives me peace of mind',
      ),
    ),
    _value(
      'V05',
      _D.competitiveness,
      _D.results,
      _T('Planteo los desacuerdos de frente', 'I raise disagreements head-on'),
      _T(
        'Me motivan las metas exigentes que me obligan a superarme',
        'I am motivated by demanding goals that push me to improve',
      ),
    ),
    _value(
      'V06',
      _D.innovation,
      _D.detail,
      _T(
        'Prefiero lanzar una primera versión y mejorarla sobre la marcha',
        'I prefer to launch a first version and improve it along the way',
      ),
      _T(
        'Sustento mis decisiones en datos y análisis',
        'I base my decisions on data and analysis',
      ),
    ),
    _value(
      'V07',
      _D.respect,
      _D.teamwork,
      _T(
        'Valoro trabajar con personas que piensan distinto a mí',
        'I value working with people who think differently from me',
      ),
      _T(
        'Comparto información con otras áreas aunque no me la pidan',
        'I share information with other areas even when they do not ask for it',
      ),
    ),
    _value(
      'V08',
      _D.results,
      _D.innovation,
      _T(
        'Asumo como propios los compromisos que acepto',
        'I take ownership of the commitments I accept',
      ),
      _T(
        'Asumo con naturalidad que probar algo nuevo implica equivocarse',
        'I naturally accept that trying something new means making mistakes',
      ),
    ),
    _value(
      'V09',
      _D.teamwork,
      _D.respect,
      _T(
        'Prefiero que los logros se reconozcan al equipo',
        'I prefer achievements to be credited to the team',
      ),
      _T(
        'Doy mucha importancia a que se apliquen los mismos criterios a todos',
        'I place great importance on applying the same criteria to everyone',
      ),
    ),
    _value(
      'V10',
      _D.stability,
      _D.detail,
      _T(
        'Valoro que los cambios se anuncien con tiempo y se apliquen de forma gradual',
        'I value changes being announced in advance and applied gradually',
      ),
      _T(
        'Prefiero entregar algo preciso aunque tome más tiempo',
        'I prefer to deliver something precise even if it takes longer',
      ),
    ),
    _value(
      'V11',
      _D.respect,
      _D.competitiveness,
      _T(
        'Me siento a gusto cuando el trato con los jefes es cercano',
        'I feel comfortable when the relationship with managers is close',
      ),
      _T('Defiendo mis posiciones con firmeza', 'I defend my positions firmly'),
    ),
    _value(
      'V12',
      _D.innovation,
      _D.results,
      _T(
        'Me entusiasman las iniciativas cuyo resultado todavía es incierto',
        'I am excited by initiatives whose outcome is still uncertain',
      ),
      _T(
        'Sostengo un nivel alto de exigencia de forma constante',
        'I consistently hold myself to a high standard',
      ),
    ),
    _value(
      'V13',
      _D.teamwork,
      _D.competitiveness,
      _T(
        'Ayudo a mis compañeros aunque no sea mi responsabilidad',
        'I help my colleagues even when it is not my responsibility',
      ),
      _T(
        'Me estimula competir por ser el mejor del sector',
        'I am driven by competing to be the best in the industry',
      ),
    ),
    _value(
      'V14',
      _D.detail,
      _D.respect,
      _T(
        'Me esfuerzo por cumplir estándares de calidad exactos',
        'I strive to meet exact quality standards',
      ),
      _T(
        'Tomo en cuenta cómo afecta a cada persona una decisión de trabajo',
        'I consider how a work decision affects each person',
      ),
    ),
    _value(
      'V15',
      _D.stability,
      _D.innovation,
      _T(
        'Prefiero perfeccionar un método probado antes que reemplazarlo',
        'I prefer refining a proven method rather than replacing it',
      ),
      _T(
        'Suelo proponer alternativas a la forma habitual de trabajar',
        'I often propose alternatives to the usual way of working',
      ),
    ),
    _value(
      'V16',
      _D.results,
      _D.detail,
      _T(
        'Mido mi trabajo con indicadores concretos',
        'I measure my work with concrete indicators',
      ),
      _T(
        'Noto enseguida los errores pequeños que otros pasan por alto',
        'I immediately notice small mistakes others overlook',
      ),
    ),
    _value(
      'V17',
      _D.teamwork,
      _D.stability,
      _T(
        'Me gusta construir las soluciones junto con otros',
        'I like building solutions together with others',
      ),
      _T(
        'Trabajo con comodidad dentro de lineamientos establecidos',
        'I work comfortably within established guidelines',
      ),
    ),
    _value(
      'V18',
      _D.competitiveness,
      _D.detail,
      _T(
        'Rindo mejor bajo presión competitiva',
        'I perform best under competitive pressure',
      ),
      _T('Documento con cuidado lo que hago', 'I carefully document what I do'),
    ),
    _value(
      'V19',
      _D.results,
      _D.teamwork,
      _T(
        'Me enfoco en terminar lo que empiezo aunque surjan obstáculos',
        'I focus on finishing what I start even when obstacles arise',
      ),
      _T(
        'Busco acuerdos antes de avanzar',
        'I seek agreement before moving forward',
      ),
    ),
    _value(
      'V20',
      _D.competitiveness,
      _D.innovation,
      _T(
        'Me gusta que se reconozca públicamente a quien logra más',
        'I like it when whoever achieves the most is publicly recognized',
      ),
      _T(
        'Me siento cómodo decidiendo con información incompleta',
        'I feel comfortable deciding with incomplete information',
      ),
    ),
    _value(
      'V21',
      _D.respect,
      _D.stability,
      _T(
        'Valoro que se escuche a todos antes de decidir',
        'I value everyone being heard before a decision is made',
      ),
      _T(
        'Planifico con anticipación para reducir imprevistos',
        'I plan ahead to reduce surprises',
      ),
    ),
    _value(
      'V22',
      _D.detail,
      _D.teamwork,
      _T(
        'Me gusta entender cada detalle antes de actuar',
        'I like to understand every detail before acting',
      ),
      _T(
        'Disfruto coordinar con personas de distintas áreas',
        'I enjoy coordinating with people from different areas',
      ),
    ),
    _value(
      'V23',
      _D.competitiveness,
      _D.respect,
      _T(
        'Disfruto los debates intensos sobre cómo hacer las cosas',
        'I enjoy intense debates about how to do things',
      ),
      _T(
        'Me importa que los errores se traten en privado y con respeto',
        'It matters to me that mistakes are handled privately and respectfully',
      ),
    ),
    _value(
      'V24',
      _D.stability,
      _D.results,
      _T(
        'Valoro saber con certeza cómo será mi trabajo dentro de un año',
        'I value knowing for certain what my job will look like a year from now',
      ),
      _T(
        'Me satisface que mi aporte se refleje en resultados visibles',
        'I find it satisfying when my contribution shows in visible results',
      ),
    ),
    _value(
      'V25',
      _D.detail,
      _D.innovation,
      _T(
        'Valoro los procesos de control y verificación',
        'I value control and verification processes',
      ),
      _T(
        'Disfruto explorar métodos que nadie usa todavía en el equipo',
        'I enjoy exploring methods nobody on the team uses yet',
      ),
    ),
    _value(
      'V26',
      _D.stability,
      _D.competitiveness,
      _T(
        'Me gusta que las decisiones importantes sigan un proceso conocido',
        'I like important decisions to follow a known process',
      ),
      _T(
        'Busco ganar las oportunidades antes que otros',
        'I try to win opportunities before others do',
      ),
    ),
    _value(
      'V27',
      _D.innovation,
      _D.teamwork,
      _T(
        'Valoro los entornos donde las reglas pueden cuestionarse',
        'I value environments where rules can be questioned',
      ),
      _T(
        'Considero que el éxito del grupo pesa más que el mío',
        'I believe the group’s success matters more than my own',
      ),
    ),
    _value(
      'V28',
      _D.respect,
      _D.results,
      _T(
        'Busco entornos donde todos reciban la misma consideración sin importar el cargo',
        'I look for environments where everyone gets the same consideration regardless of position',
      ),
      _T(
        'Priorizo lo que más impacto tiene sobre el objetivo',
        'I prioritize what has the greatest impact on the goal',
      ),
    ),
    _need(
      'N01',
      _D.performancePay,
      _D.jobSecurity,
      _T(
        'Que una parte importante de mis ingresos dependa de mis resultados',
        'That a significant part of my income depends on my results',
      ),
      _T(
        'Tener certeza de continuidad laboral a mediano plazo',
        'Having certainty of job continuity in the medium term',
      ),
    ),
    _need(
      'N02',
      _D.peers,
      _D.recognition,
      _T(
        'Construir relaciones cercanas con mis compañeros',
        'Building close relationships with my colleagues',
      ),
      _T(
        'Recibir reconocimiento explícito cuando el trabajo sale bien',
        'Receiving explicit recognition when the work goes well',
      ),
    ),
    _need(
      'N03',
      _D.growth,
      _D.workload,
      _T(
        'Contar con un camino claro para ascender',
        'Having a clear path to promotion',
      ),
      _T(
        'Tener una carga de trabajo que no invada mi vida personal',
        'Having a workload that does not intrude on my personal life',
      ),
    ),
    _need(
      'N04',
      _D.autonomy,
      _D.feedback,
      _T(
        'Decidir por mi cuenta cómo organizar mi trabajo',
        'Deciding on my own how to organize my work',
      ),
      _T(
        'Recibir retroalimentación frecuente de mi jefe',
        'Receiving frequent feedback from my manager',
      ),
    ),
    _need(
      'N05',
      _D.roleClarity,
      _D.purpose,
      _T(
        'Saber con precisión qué se espera de mí',
        'Knowing precisely what is expected of me',
      ),
      _T(
        'Que mi trabajo tenga un impacto social o ambiental visible',
        'That my work has a visible social or environmental impact',
      ),
    ),
    _need(
      'N06',
      _D.training,
      _D.workload,
      _T(
        'Acceder a formación que amplíe mis capacidades',
        'Access to training that expands my skills',
      ),
      _T(
        'Terminar la jornada a una hora razonable',
        'Finishing the workday at a reasonable time',
      ),
    ),
    _need(
      'N07',
      _D.performancePay,
      _D.flexibility,
      _T(
        'Poder ganar más cuando mi desempeño es superior',
        'Being able to earn more when my performance is outstanding',
      ),
      _T(
        'Poder ajustar mi horario según mis necesidades',
        'Being able to adjust my schedule to my needs',
      ),
    ),
    _need(
      'N08',
      _D.recognition,
      _D.purpose,
      _T(
        'Que mis aportes sean visibles para la dirección',
        'That my contributions are visible to leadership',
      ),
      _T(
        'Sentir que mi trabajo contribuye a algo más grande',
        'Feeling that my work contributes to something bigger',
      ),
    ),
    _need(
      'N09',
      _D.flexibility,
      _D.peers,
      _T(
        'Poder elegir desde dónde trabajo',
        'Being able to choose where I work from',
      ),
      _T(
        'Trabajar en un ambiente cálido y cercano',
        'Working in a warm, close-knit environment',
      ),
    ),
    _need(
      'N10',
      _D.feedback,
      _D.training,
      _T(
        'Tener conversaciones periódicas sobre mi desempeño',
        'Having regular conversations about my performance',
      ),
      _T(
        'Aprender algo nuevo de forma constante en el trabajo',
        'Constantly learning something new at work',
      ),
    ),
    _need(
      'N11',
      _D.autonomy,
      _D.roleClarity,
      _T(
        'Trabajar sin supervisión cercana',
        'Working without close supervision',
      ),
      _T(
        'Conocer de antemano los criterios con que se evaluará mi trabajo',
        'Knowing in advance the criteria my work will be evaluated on',
      ),
    ),
    _need(
      'N12',
      _D.jobSecurity,
      _D.growth,
      _T(
        'Contar con un contrato y unos ingresos predecibles',
        'Having a contract and predictable income',
      ),
      _T(
        'Asumir más responsabilidades en poco tiempo',
        'Taking on more responsibility in a short time',
      ),
    ),
    _capability(
      'C01',
      _D.technical,
      _T(
        'He resuelto problemas técnicos de mi área sin necesitar el apoyo de un especialista',
        'I have solved technical problems in my field without needing a specialist’s help',
      ),
    ),
    _capability(
      'C02',
      _D.comparable,
      _T(
        'He desempeñado funciones muy similares a las que exige este cargo',
        'I have performed duties very similar to those this position requires',
      ),
    ),
    _capability(
      'C03',
      _D.pace,
      _T(
        'He sostenido periodos de trabajo intenso durante semanas sin bajar la calidad',
        'I have sustained weeks of intense work without lowering quality',
      ),
    ),
    _capability(
      'C04',
      _D.analytical,
      _T(
        'He analizado problemas con muchas variables y he llegado a una solución clara',
        'I have analyzed problems with many variables and reached a clear solution',
      ),
    ),
    _capability(
      'C05',
      _D.communication,
      _T(
        'He explicado ideas complejas de forma que personas de otras áreas las entiendan',
        'I have explained complex ideas so that people from other areas understand them',
      ),
    ),
    _capability(
      'C06',
      _D.coordination,
      _T(
        'He coordinado trabajo con áreas o proveedores sobre los que no tenía autoridad directa',
        'I have coordinated work with areas or suppliers over which I had no direct authority',
      ),
    ),
    _capability(
      'C07',
      _D.physical,
      _T(
        'He cumplido con desplazamientos o exigencias físicas similares a las de este cargo',
        'I have met travel or physical demands similar to those of this position',
      ),
    ),
    _capability(
      'C08',
      _D.tools,
      _T(
        'He usado en el día a día las herramientas o idiomas que requiere este cargo',
        'I have used the tools or languages this position requires on a daily basis',
      ),
    ),
  ];

  static final List<String> allIds = [for (final item in items) item.id];

  static final Map<String, AssessmentItem> _byId = {
    for (final item in items) item.id: item,
  };

  static AssessmentItem? byId(String id) => _byId[id];

  static List<String> idsOf(AssessmentBlock block) => [
    for (final item in items)
      if (item.block == block) item.id,
  ];
}

/// Promedio 1–5 del bloque de capacidades, o null si no hay respuestas.
double? capabilitiesAverage(Map<String, int> answers) {
  final values = AssessmentCatalog.idsOf(
    AssessmentBlock.capabilities,
  ).map((id) => answers[id]).whereType<int>().toList();
  if (values.isEmpty) return null;
  return values.reduce((a, b) => a + b) / values.length;
}

/// Preferencia promedio por dimensión en los pares, de -2 a 2.
///
/// Cada respuesta suma `3 - valor` a la dimensión A y `valor - 3` a la B,
/// así "Claramente la A" da +2 a A y -2 a B, y "Ambas por igual" da 0.
Map<String, double> pairDimensionScores(
  Map<String, int> answers,
  AssessmentBlock block,
) {
  final sums = <String, int>{};
  final counts = <String, int>{};
  void add(String dimension, int score) {
    sums[dimension] = (sums[dimension] ?? 0) + score;
    counts[dimension] = (counts[dimension] ?? 0) + 1;
  }

  for (final item in AssessmentCatalog.items) {
    if (item.block != block || !item.isPair) continue;
    final value = answers[item.id];
    if (value == null) continue;
    add(item.dimensionA, 3 - value);
    add(item.dimensionB!, value - 3);
  }
  return {
    for (final entry in sums.entries)
      entry.key: entry.value / counts[entry.key]!,
  };
}
