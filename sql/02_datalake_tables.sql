CREATE TABLE IF NOT EXISTS pokemon_files (
    file_id      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pokemon_id   INTEGER     NOT NULL REFERENCES pokemon(pokemon_id),
    bucket_name  TEXT        NOT NULL,
    object_key   TEXT        NOT NULL,
    file_name    TEXT        NOT NULL,
    file_type    TEXT        NOT NULL,
    file_size    BIGINT,
    mime_type    TEXT,
    internal_url TEXT,
    checksum_md5 TEXT,
    ingested_at  TIMESTAMPTZ DEFAULT now(),
    created_at   TIMESTAMPTZ DEFAULT now(),
    CONSTRAINT uq_pokemon_files_object UNIQUE (bucket_name, object_key)
);

CREATE INDEX IF NOT EXISTS idx_pokemon_files_pokemon ON pokemon_files (pokemon_id);

CREATE TABLE IF NOT EXISTS file_ingestion_log (
    log_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    file_name    TEXT        NOT NULL,
    bucket_name  TEXT,
    object_key   TEXT,
    source       TEXT,
    status       TEXT        NOT NULL,
    message      TEXT,
    file_id      BIGINT      REFERENCES pokemon_files(file_id),
    processed_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_ingestion_log_status ON file_ingestion_log (status);
