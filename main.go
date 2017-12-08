package main

import (
	"fmt"

	log "github.com/sirupsen/logrus"
)

func main() {
	fmt.Println("hello-world")
	log.WithFields(log.Fields{
		"animal": "walrus",
	}).Info("A walrus appears")
}
