#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
ENV_FILE="${REPO_ROOT}/.env"

# .env が無ければ UID/GID を埋めて生成
if [[ ! -f "${ENV_FILE}" ]]; then
  cat <<EOF > "${ENV_FILE}"
UID=$(id -u)
GID=$(id -g)
EOF

  echo ".env を生成しました:"
  cat "${ENV_FILE}"
else
  echo ".env は既に存在します。"
fi

# Docker Compose 起動
cd "${REPO_ROOT}/.devcontainer"
docker compose \
  --env-file "${REPO_ROOT}/.env" \
  -f compose.yml \
  up --build -d

echo "コンテナを起動しました。"
