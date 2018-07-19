#!/bin/bash

bins="$HOME/.local/bin/"
if [[ "$UID" = 0 ]]; then
	bins=/usr/local/bin/
fi

mkdir -p "$bins"

cp bin/github-do "$bins"
