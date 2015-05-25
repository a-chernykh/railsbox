package main

import (
	"github.com/jinzhu/gorm"
	"os"
)

type GemRepository struct {
	db   gorm.DB
	gems map[string]bool
}

func NewGemRepository(db gorm.DB) *GemRepository {
	return &GemRepository{db, make(map[string]bool)}
}

func (gr GemRepository) AddGem(gem GemJson) bool {
	if !gr.gems[gem.Name] {
		gemRecord := Gem{Name: gem.Name,
			Downloads:        gem.Downloads,
			GemUrl:           gem.Gem_uri,
			HomepageUrl:      gem.Homepage_uri,
			DocumentationUrl: gem.Documentation_uri,
			SourceCodeUrl:    gem.Source_code_uri}
		gr.db.Create(&gemRecord)
		gr.gems[gem.Name] = true
		return true
	} else {
		return false
	}
}

func (gr GemRepository) DownloadQueue() []string {
	var names []string
	gr.db.Model(&Gem{}).Order("downloads DESC").Pluck("name", &names)
	return names
}

func (gr GemRepository) ProcessingQueue() chan Gem {
	gems := make(chan Gem)

	go func() {
		var names []string
		gr.db.Model(&Gem{}).Order("downloads DESC").Pluck("name", &names)

		for _, name := range names {
			var gemRecord Gem
			gr.db.Where("name = ?", name).First(&gemRecord)
			if _, err := os.Stat(gemRecord.GetFilePath()); err == nil {
				gems <- gemRecord
			}
		}

		close(gems)
	}()

	return gems
}
