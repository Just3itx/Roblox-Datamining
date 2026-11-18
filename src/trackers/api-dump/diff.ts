import type { DiffLine } from '../../core/report.ts';
import { compareStrings } from '../../core/text.ts';

// Shapes from Roblox's Full-API-Dump.json (only the fields this project reads).
export interface ApiType {
  Category: string;
  Name: string;
}

export interface ApiParameter {
  Name: string;
  Type: ApiType;
  Default?: string;
}

export type ApiTag = string | Record<string, unknown>;
export type ApiSecurity = string | { Read: string; Write: string };

export interface ApiMember {
  MemberType: string;
  Name: string;
  Tags?: ApiTag[];
  Security?: ApiSecurity;
  ValueType?: ApiType;
  ReturnType?: ApiType | ApiType[];
  Parameters?: ApiParameter[];
}

export interface ApiClass {
  Name: string;
  Superclass: string;
  Tags?: ApiTag[];
  Members: ApiMember[];
}

export interface ApiEnumItem {
  Name: string;
  Value: number;
  Tags?: ApiTag[];
}

export interface ApiEnum {
  Name: string;
  Items: ApiEnumItem[];
  Tags?: ApiTag[];
}

export interface ApiDump {
  Version: number;
  Classes: ApiClass[];
  Enums: ApiEnum[];
}

// ── Formatting ────────────────────────────────────────────────────────────────

export function formatType(type: ApiType | ApiType[] | undefined): string {
  if (!type) return 'void';
  if (Array.isArray(type)) return `(${type.map((t) => formatType(t)).join(', ')})`;
  return type.Category === 'Enum' ? `Enum.${type.Name}` : type.Name;
}

function formatParameters(parameters: ApiParameter[] = []): string {
  return parameters
    .map((p) => `${p.Name}: ${formatType(p.Type)}${p.Default !== undefined ? ` = ${p.Default}` : ''}`)
    .join(', ');
}

function formatTag(tag: ApiTag): string {
  if (typeof tag === 'string') return tag;
  return Object.entries(tag)
    .map(([key, value]) => `${key}: ${typeof value === 'string' ? value : JSON.stringify(value)}`)
    .join(', ');
}

function formatTags(tags: ApiTag[] | undefined): string {
  return tags?.length ? ` [${tags.map(formatTag).join(', ')}]` : '';
}

function formatSecurity(security: ApiSecurity | undefined): string {
  if (!security) return '';
  if (typeof security === 'string') return security === 'None' ? '' : ` {${security}}`;
  const { Read: read, Write: write } = security;
  if (read === write) return read === 'None' ? '' : ` {${read}}`;
  return ` {read: ${read}, write: ${write}}`;
}

/** e.g. "Function Instance:FindFirstChild(name: string, recursive: bool = false): Instance" */
export function memberSignature(className: string, member: ApiMember): string {
  const params = formatParameters(member.Parameters);
  switch (member.MemberType) {
    case 'Property':
      return `Property ${className}.${member.Name}: ${formatType(member.ValueType)}`;
    case 'Function':
      return `Function ${className}:${member.Name}(${params}): ${formatType(member.ReturnType)}`;
    case 'Event':
      return `Event ${className}.${member.Name}(${params})`;
    case 'Callback':
      return `Callback ${className}.${member.Name}(${params}): ${formatType(member.ReturnType)}`;
    default:
      return `${member.MemberType} ${className}.${member.Name}`;
  }
}

export function describeMember(className: string, member: ApiMember): string {
  return `${memberSignature(className, member)}${formatSecurity(member.Security)}${formatTags(member.Tags)}`;
}

export function describeClass(cls: ApiClass): string {
  const superclass = cls.Superclass && cls.Superclass !== '<<<ROOT>>>' ? ` : ${cls.Superclass}` : '';
  return `Class ${cls.Name}${superclass}${formatTags(cls.Tags)}`;
}

export function describeEnum(apiEnum: ApiEnum): string {
  return `Enum ${apiEnum.Name}${formatTags(apiEnum.Tags)}`;
}

export function describeEnumItem(enumName: string, item: ApiEnumItem): string {
  return `EnumItem ${enumName}.${item.Name}: ${item.Value}${formatTags(item.Tags)}`;
}

// ── Diffing ───────────────────────────────────────────────────────────────────

export interface Counts {
  added: number;
  removed: number;
  changed: number;
}

export interface ApiDiff {
  classes: Counts;
  members: Counts;
  enums: Counts;
  enumItems: Counts;
  /** Grouped by class: a class line, then its indented member lines. */
  classLines: DiffLine[];
  /** Grouped by enum: an enum line, then its indented item lines. */
  enumLines: DiffLine[];
}

