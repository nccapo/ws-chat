BEGIN;

CREATE TABLE chat_members (
    chat_id BIGSERIAL REFERENCES chats (id) ON DELETE CASCADE,
    user_id BIGSERIAL REFERENCES users (id) ON DELETE CASCADE,
    joined_at TIMESTAMPTZ DEFAULT NOW (),
    PRIMARY KEY (chat_id, user_id)
);

CREATE INDEX idx_chat_members_user_id ON chat_members (user_id);

COMMIT;
