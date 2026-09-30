const fs = require('fs');
const path = require('path');

function dartString(value) {
  return `'${String(value).replace(/\\/g, '\\\\').replace(/'/g, "\\'")}'`;
}

function dartMap(obj) {
  const entries = Object.entries(obj).map(
    ([key, value]) => `  ${dartString(key)}: ${dartString(value)},`,
  );
  return `{\n${entries.join('\n')}\n}`;
}

const es = JSON.parse(fs.readFileSync('assets/location/countries_es.json', 'utf8'));
const en = JSON.parse(fs.readFileSync('assets/location/countries_en.json', 'utf8'));
fs.writeFileSync(
  path.join('lib/core/location/countries_data.dart'),
  `const countriesEs = <String, String>${dartMap(es)};\n\nconst countriesEn = <String, String>${dartMap(en)};\n`,
);

const colombia = JSON.parse(fs.readFileSync('assets/location/colombia.json', 'utf8'));
const departments = colombia
  .map((item) => {
    const cities = item.ciudades.map(dartString).join(', ');
    return `  {'departamento': ${dartString(item.departamento)}, 'ciudades': <String>[${cities}]},`;
  })
  .join('\n');
fs.writeFileSync(
  path.join('lib/core/location/colombia_data.dart'),
  `const colombiaDepartments = <Map<String, Object>>[\n${departments}\n];\n`,
);

console.log(`wrote ${Object.keys(es).length} countries and ${colombia.length} departments`);
