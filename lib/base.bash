#!/bin/bash

function usage() {
        echo "Diplo Version : alpha~0.0.1"
        echo "Usage : diplo <action> <params>"
        echo ""
        echo "------- Basic Diplo Actions -------"
        echo "  create        Create a new workspace"
	echo "  list          List all workspaces available"
        echo "  import        Import an existing workspace"
        echo "  go            execute a command on your workspace"
        echo "  update        Update diplo to the latest version"
        echo "  list-plugins  List all available plugins"
        echo "  install       Install a specific Plugin"
        echo "  help          Show this message"
        
	for i in `ls -1 $DIR/plugins`
        do
                if [ -f $DIR/plugins/$i/init ]
                then
                        source $DIR/plugins/$i/init
                        ${i}_help
                fi
        done
}

function update() {
	echo "Update in progress"
	cd $DIR
	git pull
	echo "Update is done"
}
