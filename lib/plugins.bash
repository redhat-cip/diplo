#!/bin/bash

function validate() {
        cmd=$1
	workspace=$2
        shift
        shift
        if [ -d $workspace ]
        then

                $cmd $workspace $@
        else
                echo "Project does not exist"
        fi
}

function list-plugins() {
	for i in `cat $DIR/conf/plugins.list | grep -v "^#"`
	do
		for j in "`curl -sL $i`"
		do
			local name=`echo $j | awk -F';' '{print $1}'`
			local desc=`echo $j | awk -F';' '{print $3}'`
			if [ -d $DIR/plugins/$name ]
			then
				echo "$name -- $desc (installed)"
			else
				echo "$name -- $desc"
			fi
		done
	done
}

function pinstall() {
        for i in `cat $DIR/conf/plugins.list | grep -v "^#"`
        do
                for j in "`curl -sL $i`"
                do
                        local name=`echo $j | awk -F';' '{print $1}'`
			local git=`echo $j | awk -F';' '{print $2}'`
			if [ $name == $1 ]
			then
				cd $DIR/plugins
				git clone $git $name
				echo "Plugin $name installed"
				exit 0
			fi
                done
        done
	echo "Plugin not found"
	exit 1
}
