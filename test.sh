#!/usr/bin/env bash

set -ex
export NAME='Nonce'
bin/ts-gotpl test.tmpl | grep 'Hello Nonce!'
