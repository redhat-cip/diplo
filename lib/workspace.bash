#!/bin/bash

function import() {
	set -f; IFS=$'\n'
        for i in `cat $DIR/conf/workspaces.list | grep -v "^#"`
        do
                for j in `curl -sL $i`
                do
                        local name=`echo $j | awk -F';' '{print $1}'`
			local git=`echo $j | awk -F';' '{print $2}'`
			if [ $name == $1 ]
			then
				cd $DIR/workspaces
				git clone $git $name
				echo "Workspace $name imported"
				exit 0
			fi
                done
        done
	set +f; unset IFS
	echo "workspace not found"
	exit 1
}

function list() {
	set -f; IFS=$'\n'
	for i in `cat $DIR/conf/workspaces.list | grep -v "^#"`
	do
		for j in `curl -sL $i`
		do
			local name=`echo $j | awk -F';' '{print $1}'`
			local desc=`echo $j | awk -F';' '{print $3}'`
			if [ -d $DIR/workspaces/$name ]
			then
				echo "$name -- $desc (imported)"
			else
				echo "$name -- $desc"
			fi
		done
	done
	set +f; unset IFS
}

function go() {
	cd $DIR/workspaces/$1
	cmd=$2
	source go.cfg
	if [ $# -le 1 ]
	then
		workspace_help
		return 0
	fi
	if [ $cmd == "list" ]
	then
		workspace_help
		return 0
	fi
	shift
	shift
	$cmd $@	
}
