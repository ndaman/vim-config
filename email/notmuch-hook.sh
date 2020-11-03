#!/bin/sh
notmuch new
#re-tag new messages "inbox" and "unread"
notmuch tag +inbox +unread -new -- tag:new
#tag messages from me as sent
notmuch tag -new -inbox +sent -- from:Nicholas.A.Smith@wichita.edu
#add other automatic tagging here
