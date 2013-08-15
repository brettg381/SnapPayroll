# SnapPayroll Web

A paycheck calculation web service.

## Requirements
grails 2.2.4 http://grails.org/download

## Development Setup

### Set ENV Variables
Set JAVA_HOME
    export JAVA_HOME=/Library/Java/Home
    export PATH="$PATH:$JAVA_HOME/bin"

Set GRAILS_HOME
    export GRAILS_HOME=/path/to/grails

Add grails bin to PATH
    export PATH="$PATH:$GRAILS_HOME/bin"

### Running the service
TODO

## Deploying to a Server

_Deploying SnapPayroll has currently only been tested in *tomcat 6* running on *RHEL 5*._

### Build the WAR file
From the top of the project directory use grails to build the WAR archive.
	grails war

### Copy the WAR file to the webapps directory on the server.
	scp snappayroll.war server:/path/to/tomcat6/webapps

### Restart the server to cause an unpack and deploy.
	sudo /sbin/service tomcat6 start