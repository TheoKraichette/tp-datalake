#!/usr/bin/env bash
# Affiche les preuves du TP (MinIO + PostgreSQL). Usage : bash scripts/verifier.sh
set -e
export MSYS_NO_PATHCONV=1

echo "═══════ Conteneurs ═══════"
docker compose ps

echo ""; echo "═══════ Buckets MinIO ═══════"
docker exec tp-pokemon-minio mc ls local

echo ""; echo "═══════ Objets dans raw-pokemon ═══════"
docker exec tp-pokemon-minio mc ls --recursive local/raw-pokemon

echo ""; echo "═══════ Catalogue pokemon_files ═══════"
docker exec tp-pokemon-postgres psql -U datalake -d pokemon_lake -c \
  "SELECT f.file_id, p.name AS pokemon, f.bucket_name, f.object_key,
          pg_size_pretty(f.file_size) AS taille, f.checksum_md5
   FROM pokemon_files f JOIN pokemon p ON p.pokemon_id = f.pokemon_id
   ORDER BY f.file_id;"

echo ""; echo "═══════ Journal file_ingestion_log ═══════"
docker exec tp-pokemon-postgres psql -U datalake -d pokemon_lake -c \
  "SELECT log_id, file_name, source, status, file_id, processed_at
   FROM file_ingestion_log ORDER BY log_id;"
