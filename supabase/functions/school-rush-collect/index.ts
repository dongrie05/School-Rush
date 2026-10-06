import "jsr:@supabase/functions-js/edge-runtime.d.ts";

// Fail closed until the project has an approved anti-abuse mechanism.
const allowedOrigins = new Set([
  "https://dongrie05.github.io",
  "http://localhost:4173",
  "http://127.0.0.1:4173",
]);

Deno.serve((req: Request) => {
  const origin = req.headers.get("origin") || "";
  if (!allowedOrigins.has(origin)) return new Response("Origin not allowed", { status: 403 });
  const headers = {
    "Access-Control-Allow-Origin": origin,
    "Access-Control-Allow-Headers": "authorization, apikey, content-type, x-client-info",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    "Content-Type": "application/json",
    "Vary": "Origin",
  };
  if (req.method === "OPTIONS") return new Response("ok", { headers });
  return new Response(JSON.stringify({ error: "Research collection is paused while abuse protection is configured." }), {
    status: 503,
    headers,
  });
});
