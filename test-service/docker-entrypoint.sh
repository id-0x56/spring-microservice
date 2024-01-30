#!/bin/sh
set -e

/usr/bin/gradle build
exec /opt/openjdk-19/bin/java -jar "$@"
