package main

import "testing"

func assertPage(t *testing.T, expected string, got string) {
	if expected != got {
		t.Errorf("Expected page to be %s. Got %s", expected, got)
	}
}
