// Package ws implements `gorilla/websocket` intialization
package ws

import (
	"net/http"
	"sync"

	"github.com/gorilla/websocket"
)

// Client represents a connected WebSocket user
type Client struct {
	conn   *websocket.Conn
	send   chan []byte
	roomID string
	email  string
}

// Room manages client in a chat room
type Room struct {
	clients    map[*Client]bool
	broadcast  chan []byte
	register   chan *Client
	unregister chan *Client
}

// Hub manages all the room
type Hub struct {
	rooms map[string]*Room
	mu    sync.RWMutex
}

var upgrader = websocket.Upgrader{
	CheckOrigin: func(r *http.Request) bool { return true },
}
