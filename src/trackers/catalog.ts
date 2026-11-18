import type { Block, DiffLine, Section } from '../core/report.ts';
import { compareStrings, escapeCell, formatNumber, mdLink, plural } from '../core/text.ts';
import { assetTypeName, bundleTypeName } from './asset-types.ts';
import { fetchAssetDetails, mapLimit } from './economy.ts';
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
  /** Set when the item exists but isn't on sale yet (found via the economy endpoint). */
  upcoming?: boolean;
}

export const CATALOG_FILE = 'catalog/roblox-items.json';
const PAGES = 2;

function typeName(item: CatalogItemDetails): string {
  return item.itemType === 'Bundle' ? bundleTypeName(item.bundleType) : assetTypeName(item.assetType);
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
  `${item.name} — ${item.price}${item.restrictions.length ? ` [${item.restrictions.join(', ')}]` : ''}${item.quantity ? ` (${formatNumber(item.quantity)} stock)` : ''}${item.upcoming ? ' 🔜 not on sale yet' : ''}`;

/** Newest first, so the file reads like a feed. */
function sortItems(items: TrackedItem[]): TrackedItem[] {
  return items.sort((a, b) => compareStrings(b.created ?? '', a.created ?? '') || b.id - a.id);
}

function itemTable(items: TrackedItem[]): Block {
  return {
    type: 'table',
    columns: ['Item', 'Type', 'Price', 'Tags', 'Created', 'Status'],
    rows: items.map((item) => [
      mdLink(item.name, itemUrl(item)),
      item.type,
      item.price,
      escapeCell(item.restrictions.join(', ')),
      item.created ? item.created.slice(0, 10) : '—',
      item.upcoming ? '🔜 upcoming' : '🟢 on sale',
    ]),
  };
}

/** Marks newly-seen assets that exist but aren't on sale yet, via the economy endpoint. */
async function flagUpcoming(http: Parameters<Tracker['run']>[0]['http'], items: TrackedItem[]): Promise<void> {
  const assets = items.filter((i) => i.itemType === 'Asset').slice(0, 80);
  await mapLimit(assets, 15, async (item) => {
    try {
      const details = await fetchAssetDetails(http, item.id);
      if (details && details.IsForSale === false) item.upcoming = true;
    } catch {
      /* best-effort: a failed check just leaves the item unflagged */
    }
  });
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

    // Flag new items that exist but aren't on sale yet ("coming soon"). Done before the
    // snapshot is written so a later flip to on-sale shows up as a change next run.
    if (previous && added.length) await flagUpcoming(http, added);

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

    const upcoming = added.filter((i) => i.upcoming).length;
    return {
      id: 'catalog',
      icon: '🛍️',
      title: 'Roblox catalog items',
      short: `🛍️ Catalog +${added.length} ~${changed.length}${upcoming ? ` 🔜${upcoming}` : ''}`,
      headline: `${plural(added.length, 'new item')}, ${plural(changed.length, 'updated item')}${upcoming ? ` · ${upcoming} not on sale yet 🔜` : ''}`,
      blocks,
    } satisfies Section;
  },
};
