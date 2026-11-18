import { zstdDecompressSync } from 'node:zlib';

/**
 * Minimal parser for Roblox binary models (.rbxm). Extracts script instances with their
 * source, which ships either as plaintext (type 0x01) or compiled Luau bytecode (type 0x1d).
 * Only what's needed to pull scripts out — not a full rbx-dom implementation.
 */

const SCRIPT_CLASSES = new Set(['ModuleScript', 'LocalScript', 'Script']);
const PROP_STRING = 0x01;
const PROP_BYTECODE = 0x1d; // Roblox's protected/compiled source type

export interface RbxmScript {
  className: string;
  name: string;
  /** Full instance path, e.g. "UniversalApp/Packages/ApolloClient". */
  path: string;
  /** 'lua' = plaintext source; 'bytecode' = compiled Luau (needs a decompiler). */
  kind: 'lua' | 'bytecode';
  content: Uint8Array;
}

/** Decodes an interleaved, accumulated int32 referent array (Roblox's binary encoding). */
function readReferents(data: Buffer, offset: number, count: number): number[] {
  const out = new Array<number>(count);
  for (let i = 0; i < count; i++) {
    const b0 = data[offset + i]!;
    const b1 = data[offset + count + i]!;
    const b2 = data[offset + 2 * count + i]!;
    const b3 = data[offset + 3 * count + i]!;
    const raw = ((b0 << 24) | (b1 << 16) | (b2 << 8) | b3) >>> 0;
    out[i] = (raw >>> 1) ^ -(raw & 1); // un-zigzag
  }
  for (let i = 1; i < count; i++) out[i]! += out[i - 1]!; // accumulate deltas
  return out;
}

/** LZ4 block decompression (older rbxm chunks). Newer ones use zstd, handled separately. */
function lz4(src: Uint8Array, destLen: number): Uint8Array {
  const dst = new Uint8Array(destLen);
  let s = 0;
  let d = 0;
  while (s < src.length && d < destLen) {
    const token = src[s++]!;
    let lit = token >> 4;
    if (lit === 15) { let b: number; do { b = src[s++]!; lit += b; } while (b === 255); }
    for (let i = 0; i < lit; i++) dst[d++] = src[s++]!;
    if (s >= src.length) break;
    const offset = src[s++]! | (src[s++]! << 8);
    let mlen = (token & 15) + 4;
    if ((token & 15) === 15) { let b: number; do { b = src[s++]!; mlen += b; } while (b === 255); }
    let m = d - offset;
    for (let i = 0; i < mlen; i++) dst[d++] = dst[m++]!;
  }
  return dst;
}

function decompress(raw: Buffer, uncompressedLen: number): Buffer {
  if (raw.length === 0) return raw;
  const isZstd = raw[0] === 0x28 && raw[1] === 0xb5 && raw[2] === 0x2f && raw[3] === 0xfd;
  return isZstd ? zstdDecompressSync(raw) : Buffer.from(lz4(raw, uncompressedLen));
}

const RBXM_MAGIC = '<roblox!';

/** Returns every script instance in the model, paired with its name and source/bytecode. */
export function extractScripts(file: Buffer): RbxmScript[] {
  if (file.toString('latin1', 0, 8) !== RBXM_MAGIC) throw new Error('not an rbxm (bad magic)');

  let p = 8 + 6 + 2 + 4 + 4 + 8; // magic + signature + version + classCount + instanceCount + reserved
  const classes = new Map<number, { className: string; refs: number[] }>();
  const nameByRef = new Map<number, string>();
  const parentByRef = new Map<number, number>();
  const sourceByRef = new Map<number, { kind: 'lua' | 'bytecode'; content: Uint8Array }>();

  while (p + 16 <= file.length) {
    const tag = file.toString('latin1', p, p + 4);
    p += 4;
    const comp = file.readUInt32LE(p);
    const uncomp = file.readUInt32LE(p + 4);
    p += 12; // comp(4) + uncomp(4) + reserved(4)
    const raw = file.subarray(p, p + (comp || uncomp));
    p += comp || uncomp;
    if (tag === 'END\0') break;
    if (tag !== 'INST' && tag !== 'PROP' && tag !== 'PRNT') continue; // skip META, SSTR

    const data = decompress(Buffer.from(raw), uncomp);

    if (tag === 'INST') {
      let o = 0;
      const classId = data.readUInt32LE(o); o += 4;
      const nameLen = data.readUInt32LE(o); o += 4;
      const className = data.toString('latin1', o, o + nameLen); o += nameLen;
      o += 1; // objectFormat
      const count = data.readUInt32LE(o); o += 4;
      classes.set(classId, { className, refs: readReferents(data, o, count) });
      continue;
    }

    if (tag === 'PRNT') {
      let o = 1; // version byte
      const count = data.readUInt32LE(o); o += 4;
      const children = readReferents(data, o, count);
      const parents = readReferents(data, o + count * 4, count);
      for (let i = 0; i < count; i++) parentByRef.set(children[i]!, parents[i]!);
      continue;
    }

    // PROP — Name for every class (needed for path), Source for script classes.
    let o = 0;
    const classId = data.readUInt32LE(o); o += 4;
    const nameLen = data.readUInt32LE(o); o += 4;
    const propName = data.toString('latin1', o, o + nameLen); o += nameLen;
    const propType = data[o]; o += 1;
    const cls = classes.get(classId);
    if (!cls) continue;

    if (propName === 'Name' && propType === PROP_STRING) {
      for (let i = 0; i < cls.refs.length; i++) {
        const len = data.readUInt32LE(o); o += 4;
        nameByRef.set(cls.refs[i]!, data.toString('utf8', o, o + len)); o += len;
      }
    } else if (propName === 'Source' && SCRIPT_CLASSES.has(cls.className) && (propType === PROP_STRING || propType === PROP_BYTECODE)) {
      const kind = propType === PROP_STRING ? 'lua' : 'bytecode';
      for (let i = 0; i < cls.refs.length; i++) {
        const len = data.readUInt32LE(o); o += 4;
        sourceByRef.set(cls.refs[i]!, { kind, content: data.subarray(o, o + len) }); o += len;
      }
    }
  }

  const pathOf = (ref: number): string => {
    const parts: string[] = [];
    for (let r = ref, guard = 0; r !== undefined && r >= 0 && guard < 100; guard++) {
      parts.unshift(nameByRef.get(r) ?? String(r));
      const parent = parentByRef.get(r);
      if (parent === undefined || parent < 0) break;
      r = parent;
    }
    return parts.join('/');
  };

  const scripts: RbxmScript[] = [];
  for (const [classId, cls] of classes) {
    if (!SCRIPT_CLASSES.has(cls.className)) continue;
    for (const ref of cls.refs) {
      const src = sourceByRef.get(ref);
      if (!src) continue;
      scripts.push({ className: cls.className, name: nameByRef.get(ref) ?? String(ref), path: pathOf(ref), kind: src.kind, content: src.content });
    }
  }
  return scripts;
}
