#!/bin/bash

function info() {
	echo -e "[\033[1;34mINFO\033[0m] - $@"
}

function error() {
	echo -e "[\033[1;31mERROR\033[0m] - $@"
}

function debug() {
	[[ "${DEBUG:-0}" -eq 1 ]] && echo -e "[\033[1;35mDEBUG\033[0m] - $@"
}
