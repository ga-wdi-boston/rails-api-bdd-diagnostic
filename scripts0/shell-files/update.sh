curl --include --request PATCH "https://aqueous-atoll-85096.herokuapp.com/games/${ID}" \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=${TOKEN}" \
  --data '{
          "game": {
            "cell": {
              "index": 2,
              "value": "x"
            },
            "over": false
          }
        }'

echo
