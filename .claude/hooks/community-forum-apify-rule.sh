#!/usr/bin/env bash
# PreToolUse hook for community-forum research.
# Inspects the Bash tool_input.command from stdin; if it touches Reddit, Quora,
# Slack, Google Groups, Instagram, Facebook, X/Twitter, or Discord — injects
# the Apify rule into model context so the model reroutes to the Apify skill
# instead of curling/wgeting/scraping by hand.
#
# Layered defense:
#  1. CLAUDE.md                — instruction layer (Claude reads on session start)
#  2. Apify skill              — service layer (correct scrapers per platform)
#  3. THIS hook                — harness layer (deterministic, fires every call)
#
# Wired in .claude/settings.json under hooks.PreToolUse with matcher "Bash".

set -u

# Read the PreToolUse JSON envelope from stdin
INPUT=$(cat)

# Extract the Bash command (jq-free, portable enough for project use)
COMMAND=$(printf '%s' "$INPUT" | sed -n 's/.*"command"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)

# Fast bail-out — if no community-forum host appears in the command, exit silent.
# Hostnames must be preceded AND followed by a non-host character (URL boundary
# guard) so that e.g. `learn.microsoft.com` does not falsely match `t.co`,
# and `box.com` does not falsely match `x.com`.
HOSTS='(reddit\.com|old\.reddit\.com|redd\.it|quora\.com|slack\.com|app\.slack\.com|groups\.google\.com|instagram\.com|facebook\.com|fb\.com|m\.facebook\.com|x\.com|twitter\.com|t\.co|discord\.com|discord\.gg)'
if ! printf '%s' "$COMMAND" | grep -qiE "(^|[^a-z0-9])${HOSTS}([^a-z0-9]|$)"; then
  exit 0
fi

# Inject the Apify rule
cat <<'JSON'
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "additionalContext": "PROJECT RULE 3 — Community forum research MUST use the Apify skill (notebooklm_source_automation/CLAUDE.md):\n\nThe Bash command you are about to run targets a community-forum domain (Reddit, Quora, Slack, Google Groups, Instagram, Facebook, X/Twitter, or Discord). DO NOT curl/wget/scrape these directly — they are rate-limited, paywalled, login-walled, or hostile to bare HTTP, and the resulting research will be incomplete or fabricated.\n\nUSE THE APIFY SKILL INSTEAD:\n  - Reddit                  → Apify actor `trudax/reddit-scraper-lite` or `dtrungtin/reddit-scraper`\n  - Quora                   → Apify actor `apify/quora-scraper`\n  - Slack (public archives) → Apify actor `apify/slack-channel-scraper` (only authorized public channels)\n  - Google Groups           → Apify actor `apify/google-groups-scraper`\n  - Instagram               → Apify actor `apify/instagram-scraper` (profile/post/hashtag/comments)\n  - Facebook                → Apify actor `apify/facebook-pages-scraper` or `apify/facebook-posts-scraper`\n  - X / Twitter             → Apify actor `apidojo/tweet-scraper` or `apify/twitter-scraper`\n  - Discord                 → Apify actor `eedm123/discord-scraper` (public servers only)\n\nHOW TO INVOKE:\n  1. Skill('Apify') — let the skill route to the correct actor with the right input shape.\n  2. Or call the Apify CLI directly: `apify call <actor-id> --input '<json>'`.\n  3. The Apify skill workflow handles auth, rate-limit backoff, pagination, and CAPTCHA escalation.\n\nWHEN AN EXCEPTION IS ACCEPTABLE (state the reason in your update):\n  - One-shot fetch of a single public URL the user explicitly pasted (not bulk scraping).\n  - Apify is unavailable (token missing, actor down) AND the user accepts degraded coverage.\n  - You are testing a curl command for diagnostic reasons and will not act on the output.\n\nSEE ALSO: `Skill('Apify')` SKILL.md for the full actor catalog, and CLAUDE.md Rule 3 + Enforcement layer table for the project rationale."
  }
}
JSON
