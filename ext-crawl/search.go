package main

import (
	"crypto/tls"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

var maxPage = 15

func SearchUrl(baseUrl string) <-chan string {
	ch := make(chan string)
	go func() {
		for i := 1; i <= maxPage; i++ {
			ch <- fmt.Sprintf("%s&page=%d", baseUrl, i)
		}
		close(ch)
	}()
	return ch
}

type GemJson struct {
	Name              string
	Downloads         int
	Project_uri       string
	Gem_uri           string
	Homepage_uri      string
	Documentation_uri string
	Source_code_uri   string
}

func Search(gemRepository *GemRepository) {
	const searchConcurrency = 10

	urlChan := make(chan string)
	doneChan := make(chan bool)

	for i := 0; i < searchConcurrency; i++ {
		go searchProcessor(gemRepository, urlChan, doneChan)
	}

	searchGenerator := SearchGenerator()

	for searchBase := range searchGenerator {
		search := SearchUrl(searchBase)
		for searchUrl := range search {
			urlChan <- searchUrl
		}
	}

	close(urlChan)

	for i := 0; i < searchConcurrency; i++ {
		<-doneChan
	}
}

func getGems(url string) []GemJson {
	tr := &http.Transport{
		TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
	}
	client := &http.Client{Transport: tr}

	res, err := client.Get(url)
	handleError(err)
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	handleError(err)

	var gems []GemJson
	err = json.Unmarshal(body, &gems)
	handleError(err)

	return gems
}

func processSearchPage(repository *GemRepository, searchUrl string) int {
	added := 0
	gems := getGems(searchUrl)
	for _, gem := range gems {
		if repository.AddGem(gem) {
			added++
		}
	}
	return added
}

func searchProcessor(repository *GemRepository, urls <-chan string, done chan<- bool) {
	for url := range urls {
		added := processSearchPage(repository, url)
		log.Printf("Processed %s. Added: %d", url, added)
	}
	done <- true
}
