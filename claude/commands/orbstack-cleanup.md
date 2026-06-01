---
description: Use when done testing a branch in OrbStack and need to return the root repo to master
author: Cong Chen
---

Clean up after `/test-in-orbstack` by returning the root repo to master and restarting the Rails server.

## Step 1 — Determine the root repo path

Same logic as `/test-in-orbstack`:

```bash
CURRENT_DIR="$(pwd)"
PARENT_DIR="$(dirname "$CURRENT_DIR")"
DIR_NAME="$(basename "$CURRENT_DIR")"

ROOT_NAME="$(echo "$DIR_NAME" | sed 's/-[0-9]*$//')"
ROOT_REPO="$PARENT_DIR/$ROOT_NAME"
```

If `ROOT_NAME` equals `DIR_NAME`, the user is in the root repo — proceed directly.

Verify the root repo exists. If not, report error and stop.

## Step 2 — Return to master

```bash
cd "$ROOT_REPO"
git checkout master
```

Print confirmation of the switch.

## Step 3 — Restart the Rails server

```bash
cd "$ROOT_REPO"
docker compose restart web
```

Wait for the server to boot, then verify:
```bash
sleep 25
curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/dashboard/login
```

- `200` or `302` — server is up on master
- `000` — not ready yet, wait another 15 seconds and retry once
- Other — show `docker compose logs --tail=20 web` and report

## Step 4 — Summary

Print:
- Root repo path
- Confirmed back on master
- Rails server status
