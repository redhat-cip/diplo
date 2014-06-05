#!/bin/bash

function validate() {
        cmd=$1
	if [ ! -z $2 ] && [ $2 == "status" ]
	then
		if [ -f $DIR/plugins/$cmd/main.bash ]
                then
                	source $DIR/plugins/$cmd/main.bash
			status
			exit 0
		else
			error "Can't load the plugin"
			exit 1
		fi
	fi
	if [ ! -z $2 ]
	then
		workspace=$2
        	shift
        	shift
        	if [ -d $DIR/workspaces/$workspace ]
		then
			if [ -f $DIR/plugins/$cmd/main.bash ]
			then
				source $DIR/plugins/$cmd/main.bash
				func=$1
				shift
				$func $workspace $@
			else
				error "Can't load plugin"
				exit 1
			fi
        	else
        	        error "Workspace $workspace does not exist"
			exit 1
        	fi
	else
		if [ -f $DIR/plugins/$cmd ]
		then
			error "Missing parameters, use diplo help"
		else
			error "Plugin or command not found"
		fi
		exit 1
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

function update-plugins() {
	for i in `ls $DIR/plugins/`
	do
		if [ -d $DIR/plugins/$i ]
		then
			cd $DIR/plugins/$i
			git pull
			RETCODE=$?
			if [ $RETCODE -ne 0 ]
			then
				error "Something going wrong"
			else
				info "`basename $i` Successfuly updated"
			fi
		fi
	done
}
