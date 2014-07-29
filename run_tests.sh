#!/bin/bash
bundle install

if [ -z "$1" ]
  then
    cucumber --tags ~@wip --tags ~@removed
else
    cucumber -r features $1
fi
