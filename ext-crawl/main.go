package main

import (
	"log"

	"github.com/jinzhu/gorm"
	_ "github.com/mattn/go-sqlite3"
)

func main() {
	db, err := gorm.Open("sqlite3", "ext-crawl.db")
	if err != nil {
		log.Fatalf("Error opening DB: %s", err)
	}
	db.LogMode(true)
	db.AutoMigrate(&Gem{})

	gemRepository := NewGemRepository(db)

	DetectNativeDependencies(gemRepository)
}
