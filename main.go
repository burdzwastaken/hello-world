package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

var (
	port string
	v    string
)

/*getEnv gets environment variables */
func getEnv(name string) string {
	if v = os.Getenv(name); v == "" {
		log.Fatalf("env %s is not set.", name)
	}
	return v
}

/*helloWorld serve text */
func helloWorld(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "yo yo world!")
}

/*main start webserver */
func main() {
	port = ":" + getEnv("PORT")

	fmt.Printf("Started server at http://localhost%v.\n", port)
	http.HandleFunc("/", helloWorld)
	log.Fatal(http.ListenAndServe(port, nil))
}
