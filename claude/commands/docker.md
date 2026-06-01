---
description: Start Docker dev environment, or diagnose and fix whatever is broken
author: Cong Chen
---

You are a Docker environment doctor for the persona-web dev stack. Your goal: get all containers healthy and `localhost:3000/dashboard` accessible.

The expected healthy state is:
- **Data stores**: `mysql`, `redis`, `elasticsearch`, `mongo-shard0`, `mongos`, `mongot`, `valkey-cluster`, `clickhouse`, `kafka`, `kafka-schema-registry`
- **App containers**: `web`, `vite`, `worker`
- **Support**: `mailcatcher`, `temporal`, `temporal-admin-tools`, `temporal-ui`

---

## Step 1 — Check if Docker daemon is running

```
docker ps 2>&1 | head -5
```

If Docker is not running (e.g. "Cannot connect to the Docker daemon"), tell the user to start Docker/Orbstack and wait for it to be ready before re-running this command. Stop here.

---

## Step 2 — Get container status snapshot

```
docker compose ps --format "table {{.Name}}\t{{.Status}}\t{{.Health}}"
```

Categorize each container:
- **Healthy/Up** — no action needed
- **Not running / missing** — needs to be started
- **Exited** — needs diagnosis (check logs)
- **Unhealthy** — needs diagnosis

Print a brief summary of what's up, what's down, and what's unhealthy.

---

## Step 3 — Fix data stores first (web depends on them)

If any data store is missing or exited, start them in the correct dependency order:

```
docker compose up -d mysql redis elasticsearch clickhouse valkey-cluster kafka
docker compose up -d mongo-shard0
sleep 5
docker compose up -d mongos mongot kafka-schema-registry
```

Wait for data stores to become healthy before proceeding:
```
docker compose ps --format "table {{.Name}}\t{{.Health}}"
```

**MongoDB instability** ("Too many open files" in logs):
```
docker compose restart mongo-shard0
sleep 30
docker compose restart mongos mongot
```

**Elasticsearch won't start** (check for "Unrecognized VM option UseSVE=0" — x86 issue):
- This is handled by `docker-compose.override.yml` — if it's missing, note it to the user but don't auto-fix.

---

## Step 4 — Diagnose app container failures

For each of `web`, `vite`, `worker` that is not running:

```
docker compose logs --tail=50 <service>
```

Match the log output to a known issue and fix it:

### Missing gems
**Symptom**: `Could not find <gem-name> in locally installed gems` or `Run bundle install`
```
docker compose run --rm --no-deps web bundle install
```
Then start the containers:
```
docker compose up -d web worker
```

### Stale native extensions (image tag changed)
**Symptom**: `LoadError`, `.so` file errors, Puma crashes on boot with native gem errors
```
docker volume rm workspace_bundle-ruby-3-3
docker compose run --rm --no-deps web bundle install
docker compose up -d web worker
```

### Missing JS packages
**Symptom**: `Cannot find module`, `yarn install` errors in vite logs
```
docker compose run --rm --no-deps vite yarn
docker compose up -d vite
```

### Pending migrations
**Symptom**: `ActiveRecord::PendingMigrationError` in web logs
```
docker compose exec web bundle exec rails db:migrate
```
If `web` isn't running yet, start it first, then run migrations.

### Port already in use
**Symptom**: `address already in use` on port 3000
```
lsof -ti:3000 | xargs kill -9
docker compose up -d web
```

### OCI / container already exists
**Symptom**: `container name already in use` or similar OCI errors
```
docker compose down
docker compose up -d mysql redis elasticsearch clickhouse valkey-cluster kafka
docker compose up -d mongo-shard0
sleep 5
docker compose up -d mongos mongot kafka-schema-registry mailcatcher temporal temporal-admin-tools temporal-ui
docker compose up -d web vite worker
```

### General crash loop / unknown error
If none of the above patterns match, show the last 30 lines of logs to the user and ask for guidance.

---

## Step 5 — Start app containers

Once data stores are healthy:
```
docker compose up -d web vite worker
```

Wait 10 seconds, then verify:
```
docker compose ps --format "table {{.Name}}\t{{.Status}}" | grep -E "web|vite|worker"
```

If they exited again, go back to Step 4 and check their logs again.

---

## Step 6 — Verify the stack is working

```
curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/dashboard/login
```

- `200` or `302` → stack is healthy, you're done
- `000` (connection refused) → web isn't serving yet, wait 10 seconds and retry once
- Anything else → check `docker compose logs --tail=20 web` for errors

Print a final status: which containers are running, and whether the dashboard is reachable.

---

## Important notes

- **Never delete data volumes** (mysql data, mongo data) — only the bundle volume is safe to delete
- **Artifactory credentials**: if `bundle install` fails with auth errors, the user needs to set `ARTIFACTORY_USER` and `ARTIFACTORY_API_KEY` — prompt them
- **Start order matters**: always start data stores before app containers
- If the same issue repeats after a fix attempt, report it clearly rather than looping
