package handlers

import (
	"fmt"
	"net/http"

	"github.com/nccapo/ws-chat/pkg/http/ws"
	httpSwagger "github.com/swaggo/http-swagger"
)

func Routes() *http.ServeMux {
	mux := http.NewServeMux()

	hub := ws.NewHub()
	mux.HandleFunc("/ws", hub.HandleWebSocket)

	docsURL := fmt.Sprintf("%s/swagger/doc.json", H.application.Config.Addr)
	mux.HandleFunc("/swagger/", httpSwagger.Handler(
		httpSwagger.URL(docsURL),
		httpSwagger.DeepLinking(true),
		httpSwagger.DocExpansion("none"),
	))

	return mux
}
