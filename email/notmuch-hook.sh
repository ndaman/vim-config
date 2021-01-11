#!/bin/sh
mbysnc wsu
notmuch new
#tag messages from me as sent
notmuch tag -new -inbox +sent -- from:Nicholas.A.Smith@wichita.edu
#add other automatic tagging here