const zero = (): Counts => ({ added: 0, removed: 0, changed: 0 });
const INDENT = '    ';

function byName<T extends { Name: string }>(items: T[]): Map<string, T> {
  return new Map(items.map((item) => [item.Name, item]));
}

function sortedUnion(a: Iterable<string>, b: Iterable<string>): string[] {
  return [...new Set([...a, ...b])].sort(compareStrings);
}

/**
 * Diffs a container (class or enum) and its children (members or items).
 * New and removed containers list every child; changed containers get a context
 * line followed by only the children that differ.
 */
function diffContainers<C extends { Name: string }, I>(
  before: C[],
  after: C[],
  spec: {
    describe(container: C): string;
    children(container: C): I[];
    childKey(child: I): string;
    describeChild(containerName: string, child: I): string;
    containerCounts: Counts;
    childCounts: Counts;
  },
): DiffLine[] {
  const lines: DiffLine[] = [];
  const oldByName = byName(before);
  const newByName = byName(after);

  const pushAll = (op: '+' | '-', container: C) => {
    lines.push({ op, text: spec.describe(container) });
    for (const child of spec.children(container)) {
      lines.push({ op, text: INDENT + spec.describeChild(container.Name, child) });
    }
  };

  for (const name of sortedUnion(oldByName.keys(), newByName.keys())) {
    const prev = oldByName.get(name);
    const next = newByName.get(name);

    if (!prev && next) {
      spec.containerCounts.added++;
      spec.childCounts.added += spec.children(next).length;
      pushAll('+', next);
      continue;
    }
    if (prev && !next) {
      spec.containerCounts.removed++;
      spec.childCounts.removed += spec.children(prev).length;
      pushAll('-', prev);
      continue;
    }
    if (!prev || !next) continue;

    const childLines: DiffLine[] = [];
    const oldChildren = new Map(spec.children(prev).map((c) => [spec.childKey(c), c]));
    const newChildren = new Map(spec.children(next).map((c) => [spec.childKey(c), c]));

    for (const key of sortedUnion(oldChildren.keys(), newChildren.keys())) {
      const oldChild = oldChildren.get(key);
      const newChild = newChildren.get(key);
      const oldText = oldChild === undefined ? undefined : spec.describeChild(name, oldChild);
      const newText = newChild === undefined ? undefined : spec.describeChild(name, newChild);
      if (oldText === newText) continue;

      if (oldText === undefined) spec.childCounts.added++;
      else if (newText === undefined) spec.childCounts.removed++;
      else spec.childCounts.changed++;

      if (oldText !== undefined) childLines.push({ op: '-', text: INDENT + oldText });
      if (newText !== undefined) childLines.push({ op: '+', text: INDENT + newText });
    }

    const oldHeader = spec.describe(prev);
    const newHeader = spec.describe(next);
    if (oldHeader !== newHeader) {
      spec.containerCounts.changed++;
      lines.push({ op: '-', text: oldHeader }, { op: '+', text: newHeader });
    } else if (childLines.length) {
      lines.push({ op: ' ', text: newHeader });
    }
    lines.push(...childLines);
  }

  return lines;
}

export function diffApiDump(before: ApiDump, after: ApiDump): ApiDiff {
  const diff: ApiDiff = {
    classes: zero(),
    members: zero(),
    enums: zero(),
    enumItems: zero(),
    classLines: [],
    enumLines: [],
  };

  diff.classLines = diffContainers(before.Classes, after.Classes, {
    describe: describeClass,
    children: (cls) => cls.Members,
    childKey: (member) => `${member.Name}\u0000${member.MemberType}`,
    describeChild: describeMember,
    containerCounts: diff.classes,
    childCounts: diff.members,
  });

  diff.enumLines = diffContainers(before.Enums, after.Enums, {
    describe: describeEnum,
    children: (apiEnum) => apiEnum.Items,
    childKey: (item) => item.Name,
    describeChild: describeEnumItem,
    containerCounts: diff.enums,
    childCounts: diff.enumItems,
  });

  return diff;
}

export function isEmptyApiDiff(diff: ApiDiff): boolean {
  return diff.classLines.length === 0 && diff.enumLines.length === 0;
}

export function apiStats(dump: ApiDump): { classes: number; members: number; enums: number; enumItems: number } {
  return {
    classes: dump.Classes.length,
    members: dump.Classes.reduce((sum, cls) => sum + cls.Members.length, 0),
    enums: dump.Enums.length,
    enumItems: dump.Enums.reduce((sum, apiEnum) => sum + apiEnum.Items.length, 0),
  };
}
