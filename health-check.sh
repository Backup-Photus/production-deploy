#!/bin/bash

# Get environment variables
MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD

# Perform health check
if mysqladmin ping -h localhost -u root -p$MYSQL_ROOT_PASSWORD; then
  exit 0  # Health check passed
else
  exit 1  # Health check failed
fi
