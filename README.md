# School Rush Tycoon

A mobile-first browser game about how young people prioritise mobility around a secondary school and take part in decisions.

## Run locally

```sh
python3 -m http.server 4173
```

Open <http://localhost:4173>. The dashboard is at <http://localhost:4173/research/>.

## Shared research collection

After a player agrees to participate and finishes the three mornings, the game automatically sends their choices and optional reflection to the project's private Supabase database. The game does not ask for names, email addresses, actual ages, or school identifiers. Supabase creates a random anonymous account ID to enforce one stored response per account; Supabase may process connection details for security. Players are told not to include identifying details in the optional reflection. If the network is unavailable, a finished session stays on that device and retries later.

The active database is the dedicated `School-Rush-Research` project (`womlyqamfaoxmvwgunqc`, EU West). Its SQL migrations are in `supabase/migrations/`. Keep anonymous sign-ins enabled in Supabase Authentication. The app uses only the project's public publishable key in `research-config.js`; it never includes a service-role key. Row-level security allows an anonymous authenticated user to insert only its own response. A unique participant ID allows one stored response per anonymous account. Anonymous participants cannot read, update, or delete any response. Authorized project members can review raw responses in the [private Supabase Table Editor](https://supabase.com/dashboard/project/womlyqamfaoxmvwgunqc/editor). The public research page displays fictional example rows and this browser's local sessions only.

Supabase enforces an IP-based rate limit on anonymous sign-ins. For wider public recruitment, add CAPTCHA/Cloudflare Turnstile to reduce automated sign-ups. The old `school-rush-collect` Edge Function is paused and is not used by the game.

Before inviting young people, review this setup with the university's ethics and safeguarding process. The on-screen notice is not a substitute for any approvals, study information, consent/assent, guardian or school permissions that apply. Define the university's retention and deletion schedule before real recruitment.

## Publish

The app is static and can be served from GitHub Pages. Enable Pages in the repository's **Settings → Pages**, choose **Deploy from a branch**, then select `main` and `/ (root)`. The game URL is the repository's Pages URL; the research dashboard is the same URL with `/research/`.
