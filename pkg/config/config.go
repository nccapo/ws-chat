// Package config manage all initial values, structs, interfaces and so on.
package config

import (
	"log"
	"os"
	"time"
)

type Application struct {
	InfoLog   *log.Logger
	ErrorLog  *log.Logger
	DebugMode *bool
	Config    Config
}

type DBConfig struct {
	Addr         string
	MaxOpenConns int
	MaxIdleConns int
	MaxIdleTime  time.Duration
}

type Config struct {
	Addr     string
	ApiUrl   string
	DBConfig DBConfig
	Env      string
}

func NewConfig() Config {
	return Config{
		Addr: ":" + os.Getenv("APP_PORT"),
		DBConfig: DBConfig{
			Addr:         os.Getenv("DSN"),
			MaxIdleTime:  30 * time.Second,
			MaxOpenConns: 30,
			MaxIdleConns: 30,
		},
		ApiUrl: os.Getenv("API_URL"),
		Env:    os.Getenv("APP_ENV"),
	}
}
