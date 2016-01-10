#!/bin/sh

export HUBOT_CHATWORK_TOKEN=xxxxxx
export HUBOT_CHATWORK_ROOMS=xxxxxx
export HUBOT_CHATWORK_API_RATE=800

hubot -a chatwork -n bot_name
