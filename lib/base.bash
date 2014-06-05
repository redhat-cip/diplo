#!/bin/bash

function usage() {
        echo "Diplo Version : `cat $DIR/conf/diplo_version`"
        echo "Usage : diplo <action> [<params>]"
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
	info "Update in progress"
	cd $DIR
	git pull
	info "Update is done"
}
