# Nova home institucional — JRG Corp

Prévia pública da home proposta em AGO/2026, publicada no GitHub Pages para o
Januário e o time conferirem antes da montagem no WordPress.

**Esta não é o site oficial.** O site no ar é [jrgcorp.com](https://jrgcorp.com),
e continua intocado. A própria página avisa isso na tarja do topo — *"Proposta ·
nova home institucional · aguarda aprovação"*.

## O que é cada arquivo

| | |
|---|---|
| `../mockup-home-jrgcorp.html` | a fonte — referência visual da página |
| `../AGO26 - HOME INSTITUCIONAL JRG CORP.md` | a copy, bloco a bloco |
| `../COMO-SUBIR-NO-WORDPRESS.md` | o roteiro de montagem no Elementor |
| `index.html` | esta prévia, gerada |

## O mockup não vira o site

O HTML daqui **não sobe no WordPress**. Ele traz header, footer e CSS próprios, e
colá-lo num widget de HTML brigaria com o tema — ninguém além de quem colou
conseguiria editar depois. A página é remontada com widgets do Elementor,
seguindo o `COMO-SUBIR-NO-WORDPRESS.md`. Esta prévia serve para aprovar o
desenho, não para virar produção.

## Crédito de imagem — obrigação, não enfeite

A foto de capa é *Hercilio Luz.jpg*, de **Rodrigo Graeff**, sob **CC BY 2.0**. A
linha no rodapé — com link para o arquivo no Wikimedia Commons e para a licença —
**é exigência da licença**. Se a página for remontada no Elementor e essa linha
sumir, o uso vira irregular.

## Como regerar

```bash
./gerar.sh
git add -A && git commit && git push
```

O `gerar.sh` acrescenta ao mockup o esqueleto que uma página hospedada precisa —
`<!doctype>`, `<head>` com charset, viewport e `noindex`. O `noindex` é
intencional: esta prévia não pode competir com o `jrgcorp.com` no buscador nem
aparecer como endereço oficial da marca.

O `.nojekyll` impede o Jekyll de processar o diretório — o arquivo é um HTML
único com fotos e logos embutidos em base64, sem dependência externa além da
fonte Noto Sans do Google Fonts.
