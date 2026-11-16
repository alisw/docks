#!/bin/sh -ex

# cocoindex runtime image: the Python environment of the ALICE cocoindex jobs
# (ali-bot/cocoindex: the indexer and the MCP server). It holds no code of its
# own and no credentials -- the jobspecs ship the code as templates, and the
# security-proxy sidecar holds every secret. So, unlike the security-proxy
# image, git stays in: the indexer needs it at runtime for its mirrors.

: "${ALI_BOT_REF:?set ALI_BOT_REF to an ali-bot commit containing cocoindex/requirements-linux.lock}"
PREFIX=/opt/cocoindex

# uid/gid 1000 is what the jobspecs drop to (setpriv --reuid=1000) and what the
# MCP token file is rendered for. Named here only so that logs and `ps` read
# well; the jobs use the numbers.
groupadd --gid 1000 cocoindex
useradd  --uid 1000 --gid cocoindex --home-dir /nonexistent --no-create-home \
         --shell /usr/sbin/nologin cocoindex

export DEBIAN_FRONTEND=noninteractive
apt-get update
# git: the indexer's mirrors (fetch, show, log). util-linux: setpriv, which the
# jobspecs use to drop privileges (essential in Debian; listed to make the
# dependency explicit). ca-certificates: GitHub over HTTPS.
apt-get install -y --no-install-recommends git ca-certificates util-linux

# Fetch only the lock, at a pinned commit (fetch-by-ref, since clone --branch
# does not take a SHA).
git init -q /tmp/ali-bot
git -C /tmp/ali-bot remote add origin https://github.com/alisw/ali-bot
git -C /tmp/ali-bot fetch -q --depth 1 origin "$ALI_BOT_REF"
git -C /tmp/ali-bot checkout -q FETCH_HEAD
echo "ali-bot at $(git -C /tmp/ali-bot rev-parse HEAD)"
mkdir -p "$PREFIX"
cp /tmp/ali-bot/cocoindex/requirements.in /tmp/ali-bot/cocoindex/requirements-linux.lock "$PREFIX/"

python3 -m venv "$PREFIX/venv"
# --require-hashes: the lock, not the resolver, decides what lands here.
# --only-binary: every locked package has a manylinux x86_64 cp312 wheel
# (checked 2026-11-16), so nothing may be compiled -- and this image has no
# compiler anyway. --no-deps: the lock is complete; nothing may be added.
"$PREFIX/venv/bin/pip" install --no-cache-dir --disable-pip-version-check \
    --require-hashes --only-binary :all: --no-deps \
    -r "$PREFIX/requirements-linux.lock"
"$PREFIX/venv/bin/pip" check

# Fail the build, not the first pass on the cluster, if the interpreter cannot
# load SQLite extensions or a dependency does not import.
"$PREFIX/venv/bin/python" - <<'EOF'
import sqlite3, sqlite_vec
c = sqlite3.connect(":memory:")
c.enable_load_extension(True)
sqlite_vec.load(c)
print("sqlite", sqlite3.sqlite_version, "sqlite-vec", c.execute("select vec_version()").fetchone()[0])
import cocoindex, litellm, mcp, jwt, uvicorn, boto3, zstandard
print("imports OK")
EOF

# pip is not needed at runtime; leaving it lets anything that gets code
# execution install more.
"$PREFIX/venv/bin/python" -m pip uninstall -y pip
apt-get clean
rm -rf /tmp/ali-bot /var/lib/apt/lists/* /root/.cache

chown -R root:root "$PREFIX"
find "$PREFIX" ! -type l -exec chmod go-w {} +
