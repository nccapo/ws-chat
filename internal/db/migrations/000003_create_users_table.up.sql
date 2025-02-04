BEGIN;

CREATE TABLE users (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    iid UUID DEFAULT gen_random_uuid (),
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW ()
);

CREATE UNIQUE INDEX idx_users_idd ON users (iid);

COMMIT;
