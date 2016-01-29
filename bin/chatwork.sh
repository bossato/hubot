#!/bin/sh

export HUBOT_CHATWORK_TOKEN=xxxxxx
export HUBOT_CHATWORK_ROOMS=xxxxxx
export HUBOT_CHATWORK_API_RATE=800

export NETATMO_CILIENT_ID=""
export NETATMO_CILIENT_SECRET=""
export NETATMO_USERNAME=""
export NETATMO_PASSWORD=""
export NETATMO_DEVICE_ID=""

hubot -a chatwork -n %bot_name%
