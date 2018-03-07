#!/bin/sh

# Get the count of files in the directory
# find gets the list, wc counts the lines, tr trims whitespace
FILE_COUNT=`find "${DIR_NAME}" -type f | wc -l | tr -d ' '`

# Get the directory size, (note that cut breaks off the first field)
DIR_SIZE=`du "${DIR_NAME}" -b -s | cut -f1`

# Read in the JSON template
JSON=`cat ./templates/dirInfo-template.json`

# Replace the values in the JSON
# The @ in the sed command is a delimiter
# s@DIR_NAME@${DIR_NAME} replaces DIR_NAME from the JSON template
JSON=`echo ${JSON} | sed -e "s@DIR_NAME@${DIR_NAME}@"`
JSON=`echo ${JSON} | sed -e "s@FILE_COUNT@${FILE_COUNT}@"`
JSON=`echo ${JSON} | sed -e "s@DIR_SIZE@${DIR_SIZE}@"`

# Remove all the whitespace from the JSON
JSON=`echo ${JSON} | tr -d ' \t\n\r\f'`

# Print the result
echo "${JSON}"