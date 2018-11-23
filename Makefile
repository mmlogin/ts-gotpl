VERSION ?= latest

.PHONY: build test dist

build:
	mkdir -p ./bin
	go build -o ./bin/ts-gotpl .

test:
	./test.sh

dist:
	rm -rf dist
	rm -f docker-gen-alpine-linux-*.tar.gz
	rm -f docker-gen-linux-*.tar.gz
	rm -f docker-gen-darwin-*.tar.gz

	mkdir -p dist/alpine-linux/amd64 && GOOS=linux GOARCH=amd64 go build -a -tags netgo -installsuffix netgo -o dist/alpine-linux/amd64/ts-gotpl .
	mkdir -p dist/linux/amd64 && GOOS=linux GOARCH=amd64 go build -o dist/linux/amd64/ts-gotpl .
	mkdir -p dist/linux/i386  && GOOS=linux GOARCH=386 go build -o dist/linux/i386/ts-gotpl .
	mkdir -p dist/linux/armel  && GOOS=linux GOARCH=arm GOARM=5 go build -o dist/linux/armel/ts-gotpl .
	mkdir -p dist/linux/armhf  && GOOS=linux GOARCH=arm GOARM=6 go build -o dist/linux/armhf/ts-gotpl .
	mkdir -p dist/darwin/amd64 && GOOS=darwin GOARCH=amd64 go build -o dist/darwin/amd64/ts-gotpl .
	mkdir -p dist/darwin/i386  && GOOS=darwin GOARCH=386 go build -o dist/darwin/i386/ts-gotpl .

	tar -cvzf ts-gotpl-alpine-linux-amd64-$(VERSION).tar.gz -C dist/alpine-linux/amd64 ts-gotpl
	tar -cvzf ts-gotpl-linux-amd64-$(VERSION).tar.gz -C dist/linux/amd64 ts-gotpl
	tar -cvzf ts-gotpl-linux-i386-$(VERSION).tar.gz -C dist/linux/i386 ts-gotpl
	tar -cvzf ts-gotpl-linux-armel-$(VERSION).tar.gz -C dist/linux/armel ts-gotpl
	tar -cvzf ts-gotpl-linux-armhf-$(VERSION).tar.gz -C dist/linux/armhf ts-gotpl
	tar -cvzf ts-gotpl-darwin-amd64-$(VERSION).tar.gz -C dist/darwin/amd64 ts-gotpl
	tar -cvzf ts-gotpl-darwin-i386-$(VERSION).tar.gz -C dist/darwin/i386 ts-gotpl
