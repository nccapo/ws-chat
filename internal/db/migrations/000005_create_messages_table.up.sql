BEGIN;

CREATE TABLE messages (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    iid UUID DEFAULT gen_random_uuid (),
    chat_id BIGSERIAL REFERENCES chats (id) ON DELETE CASCADE,
    sender_id BIGSERIAL REFERENCES users (id) ON DELETE SET NULL,
    content TEXT NOT NULL,
    is_deleted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW (),
    updated_at TIMESTAMPTZ DEFAULT NOW ()
);

CREATE INDEX idx_messages_chat_id_created_at ON messages (chat_id, created_at);

CREATE INDEX idx_messages_iid ON messages (iid);

COMMIT;
