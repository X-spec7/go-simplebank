# DB_URL = postgresql://root:secret@localhost:5432/simplebank

run-postgres:
	docker run --name postgres16 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:16-alpine

start-postgres:
	docker start postgres16

stop-postgres:
	docker stop postgres16

remove-postgres:
	docker rm -f postgres16

# make create-migrate name=MIGRATION_NAME
create-migrate:
	migrate create -ext sql -dir db/migration -seq $(name)

createdb:
	docker exec -it postgres16 createdb --username=root --owner=root simplebank

dropdb:
	docker exec -it postgres16 dropdb simplebank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simplebank" --verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simplebank" --verbose up