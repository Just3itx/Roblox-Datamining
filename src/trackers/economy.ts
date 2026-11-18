import type { Http } from '../core/http.ts';

/** economy.roblox.com/v2/assets/{id}/details — public, ~1000 req/min, works for any asset id. */
export interface AssetDetails {
  TargetId: number;
  Name: string;
  Description?: string;
  AssetTypeId?: number;
  Creator?: { Id: number; Name: string; HasVerifiedBadge?: boolean };
  Created?: string;
  Updated?: string;
  PriceInRobux?: number | null;
  Sales?: number;
  IsForSale?: boolean;
  IsLimited?: boolean;
  IsLimitedUnique?: boolean;
  Remaining?: number | null;
  OffsaleDeadline?: string | null;
  CollectibleItemId?: string | null;
  CollectiblesItemDetails?: {
    CollectibleLowestResalePrice?: number | null;
    CollectibleQuantityLimitPerUser?: number | null;
    TotalQuantity?: number | null;
    IsForSale?: boolean;
    IsLimited?: boolean;
  } | null;
}

export interface BundleDetails {
  id: number;
  name: string;
  bundleType?: string;
  creator?: { id: number; name: string };
  items?: Array<{ id: number; name: string; type: string }>;
}

const ECONOMY = 'https://economy.roblox.com/v2/assets';

export async function fetchAssetDetails(http: Http, id: number): Promise<AssetDetails | null> {
  try {
    return await http.json<AssetDetails>(`${ECONOMY}/${id}/details`);
  } catch (error) {
    // 404 (code 20) = no such asset; treat as "doesn't exist" rather than a failure.
    if (error && typeof error === 'object' && 'status' in error && (error as { status: number }).status === 404) return null;
    throw error;
  }
}

export async function fetchBundleDetails(http: Http, id: number): Promise<BundleDetails | null> {
  try {
    return await http.json<BundleDetails>(`https://catalog.roblox.com/v1/bundles/${id}/details`);
  } catch (error) {
    if (error && typeof error === 'object' && 'status' in error) {
      const status = (error as { status: number }).status;
      if (status === 400 || status === 404) return null;
    }
    throw error;
  }
}

/** Runs an async mapper over items with bounded concurrency, preserving input order. */
export async function mapLimit<T, R>(items: T[], limit: number, mapper: (item: T, index: number) => Promise<R>): Promise<R[]> {
  const results = new Array<R>(items.length);
  let next = 0;
  async function worker(): Promise<void> {
    for (let i = next++; i < items.length; i = next++) {
      results[i] = await mapper(items[i] as T, i);
    }
  }
  await Promise.all(Array.from({ length: Math.min(limit, items.length) }, worker));
  return results;
}
