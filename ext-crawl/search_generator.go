package main

import "fmt"

var alphabet = "abcdefghijklmnopqrstuvwxyz"
var template = "https://rubygems.org/api/v1/search.json?query=%c"

func SearchGenerator() <-chan string {
	ch := make(chan string)
	go func() {
		for _, letter := range alphabet {
			ch <- fmt.Sprintf(template, letter)
		}
		close(ch)
	}()
	return ch
}
