#!/bin/bash

curl --include --request GET "https://aqueous-atoll-85096.herokuapp.com/games/${ID}" \
  --header "Content-type: application/json" \

  {
  "games": [
    {
      "id": 1,
      "cells": ["o","x","o","x","o","x","o","x","o"],
      "over": true,
      "player_x": {
        "id": 1,
        "email": "and@and.com"
      },
      "player_o": {
        "id": 3,
        "email": "dna@dna.com"
      }
    }


Alternatively
API="${API_ORIGIN:-https://ga-library-api.herokuapp.com}"
URL_PATH="/games/{$ID}"
curl "${API}${URL_PATH}" \
  --include \
  --request GET
echo
