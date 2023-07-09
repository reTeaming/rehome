#! /bin/bash

echo "APPLICATION_ID = '$1'" >>.env
echo "CLIENT_KEY = '$2'" | tee -a .env >/dev/null
