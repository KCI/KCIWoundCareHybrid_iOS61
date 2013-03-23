#!/bin/bash

#Declare Key Variables
PROJECT_DIR=`pwd`
IOS_TARGET='5.1'
BINARY_NAME=`pwd | rev | cut -d '/' -f1 | rev`
SIMULATOR_PATH="~/Library/Application\ Support/iPhone\ Simulator/$IOS_TARGET/Applications/"
simulatorbase='' #By default, this is a random alphanumeric string that changes with each sim. install.

echo -e "Looking for binary in Simulator folders. . .\n"

#Determine Filepath for KCI App in Simulator


simulatorbase="$HOME/Library/Application Support/iPhone Simulator/$IOS_TARGET/Applications/"
# cd "$HOME/Library/Application\ Support/iPhone\ Simulator/6.0/Applications/E04FCC01-4848-4D49-838F-1D50C10A50C7/Documents/"

cd "$simulatorbase"

appdir=`find * -type f -iname "*KCI Wound Care*" | head -1 | cut -d "/" -f 1`
simulatorbase+="$appdir"

echo -e "Found Binary at: $simulatorbase \n"

cd "$simulatorbase"
#Bail if we don't already have a local cache.
#This means that we won't be able to make changes until 2nd "Build & Run".
if [ -z "$simulatorbase/Library/Caches/file__0.localstorage" ]; then
    echo -e "Bailing. . .No Cache to Bust.\n"
    exit 1;
fi

echo -e "Beginning Cache Bust. . .\n"

#"Bust" All Local Cache Files

rm "Documents/Data/config.json" "Documents/Data/content.json" "Library/Caches/file__0.localstorage" "Documents/Backups/localstorage.appdata.db"

#Add Symbolic Links from Local Cache to Code Checkout
#This is what will allow us to work directly from sourcecode checkout
#rather than having to make changes directly in the Simulator cache file
ln -s "$PROJECT_DIR/www/data/config.json" "$simulatorbase/Documents/Data/config.json"
ln -s "$PROJECT_DIR/www/data/content.json" "$simulatorbase/Documents/Data/content.json"

echo -e "Cache bust completed.\n"

cd "$PROJECT_DIR"