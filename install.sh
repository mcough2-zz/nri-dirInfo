#!/bin/sh

CUSTOM_INTEGRATIONS=/var/db/newrelic-infra/custom-integrations
ETC_CONFIG=/etc/newrelic-infra/integrations.d

# Create these directories if they don't exist
mkdir ${CUSTOM_INTEGRATIONS}/bin
mkdir ${CUSTOM_INTEGRATIONS}/templates

# Copy the config file to the integrations.d directory
cp ./config/dirInfo-config.yaml $ETC_CONFIG

# Copy the configuration file to the custom-integrations directory
cp ./definition/dirInfo-definition.yaml $CUSTOM_INTEGRATIONS

# Copy the template file to a template directory
cp ./templates/dirInfo-template.json ${CUSTOM_INTEGRATIONS}/templates

# Copy the shell script the bin directory
cp ./bin/dirInfo.sh ${CUSTOM_INTEGRATIONS}/bin
echo "All required files copied."

# Make sure the executable can be executed
chmod 755 ${CUSTOM_INTEGRATIONS}/bin/dirInfo.sh
echo "Integration made into an executable."

# Restart the newrelic-infra agent
service newrelic-infra restart
echo "Infrastructure service restarted"