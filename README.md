# Dir Info SDK Example
This is supposed to be a really simple example that gets the number of files and size of those files from a directory and sends as metrics.

# Parts of the SDK
Each SDK has 3 parts:
* Definition file: This YAML file tells NRI what the integration does
* Executable file: In this case it's a shell script dirInfo.sh
* Config file: The config tells NRI how the integration should run (for different directories)

# How this example works
This is intended to be a super simple example
* dirInfo.sh takes 1 parameter which is a directory name
* It runs linux commands to get file count and size of all the files
* Then it reads template.json and puts in those runtime values
* Our SDK wants no whitespace, so there's a command to remove it
* It returns the properly formatted JSON

# Installing this example
Run this command (sudo is required) to install the integration.
```
kahrens@envy5:~/dev/shell/dirInfo$ sudo sh install.sh
All required files copied.
Integration made into an executable.
Infrastructure service restarted
kahrens@envy5:~/dev/shell/dirInfo$
```

This installer places all the files in the correct locations and then restarts the `newrelic-infra` service. You can peek at the log (use verbose) to see if the integration is working properly.

# Access the data
The JSON that the integration sends back has the name of the event type in Insights where these metrics will be stored. This example puts data into `ComputeSample`. If you query Insights, you will see it:
SELECT average(`provider.dirSize`) FROM ComputeSample WHERE `provider.dirName` = '/var/log' SINCE 7 DAYS AGO TIMESERIES
