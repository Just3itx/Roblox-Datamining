export interface Http {
  /** GET a URL and parse it as JSON. Repeated calls for one URL (and headers) share a single request per run. */
  json<T>(url: string, headers?: Record<string, string>): Promise<T>;
  /** GET a URL as text. Repeated calls for one URL (and headers) share a single request per run. */
  text(url: string, headers?: Record<string, string>): Promise<string>;
}

export interface HttpOptions {
  userAgent?: string;
  retries?: number;
  timeoutMs?: number;
  /**
   * Ordered proxy base hosts (e.g. ["roproxy.com", "rotunnel.com"]). For the rate-limited
   * Roblox hosts, requests try each proxy in turn, then fall back to roblox.com directly.
   */
  proxies?: string[];
}

/** Roblox subdomains that benefit from a proxy and that RoProxy/RoTunnel mirror. */
const PROXYABLE_SUBDOMAINS = new Set(['catalog', 'economy', 'apis', 'games', 'thumbnails', 'inventory', 'users']);

/** The hosts to try for one URL: each proxy (if the host is proxyable), then the original. */
export function proxyCandidates(url: string, proxies: string[]): string[] {
  if (!proxies.length) return [url];
  let parsed: URL;
  try {
    parsed = new URL(url);
  } catch {
    return [url];
  }
  const match = /^([a-z0-9-]+)\.roblox\.com$/.exec(parsed.hostname);
  if (!match || !PROXYABLE_SUBDOMAINS.has(match[1]!)) return [url];
  const viaProxies = proxies.map((host) => {
    const candidate = new URL(url);
    candidate.hostname = `${match[1]}.${host}`;
    return candidate.toString();
  });
  return [...viaProxies, url]; // direct host is always the last resort
}

export class HttpError extends Error {
  readonly status: number;
  readonly url: string;

  constructor(url: string, status: number, body: string) {
    super(`HTTP ${status} for ${url}${body ? ` — ${body.slice(0, 200)}` : ''}`);
    this.name = 'HttpError';
    this.status = status;
    this.url = url;
  }
}

const sleep = (ms: number) => new Promise<void>((resolve) => setTimeout(resolve, ms));

const backoff = (attempt: number) => 1000 * 2 ** attempt + Math.floor(Math.random() * 500);

/** Honors Retry-After, or Roblox's x-ratelimit-reset ("23" or "23, 23;w=60"), capped at 65s. */
function rateLimitDelay(response: Response, attempt: number): number {
  const header = response.headers.get('retry-after') ?? response.headers.get('x-ratelimit-reset');
  const seconds = header ? Number.parseInt(header, 10) : Number.NaN;
  return Number.isFinite(seconds) ? Math.min(seconds + 1, 65) * 1000 : backoff(attempt);
}

/** Whether an error from one host should make us try the next candidate (vs. a genuine API response). */
function shouldFallBack(error: unknown): boolean {
  if (error instanceof HttpError) {
    // 4xx that signal a broken/unsupported proxy, plus rate-limit and server errors; but NOT 404
    // (a faithfully-relayed "not found" — the direct host would say the same).
    return error.status === 429 || error.status >= 500 || error.status === 400 || error.status === 403 || error.status === 408;
  }
  return true; // network error / timeout
}

export function createHttp(options: HttpOptions = {}): Http {
  const {
    userAgent = 'roblox-datamining/0.1 (automated change tracker)',
    // Generous so a multi-page enumeration can ride out a rate-limit window reset (~60s) mid-run.
    retries = 6,
    timeoutMs = 60_000,
    proxies = [],
  } = options;
  const inflight = new Map<string, Promise<string>>();

  async function fetchOnce(url: string, headers: Record<string, string>, maxRetries: number): Promise<string> {
    for (let attempt = 0; ; attempt++) {
      let response: Response;
      try {
        response = await fetch(url, {
          headers: { 'user-agent': userAgent, accept: 'application/json, text/plain, */*', ...headers },
          signal: AbortSignal.timeout(timeoutMs),
        });
      } catch (error) {
        if (attempt >= maxRetries) throw error;
        await sleep(backoff(attempt));
        continue;
      }

      if (response.ok) return await response.text();

      const body = await response.text().catch(() => '');
      const retryable = response.status === 429 || response.status >= 500;
      if (!retryable || attempt >= maxRetries) throw new HttpError(url, response.status, body);
      await sleep(response.status === 429 ? rateLimitDelay(response, attempt) : backoff(attempt));
    }
  }

  async function fetchText(url: string, headers: Record<string, string>): Promise<string> {
    const candidates = proxyCandidates(url, proxies);
    for (let i = 0; i < candidates.length; i++) {
      const isLast = i === candidates.length - 1;
      try {
        // Only the final (direct) host gets the full retry/backoff budget; proxies fail fast.
        return await fetchOnce(candidates[i]!, headers, isLast ? retries : 0);
      } catch (error) {
        if (isLast || !shouldFallBack(error)) throw error;
      }
    }
    throw new Error(`no candidates for ${url}`); // unreachable: candidates always has ≥1
  }

  function text(url: string, headers: Record<string, string> = {}): Promise<string> {
    const key = `${url}\u0000${JSON.stringify(headers)}`;
    let pending = inflight.get(key);
    if (!pending) {
      pending = fetchText(url, headers);
      inflight.set(key, pending);
      pending.catch(() => inflight.delete(key));
    }
    return pending;
  }

  return {
    text,
    async json<T>(url: string, headers?: Record<string, string>): Promise<T> {
      return JSON.parse(await text(url, headers)) as T;
    },
  };
}
