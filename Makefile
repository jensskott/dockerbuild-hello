.PHONY: all vet test build package clean dep docker

APP_NAME=hello-world
APP_VERSION=0.1
APP_BUILD=`git log --pretty=format:'%h' -n 1`
GO_FLAGS= CGO_ENABLED=0
GO_LDFLAGS= -ldflags="-X main.AppVersion=$(APP_VERSION) -X main.AppName=$(APP_NAME) -X main.AppBuild=$(APP_BUILD)"
GO_BUILD_CMD=$(GO_FLAGS) go build $(GO_LDFLAGS)
BUILD_DIR=build
BINARY_NAME=$(APP_NAME)

all: clean dep build package

dep:
	dep ensure && dep prune

vet:
	@go vet 

test:
	@go test 

build: vet test
	@mkdir -p $(BUILD_DIR)
	GOOS=linux GOARCH=amd64 $(GO_BUILD_CMD) -o $(BUILD_DIR)/$(BINARY_NAME)-linux-amd64
#	GOOS=darwin GOARCH=amd64 $(GO_BUILD_CMD) -o $(BUILD_DIR)/$(BINARY_NAME)-darwin-amd64
#	GOOS=windows GOARCH=amd64 $(GO_BUILD_CMD) -o $(BUILD_DIR)/$(BINARY_NAME)-windows-amd64

package:
	tar -C $(BUILD_DIR) -zcf $(BUILD_DIR)/$(BINARY_NAME)-$(APP_VERSION)-linux-amd64.tar.gz $(BINARY_NAME)-linux-amd64
#	tar -C $(BUILD_DIR) -zcf $(BUILD_DIR)/$(BINARY_NAME)-$(APP_VERSION)-darwin-amd64.tar.gz $(BINARY_NAME)-darwin-amd64
#	zip -q -j  $(BUILD_DIR)/$(BINARY_NAME)-$(APP_VERSION)-windows-amd64.zip $(BUILD_DIR)/$(BINARY_NAME)-windows-amd64

clean:
	rm -Rf $(BUILD_DIR)
	
docker: build package
	cp $(BUILD_DIR)/$(BINARY_NAME)-$(APP_VERSION)-linux-amd64.tar.gz /opt
	cp $(BUILD_DIR)/$(BINARY_NAME)-linux-amd64 /opt