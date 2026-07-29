const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL?.replace(/\/$/, '');
const SUPABASE_ANON_KEY = import.meta.env.VITE_SUPABASE_ANON_KEY;

export const isBackendConfigured = Boolean(SUPABASE_URL && SUPABASE_ANON_KEY);

const SESSION_ID_STORAGE_KEY = 'ai-native-radar:session-id';

const getRequiredBackendConfig = () => {
  if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
    throw new Error('Supabase backend is not configured.');
  }

  return {
    url: SUPABASE_URL,
    anonKey: SUPABASE_ANON_KEY,
  };
};

export const getCurrentSessionId = () => {
  if (typeof window === 'undefined') {
    return 'server-session';
  }

  const existing = window.sessionStorage.getItem(SESSION_ID_STORAGE_KEY);
  if (existing) {
    return existing;
  }

  const next =
    typeof crypto !== 'undefined' && 'randomUUID' in crypto
      ? crypto.randomUUID()
      : `session-${Date.now()}-${Math.random().toString(16).slice(2)}`;

  window.sessionStorage.setItem(SESSION_ID_STORAGE_KEY, next);
  return next;
};

export const backendRequest = async <T>(path: string, init: RequestInit = {}): Promise<T> => {
  const { url, anonKey } = getRequiredBackendConfig();
  const response = await fetch(`${url}${path}`, {
    ...init,
    headers: {
      apikey: anonKey,
      Authorization: `Bearer ${anonKey}`,
      'Content-Type': 'application/json',
      ...(init.headers || {}),
    },
  });

  if (!response.ok) {
    const message = await response.text();
    throw new Error(message || `Backend request failed with ${response.status}`);
  }

  if (response.status === 204) {
    return undefined as T;
  }

  return response.json() as Promise<T>;
};

export const callBackendRpc = <T>(functionName: string, body: Record<string, unknown>) =>
  backendRequest<T>(`/rest/v1/rpc/${functionName}`, {
    method: 'POST',
    body: JSON.stringify(body),
  });
