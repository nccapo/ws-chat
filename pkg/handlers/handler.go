// Package handler is used for http handlers, where all handlers is defined inside of this package
package handlers

import "github.com/nccapo/ws-chat/pkg/config"

var H Handler

type Handler struct {
	application *config.Application
}

func NewHandler(app *config.Application) {
	H = Handler{
		application: app,
	}
}
