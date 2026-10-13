const test = require('node:test');
const assert = require('node:assert/strict');
const {internals} = require('../affinity');

const questions = [
  {
    code: 'V01',
    order: 1,
    front: 'values',
    format: 'pair',
    dimensionA: 'Estabilidad',
    dimensionB: 'Trabajo en equipo',
    statementA: 'Rindo mejor con prioridades estables',
    statementB: 'Rindo mejor en colaboración',
  },
  {
    code: 'C01',
    order: 2,
    front: 'capabilities',
    format: 'experience',
    dimensionA: 'Comunicación',
    statementA: 'He explicado ideas complejas',
  },
  {code: 'X99', order: 3, front: 'values', format: 'pair', active: false},
];

test('buildResponses scores pairs and experiences and skips inactive or invalid answers', () => {
  const {responses, profile, total} = internals.buildResponses(
    {V01: 5, C01: 4, X99: 1, ZZZ: 3},
    questions,
  );
  assert.equal(total, 2);
  assert.equal(responses.length, 2);
  assert.equal(responses[0].respuesta, 'Claramente la B');
  const byName = Object.fromEntries(profile.map((item) => [item.dimension, item.preferencia]));
  assert.equal(byName['Trabajo en equipo'], 2);
  assert.equal(byName['Estabilidad'], -2);
  assert.equal(byName['Comunicación'], 1);
});

test('buildResponses ignores out-of-range values', () => {
  const {responses} = internals.buildResponses({V01: 9, C01: '2'}, questions);
  assert.equal(responses.length, 1);
  assert.equal(responses[0].codigo, 'C01');
});

test('levelFromScore uses fixed bands', () => {
  assert.equal(internals.levelFromScore(70), 'high');
  assert.equal(internals.levelFromScore(69), 'medium');
  assert.equal(internals.levelFromScore(45), 'medium');
  assert.equal(internals.levelFromScore(44), 'low');
});

test('normalizeResult derives the level from the score, not from the model label', () => {
  const result = internals.normalizeResult(JSON.stringify({
    score: 82,
    nivel: 'baja',
    confianza: 'alta',
    resumen: 'Comparte la preferencia por el trabajo colaborativo.',
    coincidencias: [{aspecto: 'Colaboración', evidencia: 'Elige con claridad el trabajo en equipo.'}, {aspecto: ''}],
    diferencias: [],
    temasParaConversar: ['Ritmo de trabajo'],
    datosFaltantes: [],
  }));
  assert.equal(result.level, 'high');
  assert.equal(result.confidence, 'high');
  assert.equal(result.alignments.length, 1);
});

test('normalizeResult rejects malformed output', () => {
  assert.throws(() => internals.normalizeResult('not json'), {code: 'invalid_response'});
  assert.throws(() => internals.normalizeResult({score: 140, resumen: 'x'}), {code: 'invalid_response'});
  assert.throws(() => internals.normalizeResult({score: 50, resumen: '  '}), {code: 'invalid_response'});
});

test('companyHasDna requires values, culture or sought characteristics', () => {
  assert.equal(internals.companyHasDna(internals.companyContext({name: 'Acme'})), false);
  assert.equal(
    internals.companyHasDna(internals.companyContext({valuesList: ['Respeto'], valuesText: 'Respeto, Innovación'})),
    true,
  );
  assert.deepEqual(
    internals.companyContext({valuesList: ['Respeto'], valuesText: 'respeto; Innovación'}).valores,
    ['Respeto', 'Innovación'],
  );
});
