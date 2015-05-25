package main

import (
	"archive/tar"
	"compress/gzip"
	"io"
	"io/ioutil"
	"os"

	"github.com/jinzhu/gorm"
	"gopkg.in/yaml.v2"
)

type Metadata struct {
	Extensions []string
}

func process(db gorm.DB, gems <-chan Gem, done chan<- bool) {
	for gem := range gems {
		path := gem.GetFilePath()
		f, err := os.Open(path)
		handleError(err)

		tarReader := tar.NewReader(f)
		for {
			hdr, err := tarReader.Next()
			if err == io.EOF {
				break
			}
			handleError(err)

			if hdr.Name == "metadata.gz" {
				gzipReader, err := gzip.NewReader(tarReader)
				handleError(err)

				data, err := ioutil.ReadAll(gzipReader)
				handleError(err)

				metadata := Metadata{}
				err1 := yaml.Unmarshal(data, &metadata)
				handleError(err1)

				gem.HasNativeExtensions = len(metadata.Extensions) > 0
				db.Save(&gem)

				gzipReader.Close()
			}
		}

		f.Close()
	}

	done <- true
}

func DetectNativeDependencies(gr *GemRepository) {
	doneChan := make(chan bool)
	gems := gr.ProcessingQueue()
	go process(gr.db, gems, doneChan)
	<-doneChan
}
