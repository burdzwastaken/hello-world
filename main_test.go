package main

import (
	"bytes"
	"net/http"
	"net/http/httptest"
	"os"
	"os/exec"
	"testing"
)

func init() {
	os.Setenv("PORT", "8080")
}
func TestHandler(t *testing.T) {
	expected := []byte("yo yo world!")

	req, err := http.NewRequest("GET", buildURL("/"), nil)
	if err != nil {
		t.Fatal(err)
	}

	res := httptest.NewRecorder()

	helloWorld(res, req)

	if res.Code != http.StatusOK {
		t.Errorf("Response code was %v; want 200", res.Code)
	}

	if bytes.Compare(expected, res.Body.Bytes()) != 0 {
		t.Errorf("Response body was '%v'; want '%v'", expected, res.Body)
	}
}

func buildURL(path string) string {
	return urlFor("http", port, path)
}

func urlFor(scheme string, serverPort string, path string) string {
	return scheme + "://localhost:" + serverPort + path
}

func TestGetEnv(t *testing.T) {
	var value string
	key := "PORT"

	if value = os.Getenv(key); value != "" {
		os.Unsetenv(key)
		defer func() { os.Setenv(key, value) }()
	}

	if os.Getenv("TEST_GET_ENV") == "1" {
		getEnv(key)
		return
	}

	cmd := exec.Command(os.Args[0], "-test.run=TestGetEnv")
	cmd.Env = append(os.Environ(), "TEST_GET_ENV=1")
	err := cmd.Run()
	if e, ok := err.(*exec.ExitError); ok && !e.Success() {
		return
	}
	t.Errorf("getEnv() failed to fatal if env %q is not present", key)
}
