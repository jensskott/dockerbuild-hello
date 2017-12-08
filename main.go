package main

import (
	"fmt"
	"net/http"

	log "github.com/sirupsen/logrus"
)

func main() {

	RegisterHealthCheck()

	fmt.Println("hello-world")
	log.WithFields(log.Fields{
		"animal": "walrus",
	}).Info("A walrus appears")
}

func health(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("ok"))
}

func RegisterHealthCheck() {
	http.HandleFunc("/health", health)
	http.ListenAndServe(":8080", nil)
}
