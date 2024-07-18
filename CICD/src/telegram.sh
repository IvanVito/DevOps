#!/bin/bash

TELEGRAM_BOT_TOKEN="7137946827:AAHdOtnfvwmA-M5LnWqQDDCg8lGJYM9N9og"
TELEGRAM_USER_ID="1427772572"
TIME="120"
URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"
TEXT="Stage:+$CI_JOB_STAGE%0A\
Stage status:+$1%0A\
URL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0A\
Branch:+$CI_COMMIT_REF_SLUG"

curl -s --max-time $TIME -d "chat_id=$TELEGRAM_USER_ID&\
disable_web_page_preview=1&text=$TEXT" $URL > /dev/null


if [ $1 == 'success' ] && [ $2 == 'CI' ] &&\
  [ $CI_JOB_STAGE == 'int_test' ]; then
  curl -s --max-time $TIME -d "chat_id=$TELEGRAM_USER_ID&\
  disable_web_page_preview=1&text=CI+SUCCESS" $URL > /dev/null
elif [ $1 == 'failed' ] && [ $2 == 'CI' ]; then
  curl -s --max-time $TIME -d "chat_id=$TELEGRAM_USER_ID&\
  disable_web_page_preview=1&text=%0ACI+FAILED%0ACD+FAILED\
  %0APIPELINE+FAILED" $URL > /dev/null
fi

if [ $1 == 'success' ] && [ $2 == 'CD' ]; then
  curl -s --max-time $TIME -d "chat_id=$TELEGRAM_USER_ID&\
  disable_web_page_preview=1&text=CD+SUCCESS%0APIPELINE+SUCCESS" $URL > /dev/null
elif [ $1 == 'failed' ] && [ $2 == 'CD' ]; then
  curl -s --max-time $TIME -d "chat_id=$TELEGRAM_USER_ID&\
  disable_web_page_preview=1&text=CD+FAILED%0APIPELINE+FAILED" $URL > /dev/null
fi



