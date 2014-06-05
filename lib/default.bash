#!/bin/bash

function info() {
	echo -e "[\033[1;34mINFO\033[0m] - $@"
}

function error() {
	echo -e "[\033[1;31mERROR\033[0m] - $@"
}

function debug() {
	if [ $DEBUG -eq 1 ]
	then
		echo -e "[\033[1;35mERROR\033[0m] - $@"
	fi
}
