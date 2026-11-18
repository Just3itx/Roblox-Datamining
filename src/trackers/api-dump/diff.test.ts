import assert from 'node:assert/strict';
import { test } from 'node:test';
import { apiStats, describeMember, diffApiDump, isEmptyApiDiff, memberSignature, type ApiDump } from './diff.ts';

const str = { Category: 'Primitive', Name: 'string' };
const bool = { Category: 'Primitive', Name: 'bool' };
const instance = { Category: 'Class', Name: 'Instance' };

function dump(): ApiDump {
  return {
    Version: 1,
    Classes: [
      {
        Name: 'Instance',
        Superclass: '<<<ROOT>>>',
        Tags: ['NotCreatable'],
        Members: [
          {
            MemberType: 'Function',
            Name: 'FindFirstChild',
            Parameters: [
              { Name: 'name', Type: str },
              { Name: 'recursive', Type: bool, Default: 'false' },
            ],
            ReturnType: instance,
            Security: 'None',
          },
          { MemberType: 'Property', Name: 'Name', ValueType: str, Security: { Read: 'None', Write: 'None' } },
        ],
      },
    ],
    Enums: [{ Name: 'Material', Items: [{ Name: 'Plastic', Value: 256 }] }],
  };
}

test('formats member signatures like the Roblox docs', () => {
  const [findFirstChild, name] = dump().Classes[0]!.Members;
  assert.equal(
    memberSignature('Instance', findFirstChild!),
    'Function Instance:FindFirstChild(name: string, recursive: bool = false): Instance',
  );
  assert.equal(memberSignature('Instance', name!), 'Property Instance.Name: string');
  assert.equal(
    describeMember('Part', {
      MemberType: 'Property',
      Name: 'Secret',
      ValueType: { Category: 'Enum', Name: 'Material' },
      Security: { Read: 'None', Write: 'PluginSecurity' },
      Tags: ['Hidden', { PreferredDescriptorName: 'Other' }],
    }),
    'Property Part.Secret: Enum.Material {read: None, write: PluginSecurity} [Hidden, PreferredDescriptorName: Other]',
  );
  assert.equal(
    memberSignature('Camera', {
      MemberType: 'Function',
      Name: 'Pair',
      ReturnType: [
        { Category: 'DataType', Name: 'CFrame' },
        { Category: 'DataType', Name: 'Vector3' },
      ],
    }),
    'Function Camera:Pair(): (CFrame, Vector3)',
  );
});

test('identical dumps produce no diff', () => {
  const diff = diffApiDump(dump(), dump());
  assert.ok(isEmptyApiDiff(diff));
});

test('reports added, removed and changed members under their class', () => {
  const after = dump();
  const cls = after.Classes[0]!;
  cls.Members = cls.Members.filter((m) => m.Name !== 'FindFirstChild');
  cls.Members.push({ MemberType: 'Event', Name: 'Destroying', Parameters: [] });
  cls.Members.find((m) => m.Name === 'Name')!.Tags = ['NotReplicated'];

  const diff = diffApiDump(dump(), after);
  assert.deepEqual(diff.members, { added: 1, removed: 1, changed: 1 });
  assert.deepEqual(diff.classLines, [
    { op: ' ', text: 'Class Instance [NotCreatable]' },
    { op: '+', text: '    Event Instance.Destroying()' },
    { op: '-', text: '    Function Instance:FindFirstChild(name: string, recursive: bool = false): Instance' },
    { op: '-', text: '    Property Instance.Name: string' },
    { op: '+', text: '    Property Instance.Name: string [NotReplicated]' },
  ]);
});

test('new classes list all of their members; enum items diff by name', () => {
  const after = dump();
  after.Classes.push({
    Name: 'Sparkle',
    Superclass: 'Instance',
    Members: [{ MemberType: 'Property', Name: 'Color', ValueType: { Category: 'DataType', Name: 'Color3' } }],
  });
  after.Enums[0]!.Items.push({ Name: 'Neon', Value: 288 });
  after.Enums[0]!.Items[0]!.Value = 257;

  const diff = diffApiDump(dump(), after);
  assert.deepEqual(diff.classes, { added: 1, removed: 0, changed: 0 });
  assert.deepEqual(diff.members, { added: 1, removed: 0, changed: 0 });
  assert.deepEqual(diff.classLines, [
    { op: '+', text: 'Class Sparkle : Instance' },
    { op: '+', text: '    Property Sparkle.Color: Color3' },
  ]);
  assert.deepEqual(diff.enumItems, { added: 1, removed: 0, changed: 1 });
  assert.deepEqual(diff.enumLines, [
    { op: ' ', text: 'Enum Material' },
    { op: '+', text: '    EnumItem Material.Neon: 288' },
    { op: '-', text: '    EnumItem Material.Plastic: 256' },
    { op: '+', text: '    EnumItem Material.Plastic: 257' },
  ]);
});

test('counts dump totals', () => {
  assert.deepEqual(apiStats(dump()), { classes: 1, members: 2, enums: 1, enumItems: 1 });
});
