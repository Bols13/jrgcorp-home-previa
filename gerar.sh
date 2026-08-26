#!/usr/bin/env bash
# Regera o index.html a partir do mockup da home.
#
# A fonte é ../mockup-home-jrgcorp.html, que nasceu para o wrapper de Artifact e
# não tem <!doctype>/<head>/<body>. Este script só acrescenta o esqueleto que
# uma página hospedada precisa — inclusive o `noindex`, para que esta prévia não
# apareça no buscador como se fosse o jrgcorp.com. Nada do conteúdo, do CSS ou
# das imagens é tocado: a tarja de "aguarda aprovação" já vem do próprio mockup.
set -euo pipefail
cd "$(dirname "$0")"
FONTE=../mockup-home-jrgcorp.html

{
  cat cabecalho.html
  tail -n +2 "$FONTE"   # linha 1 é o <title> antigo, substituído pelo do <head>
  printf '</body>\n</html>\n'
} > index.html

echo "index.html regerado — $(du -h index.html | cut -f1)"
