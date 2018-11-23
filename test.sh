#!/usr/bin/env bash

set -ex
export NAME='Nonce'
bin/ts-gotpl hello.tmpl | grep 'Hello Nonce!'
