package main

import (
	"net/url"
	"path"
	"strings"
)

type Gem struct {
	Name                string `sql:"unique_index" gorm:"primary_key"`
	Downloads           int
	GemUrl              string
	HomepageUrl         string
	DocumentationUrl    string
	SourceCodeUrl       string
	HasNativeExtensions bool
}

func (g Gem) GetFilePath() string {
	parsed, err := url.Parse(g.GemUrl)
	handleError(err)
	gemPath := parsed.Path
	parts := strings.Split(gemPath, "/")
	return path.Join("files", parts[len(parts)-1])
}
