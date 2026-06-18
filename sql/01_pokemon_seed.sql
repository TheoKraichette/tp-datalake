CREATE TABLE IF NOT EXISTS pokemon (
    pokemon_id  INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL UNIQUE,
    type1       TEXT,
    type2       TEXT,
    generation  INTEGER DEFAULT 1
);

INSERT INTO pokemon (pokemon_id, name, type1, type2) VALUES
    (1,  'bulbasaur',  'grass',    'poison'),
    (4,  'charmander', 'fire',     NULL),
    (7,  'squirtle',   'water',    NULL),
    (25, 'pikachu',    'electric', NULL),
    (39, 'jigglypuff', 'normal',   'fairy'),
    (52, 'meowth',     'normal',   NULL),
    (54, 'psyduck',    'water',    NULL),
    (94, 'gengar',     'ghost',    'poison'),
    (130,'gyarados',   'water',    'flying'),
    (133,'eevee',      'normal',   NULL),
    (143,'snorlax',    'normal',   NULL),
    (149,'dragonite',  'dragon',   'flying'),
    (150,'mewtwo',     'psychic',  NULL),
    (151,'mew',        'psychic',  NULL)
ON CONFLICT (pokemon_id) DO NOTHING;
