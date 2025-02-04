BEGIN;

CREATE TABLE chats (
    id BIGSERIAL PRIMARY KEY,
    iid UUID DEFAULT gen_random_uuid (),
    type VARCHAR(10) NOT NULL CHECK (type IN ('direct', 'group')),
    name VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW (),
    updated_at TIMESTAMPTZ DEFAULT NOW (),
    deleted_at TIMESTAMP
);

CREATE UNIQUE INDEX idx_chats_idd ON chats (iid);

COMMIT;
