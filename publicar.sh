#!/usr/bin/env bash
# Publica esta pasta no GitHub Pages.
#
# Pré-requisito: estar logado no GitHub —
#   gh auth login --hostname github.com --git-protocol https --web --scopes repo
#
# O script é idempotente: se o repositório já existir, só empurra o commit novo.
set -euo pipefail
cd "$(dirname "$0")"

GH=${GH:-$HOME/.local/bin/gh}
REPO=${REPO:-jrgcorp-home-previa}

"${GH}" auth status --hostname github.com >/dev/null 2>&1 || {
  echo "Não está logado. Rode primeiro:"
  echo "  ${GH} auth login --hostname github.com --git-protocol https --web --scopes repo"
  exit 1
}

USUARIO=$("${GH}" api user --jq .login)
echo "Conta: ${USUARIO}"

./gerar.sh
git add -A
git diff --cached --quiet || git commit -m "Atualiza prévia da home institucional"

if ! "${GH}" repo view "${USUARIO}/${REPO}" >/dev/null 2>&1; then
  echo "Criando ${USUARIO}/${REPO}..."
  "${GH}" repo create "${USUARIO}/${REPO}" \
    --public \
    --description "Prévia da nova home institucional da JRG Corp (não é o site oficial)" \
    --source . --remote origin --push
else
  git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/${USUARIO}/${REPO}.git"
  git push -u origin main
fi

echo "Ligando o GitHub Pages..."
"${GH}" api -X POST "repos/${USUARIO}/${REPO}/pages" \
  -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 \
  || "${GH}" api -X PUT "repos/${USUARIO}/${REPO}/pages" \
       -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 || true

sleep 5
URL=$("${GH}" api "repos/${USUARIO}/${REPO}/pages" --jq .html_url 2>/dev/null || echo "https://${USUARIO}.github.io/${REPO}/")
echo
echo "No ar (a primeira publicação leva 1-2 minutos): ${URL}"
