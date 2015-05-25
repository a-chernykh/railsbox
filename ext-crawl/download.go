package main

import (
	"github.com/jinzhu/gorm"
	"io"
	"log"
	"net/http"
	"os"
)

func downloadWorker(db gorm.DB, gems <-chan string, done chan<- bool) {
	for gem := range gems {
		gemRecord := Gem{}
		db.Where(&Gem{Name: gem}).First(&gemRecord)
		outputPath := gemRecord.GetFilePath()

		if _, err := os.Stat(outputPath); os.IsNotExist(err) {
			log.Printf("Downloading %s to %s", gem, outputPath)

			out, err := os.Create(outputPath)
			handleError(err)
			defer out.Close()

			resp, err := http.Get(gemRecord.GemUrl)
			handleError(err)
			defer resp.Body.Close()

			_, err1 := io.Copy(out, resp.Body)
			handleError(err1)
		}
	}
	done <- true
}

func Download(gr *GemRepository) {
	const downloadConcurrency = 5

	gemChan := make(chan string)
	doneChan := make(chan bool)

	for i := 0; i < downloadConcurrency; i++ {
		go downloadWorker(gr.db, gemChan, doneChan)
	}

	gems := gr.DownloadQueue()
	for _, gem := range gems {
		gemChan <- gem
	}

	close(gemChan)

	for i := 0; i < downloadConcurrency; i++ {
		<-doneChan
	}
}
