#!/bin/bash

function import() {
        for i in `cat $DIR/conf/workspaces.list | grep -v "^#"`
        do
                for j in "`curl -sL $i`"
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
	echo "workspace not found"
	exit 1
}

function list() {
	for i in `cat $DIR/conf/workspaces.list | grep -v "^#"`
	do
		for j in "`curl -sL $i`"
		do
			local name=`echo $j | awk -F';' '{print $1}'`
			local desc=`echo $j | awk -F';' '{print $3}'`
			if [ -d $DIR/workspaces/$name ]
			then
				echo "$name -- $desc (installed)"
			else
				echo "$name -- $desc"
			fi
		done
	done
}
