curl "http://tic-tac-toe.wdibos.com/sign-up" \
--include \
--request POST \
--header "Content-Type: application/x-www-form-urlencoded" \
--data-urlencode '{
  "credentials": {
    "email": "'"${EMAIL}"'",
    "password": "'"${PASSWORD}"'",
    "password_confirmation": "'"${PASSWORD_CONFIRMATION}"'"
  }
}'

echo
