#!/bin/bash

ex_code=$BITRISE_BUILD_STATUS

IFS_ORIGINAL="$IFS"
IFS=,
arr=($SLACK_TARGETS)
IFS="$IFS_ORIGINAL"

if [ ${ex_code} -eq 0 ] ; then
  USER_NAME="$BITRISE_APP_TITLE - OK"
  ATTACHEMENTS="[{\"fallback\": \"$TASK_NAME: $BITRISE_BUILD_URL\",\"color\": \"$SLACK_COLOR\",\"pretext\": \"$TASK_NAME: <$BITRISE_BUILD_URL|#$BITRISE_BUILD_NUMBER> $GIT_CLONE_COMMIT_MESSAGE_SUBJECT\",\"text\": \"Scheme: $SCHEME($CONFIGURATION)\nSigned: $BITRISE_CODE_SIGN_IDENTITY \n\n$SLACK_ADDITIONAL_MESSAGE<$BITRISE_PUBLIC_INSTALL_PAGE_URL|Install>\"}]"
  EMOJI=':white_check_mark:'
else
  USER_NAME="$BITRISE_APP_TITLE - NG"
  ATTACHEMENTS="[{\"fallback\": \"$TASK_NAME: $BITRISE_BUILD_URL\",\"color\": \"$SLACK_COLOR\",\"pretext\": \"$TASK_NAME: <$BITRISE_BUILD_URL|#$BITRISE_BUILD_NUMBER> $GIT_CLONE_COMMIT_MESSAGE_SUBJECT\",\"text\": \"Scheme: $SCHEME($CONFIGURATION)\nSigned: $BITRISE_CODE_SIGN_IDENTITY\"}]"
  EMOJI=':no_entry_sign:'
fi

for v in "${arr[@]}"; do
  echo  $ATTACHEMENTS
  PAYLOAD="payload={\"channel\":\"$v\",\"username\":\"$USER_NAME\",\"attachments\":$ATTACHEMENTS,\"icon_emoji\":\"$EMOJI\"}"
  echo $PAYLOAD
  curl -X POST --data-urlencode \
      "$PAYLOAD" \
      $SLACK_WEBHOOK_URL
done

unset ATTACHEMENTS
unset EMOJI
unset PAYLOAD