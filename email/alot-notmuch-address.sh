#!/bin/sh
notmuch address --format=json %s | fzf
