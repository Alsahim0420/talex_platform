const {execFileSync} = require('child_process');
const https = require('https');

const PROJECT = 'talex-platform';
const APPLY = process.argv.includes('--apply');
const ROOT = `https://firestore.googleapis.com/v1/projects/${PROJECT}/databases/(default)/documents`;

function token() {
  const bin = process.platform === 'win32' ? 'gcloud.cmd' : 'gcloud';
  return execFileSync(bin, ['auth', 'print-access-token'], {
    encoding: 'utf8',
    stdio: ['ignore', 'pipe', 'ignore'],
    shell: process.platform === 'win32',
  }).trim();
}

function request(method, url, body, auth) {
  return new Promise((resolve, reject) => {
    const target = new URL(url);
    const payload = body == null ? null : JSON.stringify(body);
    const req = https.request(
      {
        method,
        hostname: target.hostname,
        path: target.pathname + target.search,
        headers: {
          Authorization: `Bearer ${auth}`,
          'Content-Type': 'application/json',
          'x-goog-user-project': PROJECT,
          ...(payload ? {'Content-Length': Buffer.byteLength(payload)} : {}),
        },
      },
      (res) => {
        let data = '';
        res.on('data', (chunk) => (data += chunk));
        res.on('end', () => resolve({status: res.statusCode, data}));
      },
    );
    req.on('error', reject);
    if (payload) req.write(payload);
    req.end();
  });
}

const GABRIEL_ONLY = process.argv.includes('--gabriel-only');

function matchesTarget(value) {
  const text = String(value || '')
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase();
  if (!text) return false;
  if (text.includes('gabriel')) return true;
  if (text.includes('prueba')) return true;
  if (text.includes('rpeuba')) return true;
  if (GABRIEL_ONLY) return false;
  if (text.includes('samuco')) return true;
  if (text.includes('paola') && text.includes('velazco')) return true;
  if (text.includes('paolavelazco')) return true;
  return false;
}

function fieldString(fields, key) {
  return fields?.[key]?.stringValue || '';
}

function docId(name) {
  return String(name || '').split('/').pop();
}

async function listAuthUsers() {
  const out = require('os').tmpdir() + require('path').sep + 'talex-auth-users.json';
  const bin = process.platform === 'win32' ? 'firebase.cmd' : 'firebase';
  execFileSync(
    bin,
    ['auth:export', out, '--project', PROJECT, '--format', 'json'],
    {stdio: ['ignore', 'pipe', 'pipe'], shell: process.platform === 'win32'},
  );
  const raw = require('fs').readFileSync(out, 'utf8');
  const body = JSON.parse(raw || '{}');
  return body.users || [];
}

async function listCollection(auth, collectionId) {
  const docs = [];
  let pageToken = '';
  do {
    const url = new URL(`${ROOT}/${collectionId}`);
    url.searchParams.set('pageSize', '300');
    if (pageToken) url.searchParams.set('pageToken', pageToken);
    const res = await request('GET', url.toString(), null, auth);
    const body = JSON.parse(res.data || '{}');
    if (res.status >= 400) {
      throw new Error(`list ${collectionId} failed ${res.status}: ${res.data}`);
    }
    docs.push(...(body.documents || []));
    pageToken = body.nextPageToken || '';
  } while (pageToken);
  return docs;
}

async function queryByEmail(auth, collectionId, email) {
  const res = await request(
    'POST',
    `${ROOT}:runQuery`,
    {
      structuredQuery: {
        from: [{collectionId}],
        where: {
          fieldFilter: {
            field: {fieldPath: 'email'},
            op: 'EQUAL',
            value: {stringValue: email},
          },
        },
      },
    },
    auth,
  );
  const rows = JSON.parse(res.data || '[]');
  return rows.map((row) => row.document).filter((doc) => doc?.name);
}

async function queryByCompany(auth, collectionId, companyId) {
  const res = await request(
    'POST',
    `${ROOT}:runQuery`,
    {
      structuredQuery: {
        from: [{collectionId}],
        where: {
          fieldFilter: {
            field: {fieldPath: 'companyId'},
            op: 'EQUAL',
            value: {stringValue: companyId},
          },
        },
      },
    },
    auth,
  );
  const rows = JSON.parse(res.data || '[]');
  return rows.map((row) => row.document).filter((doc) => doc?.name);
}

async function deleteDoc(auth, nameOrPath) {
  const url = nameOrPath.startsWith('projects/')
    ? `https://firestore.googleapis.com/v1/${nameOrPath}`
    : `${ROOT}/${nameOrPath}`;
  const res = await request('DELETE', url, null, auth);
  return res.status;
}

