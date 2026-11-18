import type { Block, DiffLine, Section } from '../core/report.ts';
import { compareStrings, escapeCell, formatNumber, mdLink, plural } from '../core/text.ts';
import type { Tracker } from './types.ts';

interface CatalogItemDetails {
  id: number;
  itemType: 'Asset' | 'Bundle';
  assetType?: number;
  bundleType?: number;
  name: string;
  price?: number | null;
  priceStatus?: string;
  itemRestrictions?: string[];
  itemCreatedUtc?: string;
  totalQuantity?: number;
}

interface CatalogPage {
  nextPageCursor: string | null;
  data: CatalogItemDetails[];
}

export interface TrackedItem {
  id: number;
  itemType: 'Asset' | 'Bundle';
  type: string;
  name: string;
  price: string;
  restrictions: string[];
  quantity?: number;
  created?: string;
}

export const CATALOG_FILE = 'catalog/roblox-items.json';
const PAGES = 2;

const ASSET_TYPES: Record<number, string> = {
  2: 'T-Shirt', 8: 'Hat', 11: 'Shirt', 12: 'Pants', 17: 'Head', 18: 'Face', 19: 'Gear',
  27: 'Torso', 28: 'Right Arm', 29: 'Left Arm', 30: 'Left Leg', 31: 'Right Leg',
  41: 'Hair', 42: 'Face Accessory', 43: 'Neck', 44: 'Shoulder', 45: 'Front', 46: 'Back', 47: 'Waist',
  48: 'Climb Animation', 50: 'Fall Animation', 51: 'Idle Animation', 52: 'Jump Animation',
  53: 'Run Animation', 54: 'Swim Animation', 55: 'Walk Animation', 61: 'Emote',
  64: 'T-Shirt Accessory', 65: 'Shirt Accessory', 66: 'Pants Accessory', 67: 'Jacket', 68: 'Sweater',
  69: 'Shorts', 70: 'Left Shoe', 71: 'Right Shoe', 72: 'Dress Skirt', 76: 'Eyebrow', 77: 'Eyelash',
  78: 'Mood', 79: 'Dynamic Head',
};

const BUNDLE_TYPES: Record<number, string> = {
  1: 'Body Bundle', 2: 'Animation Pack', 3: 'Shoes', 4: 'Dynamic Head', 5: 'Avatar Bundle',
};

function typeName(item: CatalogItemDetails): string {
  if (item.itemType === 'Bundle') return BUNDLE_TYPES[item.bundleType ?? -1] ?? `Bundle #${item.bundleType}`;
  return ASSET_TYPES[item.assetType ?? -1] ?? `Asset #${item.assetType}`;
}

function priceLabel(item: CatalogItemDetails): string {
  if (typeof item.price === 'number') return item.price === 0 ? 'Free' : `R$ ${formatNumber(item.price)}`;
  return item.priceStatus ?? 'Off Sale';
}

export function toTrackedItem(item: CatalogItemDetails): TrackedItem {
  return {
    id: item.id,
    itemType: item.itemType,
    type: typeName(item),
    name: item.name.trim(),
    price: priceLabel(item),
    restrictions: [...(item.itemRestrictions ?? [])].sort(compareStrings),
    ...(item.totalQuantity ? { quantity: item.totalQuantity } : {}),
    ...(item.itemCreatedUtc ? { created: item.itemCreatedUtc } : {}),
  };
}

const itemKey = (item: Pick<TrackedItem, 'itemType' | 'id'>) => `${item.itemType}:${item.id}`;

const itemUrl = (item: TrackedItem) =>
  item.itemType === 'Bundle' ? `https://www.roblox.com/bundles/${item.id}` : `https://www.roblox.com/catalog/${item.id}`;

const describe = (item: TrackedItem) =>
  `${item.name} — ${item.price}${item.restrictions.length ? ` [${item.restrictions.join(', ')}]` : ''}${item.quantity ? ` (${formatNumber(item.quantity)} stock)` : ''}`;

/** Newest first, so the file reads like a feed. */
function sortItems(items: TrackedItem[]): TrackedItem[] {
  return items.sort((a, b) => compareStrings(b.created ?? '', a.created ?? '') || b.id - a.id);
}

function itemTable(items: TrackedItem[]): Block {
  return {
    type: 'table',
    columns: ['Item', 'Type', 'Price', 'Tags', 'Created'],
    rows: items.map((item) => [
      mdLink(item.name, itemUrl(item)),
      item.type,
      item.price,
      escapeCell(item.restrictions.join(', ')),
      item.created ? item.created.slice(0, 10) : '—',
    ]),
  };
}

export const catalogTracker: Tracker = {
  id: 'catalog',
  title: 'Roblox catalog items',
  icon: '🛍️',
  description: 'Recently updated catalog items published by the Roblox account: new drops, price and stock changes.',

  async run({ http, store }) {
    const fetched: TrackedItem[] = [];
    let cursor: string | null = '';
    for (let page = 0; page < PAGES && cursor !== null; page++) {
      const url =
        'https://catalog.roblox.com/v2/search/items/details?Category=1&CreatorTargetId=1&CreatorType=1&SortType=3&Limit=120' +
        (cursor ? `&Cursor=${encodeURIComponent(cursor)}` : '');
      const result: CatalogPage = await http.json<CatalogPage>(url);
      fetched.push(...result.data.map(toTrackedItem));
      cursor = result.nextPageCursor;
    }

    const previous = await store.readJson<TrackedItem[]>(CATALOG_FILE);
    const known = new Map((previous ?? []).map((item) => [itemKey(item), item]));
    const added: TrackedItem[] = [];
    const changed: Array<[TrackedItem, TrackedItem]> = [];

    for (const item of fetched) {
      const old = known.get(itemKey(item));
      if (!old) added.push(item);
      else if (describe(old) !== describe(item)) changed.push([old, item]);
      // Items drop off the "recently updated" pages over time; keep them in the archive.
      known.set(itemKey(item), item);
    }

    const wrote = await store.writeJson(CATALOG_FILE, sortItems([...known.values()]));
    if (!wrote) return null;

    if (!previous) {
      return {
        id: 'catalog',
        icon: '🛍️',
        title: 'Roblox catalog items',
        short: '🛍️ Catalog snapshot',
        headline: `First snapshot of ${plural(fetched.length, 'item')}`,
        blocks: [{ type: 'text', text: '### Latest 10' }, itemTable(sortItems([...fetched]).slice(0, 10))],
      } satisfies Section;
    }
    if (!added.length && !changed.length) return null;

    const blocks: Block[] = [];
    if (added.length) blocks.push({ type: 'text', text: `### 🆕 New items` }, itemTable(sortItems(added)));
    if (changed.length) {
      const lines: DiffLine[] = changed.flatMap(([old, item]) => [
        { op: '-', text: describe(old) },
        { op: '+', text: describe(item) },
      ]);
      blocks.push({ type: 'diff', title: `Updated items (${changed.length})`, lines, open: lines.length <= 40 });
    }

    return {
      id: 'catalog',
      icon: '🛍️',
      title: 'Roblox catalog items',
      short: `🛍️ Catalog +${added.length} ~${changed.length}`,
      headline: `${plural(added.length, 'new item')}, ${plural(changed.length, 'updated item')}`,
      blocks,
    } satisfies Section;
  },
};
