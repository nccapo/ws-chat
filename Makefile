include .env
## build: Build binary
build:
	@echo "Building..."
	env CGO_ENABLED=0  go build -ldflags="-s -w" -o ${BINARY_NAME} ./cmd/ws-chat
	@echo "Built!"

## run: builds and runs the application
run: build
	@echo "Starting..."
	@env DSN=${DSN} APP_PORT=${APP_PORT} ./${BINARY_NAME} &
	@echo "Started!"

## clean: runs go clean and deletes binaries
clean:
	@echo "Cleaning..."
	@go clean
	@rm ${BINARY_NAME}
	@echo "Cleaned!"

## start: an alias to run
start: run

## stop: stops the running application
stop:
	@echo "Stopping..."
	@-pkill -SIGTERM -f "./${BINARY_NAME}"
	@echo "Stopped!"

## restart: stops and starts the application
restart: stop start

## test: runs all tests
test:
	go test -v ./...

TABLE_PARAM ?=  $(if $(table),$(table),default_table)
## migration_create: create migration
migrate_create:
	@echo "Migrating up the dadabase..."
	@echo $(TABLE_PARAM)
	migrate create -ext sql -dir internal/db/migrations -seq $(TABLE_PARAM)

## migration_up: migrate up
migrate_up:
	@echo "Migrating up the dadabase..."
	migrate -path internal/db/migrations -database ${DSN} -verbose up

## migration_down: migrate down
migrate_down:
	@echo "Migrating down the dadabase..."
	migrate -path internal/db/migrations -database ${DSN} -verbose down

## generate docs
gen-docs:
	@echo "generating docs"
	@swag init  --parseDependency --parseInternal -g ./cmd/ws-chat/main.go -d pkg/handlers && swag fmt
	@echo "doc generated"
