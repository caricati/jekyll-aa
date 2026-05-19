#!/bin/bash

# ==========================================
# Jekyll Post Generator
# ==========================================

# Função para gerar slug
slugify() {
  echo "$1" \
    | iconv -t ascii//TRANSLIT \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g' \
    | sed -E 's/^-+|-+$//g'
}

# ==========================================
# Inputs
# ==========================================

read -p "Titulo em ingles: " TITLE_EN
read -p "Titulo em portugues: " TITLE_PT
read -p "Data da publicação (YYYY-MM-DD): " POST_DATE

# ==========================================
# Datas
# ==========================================

YYYY=$(date -d "$POST_DATE" +"%Y")
YY=$(date -d "$POST_DATE" +"%y")
MM=$(date -d "$POST_DATE" +"%m")
DD=$(date -d "$POST_DATE" +"%d")

# ==========================================
# Slugs
# ==========================================

SLUG_EN=$(slugify "$TITLE_EN")
SLUG_PT=$(slugify "$TITLE_PT")

# ==========================================
# Diretórios
# ==========================================

UPLOAD_DIR="uploads/$YY/$MM/$SLUG_EN"

POST_PT_DIR="_posts/$YYYY/$MM"
POST_EN_DIR="_posts_en/$YYYY/$MM"

POST_PT_FILE="$POST_PT_DIR/$YYYY-$MM-$DD-$SLUG_PT.md"
POST_EN_FILE="$POST_EN_DIR/$YYYY-$MM-$DD-$SLUG_EN.md"

# ==========================================
# Criar diretórios sem sobrescrever
# ==========================================

mkdir -p "$UPLOAD_DIR"
mkdir -p "$POST_PT_DIR"
mkdir -p "$POST_EN_DIR"

# ==========================================
# Criar .keep se não existir
# ==========================================

if [ ! -f "$UPLOAD_DIR/.keep" ]; then
  touch "$UPLOAD_DIR/.keep"
fi

# ==========================================
# Criar post PT
# ==========================================

if [ ! -f "$POST_PT_FILE" ]; then
cat > "$POST_PT_FILE" <<EOF
---
layout: post
lang: pt
ref: $SLUG_EN
title: "$TITLE_PT"
date: $YYYY-$MM-$DD 12:20:00 -0300
banner: /uploads/$YY/$MM/$SLUG_EN/cover.jpg
thumb: /uploads/$YY/$MM/$SLUG_EN/thumb.jpg
image: /uploads/$YY/$MM/$SLUG_EN/thumb.jpg
description: ""
categories:
  - 
audios:
  - /uploads/$YY/$MM/$SLUG_EN/voice-pt.mp3
tags:
  - 
---
EOF

  echo "Arquivo PT criado: $POST_PT_FILE"
else
  echo "Arquivo PT já existe: $POST_PT_FILE"
fi

# ==========================================
# Criar post EN
# ==========================================

if [ ! -f "$POST_EN_FILE" ]; then
cat > "$POST_EN_FILE" <<EOF
---
layout: post
lang: en
ref: $SLUG_EN
title: "$TITLE_EN"
date: $YYYY-$MM-$DD 12:20:00 -0300
banner: /uploads/$YY/$MM/$SLUG_EN/cover.jpg
thumb: /uploads/$YY/$MM/$SLUG_EN/thumb.jpg
image: /uploads/$YY/$MM/$SLUG_EN/thumb.jpg
description: ""
categories:
  - 
audios:
  - /uploads/$YY/$MM/$SLUG_EN/voice-en.mp3
tags:
  - 
---
EOF

  echo "Arquivo EN criado: $POST_EN_FILE"
else
  echo "Arquivo EN já existe: $POST_EN_FILE"
fi

echo ""
echo "Slug EN: $SLUG_EN"
echo "Slug PT: $SLUG_PT"
echo "Estrutura criada com sucesso."