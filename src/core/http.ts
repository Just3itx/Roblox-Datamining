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

export function createHttp(options: HttpOptions = {}): Http {
  const {
    userAgent = 'roblox-datamining/0.1 (automated change tracker)',
    // Generous so a multi-page enumeration can ride out a rate-limit window reset (~60s) mid-run.
    retries = 6,
    timeoutMs = 60_000,
  } = options;
  const inflight = new Map<string, Promise<string>>();

  async function fetchText(url: string, headers: Record<string, string>): Promise<string> {
    for (let attempt = 0; ; attempt++) {
      let response: Response;
      try {
        response = await fetch(url, {
          headers: { 'user-agent': userAgent, accept: 'application/json, text/plain, */*', ...headers },
          signal: AbortSignal.timeout(timeoutMs),
        });
      } catch (error) {
        if (attempt >= retries) throw error;
        await sleep(backoff(attempt));
        continue;
      }

      if (response.ok) return await response.text();

      const body = await response.text().catch(() => '');
      const retryable = response.status === 429 || response.status >= 500;
      if (!retryable || attempt >= retries) throw new HttpError(url, response.status, body);
      await sleep(response.status === 429 ? rateLimitDelay(response, attempt) : backoff(attempt));
    }
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
