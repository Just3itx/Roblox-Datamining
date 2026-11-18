import assert from 'node:assert/strict';
import { test } from 'node:test';
import { parseDeployHistory } from './deploy-history.ts';

const SAMPLE = `New WindowsPlayer version-hidden at 11/16/2026 3:48:00 PM, file version: 0, 748, 0, 7481526, git hash: 0.748.0.7481526 ...
garbage line that should be ignored
New Studio64 version-abc123 at 11/16/2026 4:14:00 PM, file version: 0, 748, 0, 7481526, git hash: 0.748.0.7481526 ...`;

test('parses deploy lines into binary, version and date', () => {
  const entries = parseDeployHistory(SAMPLE);
  assert.equal(entries.length, 2);
  assert.deepEqual(entries[0], {
    binary: 'WindowsPlayer',
    version: '0.748.0.7481526',
    fileVersion: '0, 748, 0, 7481526',
    date: '11/16/2026 3:48:00 PM',
  });
  assert.equal(entries[1]!.binary, 'Studio64');
});

test('ignores lines that are not deploy entries', () => {
  assert.deepEqual(parseDeployHistory('hello\n\nworld'), []);
});
