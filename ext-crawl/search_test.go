package main

import "testing"

func TestNewSearchURL(t *testing.T) {
	search := Search("http://example.com/search?query=abc")
	page1 := <-search
	page2 := <-search
	assertPage(t, "http://example.com/search?query=abc&page=1", page1)
	assertPage(t, "http://example.com/search?query=abc&page=2", page2)
}
