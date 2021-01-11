#!/bin/zsh

MAILDIR=/naspool/Mail/

#move a message while removing mbsync tags
function safeMove { s=${1##*/}; s=${s%%,*}; mv -f $1 $2/$s;  }

#move mail to trash folder
echo "Moving $(notmuch count --output=files --exclude=false tag:deleted tag:killed AND NOT folder:local-trash) deleted messages to the trash folder"
for i in $(notmuch search --output=files --exclude=false tag:deleted tag:killed AND NOT folder:local-trash); do
  safeMove $i ${MAILDIR}/local-trash
done

#move mail to spam folder
echo "Moving $(notmuch count --output=files --exclude=false tag:spam AND NOT folder:local-spam) spam messages to the trash folder"
for i in $(notmuch search --output=files --exclude=false tag:spam AND NOT folder:local-spam); do
  safeMove $i ${MAILDIR}/local-spam
done

#move mail to archive folder
echo "Moving $(notmuch count --output=files --exclude=false tag:archive AND NOT folder:local-archive) deleted messages to the trash folder"
for i in $(notmuch search --output=files --exclude=false tag:archive AND NOT folder:local-archive); do
  safeMove $i ${MAILDIR}/local-archive
done

#update notmuch
notmuch new --no-hooks
