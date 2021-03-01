#!/bin/sh

# set up file name
fileBase=valheim
currentTime=$(date "+%Y.%m.%d-%H.%M.%S")
wholeFileName=${fileBase}_${currentTime}.zip

# backup world data
backupLocation=${HOME}/backup/valheim
target=/opt/valheim/data
destination=${backupLocation}/${wholeFileName}
zip -r ${destination} ${target}

# remove all but the 5 most recent backups
cd ${backupLocation}
ls -tp | grep -v '/$' | tail -n +6 | tr '\n' '\0' | xargs -0 rm --