async function purgeEmail(auth, email, uid) {
  const result = {
    email,
    uid: uid || null,
    authDeleted: false,
    deleted: [],
  };
  const companyIds = new Set();

  const userDocs = await queryByEmail(auth, 'users', email);
  for (const doc of userDocs) {
    const companyId = fieldString(doc.fields, 'companyId');
    if (companyId) companyIds.add(companyId);
    if (APPLY) await deleteDoc(auth, doc.name);
    result.deleted.push(`users/${docId(doc.name)}`);
  }
  if (uid) {
    const res = await request('GET', `${ROOT}/users/${uid}`, null, auth);
    if (res.status === 200) {
      const doc = JSON.parse(res.data || '{}');
      const companyId = fieldString(doc.fields, 'companyId');
      if (companyId) companyIds.add(companyId);
      if (APPLY) await deleteDoc(auth, `users/${uid}`);
      result.deleted.push(`users/${uid}`);
    }
  }

  const inviteDocs = await queryByEmail(auth, 'activation_invites', email);
  for (const doc of inviteDocs) {
    if (APPLY) await deleteDoc(auth, doc.name);
    result.deleted.push(`activation_invites/${docId(doc.name)}`);
  }
  const inviteById = await request('GET', `${ROOT}/activation_invites/${encodeURIComponent(email)}`, null, auth);
  if (inviteById.status === 200) {
    if (APPLY) await deleteDoc(auth, `activation_invites/${email}`);
    result.deleted.push(`activation_invites/${email}`);
  }

  const peopleDocs = await queryByEmail(auth, 'people', email);
  for (const doc of peopleDocs) {
    if (APPLY) await deleteDoc(auth, doc.name);
    result.deleted.push(`people/${docId(doc.name)}`);
  }

  const candidateDocs = await queryByEmail(auth, 'candidates', email);
  for (const doc of candidateDocs) {
    const companyId = fieldString(doc.fields, 'companyId');
    if (companyId) companyIds.add(companyId);
    if (APPLY) {
      await deleteDoc(auth, `evaluations/${docId(doc.name)}`);
      await deleteDoc(auth, doc.name);
    }
    result.deleted.push(`candidates/${docId(doc.name)}`);
  }

  for (const companyId of companyIds) {
    for (const col of ['vacancies', 'candidates', 'activation_invites', 'users']) {
      const related = await queryByCompany(auth, col, companyId);
      for (const doc of related) {
        if (APPLY) {
          if (col === 'candidates') {
            await deleteDoc(auth, `evaluations/${docId(doc.name)}`);
          }
          await deleteDoc(auth, doc.name);
        }
        result.deleted.push(`${col}/${docId(doc.name)}`);
      }
    }
    if (APPLY) await deleteDoc(auth, `companies/${companyId}`);
    result.deleted.push(`companies/${companyId}`);
  }

  if (APPLY && uid) {
    const authDelete = await request(
      'POST',
      `https://identitytoolkit.googleapis.com/v1/projects/${PROJECT}/accounts:delete`,
      {localId: uid},
      auth,
    );
    result.authDeleted = authDelete.status >= 200 && authDelete.status < 300;
    result.authStatus = authDelete.status;
  }

  result.deleted = [...new Set(result.deleted)];
  result.companies = [...companyIds];
  return result;
}

async function purgeCompanyById(auth, companyId) {
  const result = {companyId, deleted: []};
  for (const col of ['vacancies', 'candidates', 'activation_invites', 'users', 'people', 'processes']) {
    const related = await queryByCompany(auth, col, companyId);
    for (const doc of related) {
      if (APPLY) {
        if (col === 'candidates') {
          await deleteDoc(auth, `evaluations/${docId(doc.name)}`);
        }
        await deleteDoc(auth, doc.name);
      }
      result.deleted.push(`${col}/${docId(doc.name)}`);
    }
  }
  if (APPLY) await deleteDoc(auth, `companies/${companyId}`);
  result.deleted.push(`companies/${companyId}`);
  return result;
}

(async () => {
  const auth = token();
  const emails = new Set();
  const authMatches = [];

  for (const user of await listAuthUsers()) {
    const email = String(user.email || '').trim().toLowerCase();
    const name = user.displayName || '';
    if (matchesTarget(email) || matchesTarget(name)) {
      if (email) emails.add(email);
      authMatches.push({email, uid: user.localId, displayName: name});
    }
  }

  for (const collection of ['users', 'activation_invites', 'candidates', 'people']) {
    const docs = await listCollection(auth, collection);
    for (const doc of docs) {
      const fields = doc.fields || {};
      const email = String(fieldString(fields, 'email') || docId(doc.name) || '')
        .trim()
        .toLowerCase();
      const name = [
        fieldString(fields, 'displayName'),
        fieldString(fields, 'firstName'),
        fieldString(fields, 'lastName'),
        fieldString(fields, 'fullName'),
        fieldString(fields, 'name'),
      ]
        .filter(Boolean)
        .join(' ');
      if (matchesTarget(email) || matchesTarget(name) || matchesTarget(docId(doc.name))) {
        if (email.includes('@')) emails.add(email);
      }
    }
  }

  const uidByEmail = Object.fromEntries(
    authMatches.filter((item) => item.email).map((item) => [item.email, item.uid]),
  );
  const purged = [];
  for (const email of [...emails].sort()) {
    purged.push(await purgeEmail(auth, email, uidByEmail[email]));
  }

  const companyDocs = await listCollection(auth, 'companies');
  const extraCompanies = [];
  for (const doc of companyDocs) {
    const name = fieldString(doc.fields, 'name');
    const id = docId(doc.name);
    if (!matchesTarget(name) && !matchesTarget(id)) continue;
    extraCompanies.push({id, name});
    purged.push(await purgeCompanyById(auth, id));
  }

  console.log(
    JSON.stringify(
      {
        mode: APPLY ? 'apply' : 'dry-run',
        matchedEmails: [...emails].sort(),
        authMatches,
        extraCompanies,
        purged,
      },
      null,
      2,
    ),
  );
})().catch((error) => {
  console.error(error);
  process.exit(1);
});
