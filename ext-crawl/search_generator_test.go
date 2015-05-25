package main

import "testing"

func TestSearchGenerator(t *testing.T) {
	ch := SearchGenerator()
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=a", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=b", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=c", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=d", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=e", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=f", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=g", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=h", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=i", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=j", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=k", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=l", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=m", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=n", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=o", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=p", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=q", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=r", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=s", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=t", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=u", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=v", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=w", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=x", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=y", <-ch)
	assertPage(t, "https://rubygems.org/api/v1/search.json?query=z", <-ch)
	_, more := <-ch
	if more {
		t.Error("Expected channel to be closed after letter 'z'")
	}
}
