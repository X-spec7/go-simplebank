package db

import (
	"context"
	"log"
	"os"
	"testing"

	"github.com/jackc/pgx/v5/pgxpool"
)

const (
	dbSource = "postgresql://root:secret@localhost:5432/simplebank?sslmode=disable"
)

var testQueries *Queries
var testDB *pgxpool.Pool

func TestMain(m *testing.M) {
	ctx := context.Background()

	pool, err := pgxpool.New(ctx, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db: ", err)
	}

	testDB = pool
	testQueries = New(pool)

	code := m.Run()

	pool.Close()
	os.Exit(code)
}
